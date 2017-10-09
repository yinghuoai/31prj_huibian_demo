assume cs:sys

sys segment


start:
   

    ;隐藏光标

    mov ah,01h

    mov cx,3030h 

    int 10h

    mov cx,offset endshow-offset sys_start

 

    sys_start:

    jmp show_menu

    date db "00/00/00 00:00:00",0           ;日期字符串

    date_input db "00/00/0000:00:00",0 ;用户输入的日期字符串,当输入不正确或者退出输入时,

                                            ;可以避免改变原始日期

    date_pos db 0,2,4,7,8,9             ;定位 cmos ram   中日期各项的地址

    date_char_pos db 15,12,9,6,3,0          ;定位日期字符串中各项的位置

    date_color db 2

    ;提示字符串

    press_esc   db "press esc toreturn menu",0

    press_f1    db "press f1 tochange color",0

    input_date  db "input a datein the form of yy/mm/dd hh:mm:ss,press enter to end input",0

    option1 db "1) reset pc",0

    option2 db "2) start system",0

    option3 db "3) clock",0

    option4 db "4) set clock",0

    ;直接定址表

    table dw sub1,sub2,sub3,sub4

   

    ;列出功能选项

    show_menu:

    call cls

    push cs

    pop ds

    mov si,offset option1 

    mov dx,0

    mov cl,2

    call show_str

    inc dh

    mov si,offset option2

    call show_str

    inc dh

    mov si,offset option3

    call show_str

    inc dh

    mov si,offset option4

    call show_str

   

    get_input:

    mov ah,0        ;获取键盘输入

    int 16h

   

    sub al,30h

    cmp al,1

    jb  get_input

    cmp al,4

    ja  get_input

    mov bl,al

    dec bl          ;1~4转化为0~3

    mov bh,0

    shl bx,1

    call word ptr cs:table[bx] ;进入子程序

    jmp show_menu

   

    ;重新启动计算机

    sub1:

    mov ax,0ffffh

    push ax

    mov ax,0h

    push ax

    retf

   

    ;引导硬盘现有的操作系统

    sub2:

    call cls

   

    mov ax,0

    mov es,ax

    mov bx,7c00h

    push ax

    push bx

   

    mov dl,80h

    mov dh,0

    mov ch,0

    mov cl,1

    mov al,1

    mov ah,2

    int 13h     ;读入硬盘0面0道1扇区的内容到0:7c00h

    retf            ;cs:ip指向0:7c00h   

   

    ;循环显示时间

    sub3:

    ;清屏,显示提示字符串,设置读取日期的循环次数及各项的起始地址

    call cls

    pre_show_date:

    ;输出提示信息 

    mov si,offset press_esc

    mov dx,0

    mov cl,date_color

    call show_str

    mov si,offset press_f1

    mov dx,0100h

    call show_str

   

   

    mov cx,6            ;循环次数=6

    mov di,offset date_pos ;di用来定位需要读取的cmos rom的单元

    mov bx,offset date_char_pos  ;bx用来定位日期各项的位置

   

    ;读取字符串

    read_date:

    push cx         ;保存循环次数

    ;读取日期的一项,放置到日期字符串相应的位置

    mov al,[di]     ;cmos rom 日期的某单元

    out 70h,al          ;向端口70h写入要访问的单元的地址

    in al,71h           ;从端口71h获得要写入al的数据

    call bcd2ascii;bcd码转化为数字的ascii码,(ah)=十位的ascii码,(al)=个位的ascii码

    push ax         ;压入(ax),因为后面还要传送到date,而紧接着改变了(ax)

    mov al,[bx]     ;(al)=日期某项的位置

    mov ah,0            ;(ah)置零

    mov si,ax           ;si指向日期字符串某项的位置

    pop ax              ;恢复(ax)

    mov byte ptr date[si],ah    ;传送

    mov byte ptr date[si+1],al

    inc di              ;di+1,定位到下一个单元        

    inc bx              ;bx+1,定位到date字符串下一个位置

    pop cx              ;恢复循环次数

    loop read_date      ;继续传送日期的下一项到date

   

    ;显示日期字符串,ds:si指向字符串首地址

    mov dx,0300h  

    mov cl,date_color 

    mov si,offset date 

    call show_str 

   

    sub3_input:

    mov ah,1            ;获取键盘输入,非阻塞 

    int 16h

    jz pre_show_date  ;缓冲区无按键

    cmp al,1bh          ;esc
	

    je sub3_ret

    cmp ah,3bh          ;f1

    je  chg_color

    jmp clear_buffer 

    chg_color:

    inc date_color

   

    clear_buffer:

    mov ah,0            ;16h中断的1号功能不会清除键盘缓冲区，下次读取还会读出

    int 16h             ;调用0号功能清除一次

   

    call delay

    jmp pre_show_date

   

    sub3_ret:

    mov ah,0            ;16h中断的1号功能不会清除键盘缓冲区，下次读取还会读出

    int 16h             ;调用0号功能清除一次

    mov cl,2

    mov date_color,cl

    ret

   

    ;修改当前日期、时间

    sub4:

    call cls

    ;输出提示信息

    mov si,offset press_esc

    mov dx,0

    mov cl,2

    call show_str

    mov si,offset input_date

    mov dx,0100h

    call show_str

   

    ;设置字符栈的位置,获取日期输入前的准备

    mov si,offset date_input 

    mov dx,0300h        ;显示的位置

   

    get_date:

    mov ah,0

    int 16h

    cmp al,20h          ;空格

    je push_char

    cmp al,3ah          ;冒号

    je push_char

    cmp al,2fh

    jb no_date      ;ascii码小于2fh,说明不是数字或斜杠'/' 

    cmp al,39h

    ja no_date          ;ascii码大于39h,说明不是数字或斜杠'/'

   

    push_char:

    mov ah,0

    call charstack      ;字符入栈

   

    mov ah,2

    call charstack      ;字符串显示

    jmp get_date

   

    no_date:

    cmp ah,0eh          ;退格

    je backspace

    cmp ah,1ch          ;enter

    je press_enter

    cmp al,1bh          ;esc

    je esc_sub4 

    jmp get_date

   

    backspace:

    mov ah,1

    call charstack      ;字符出栈

    mov ah,2

    call charstack      ;字符串显示

    jmp get_date

   

    esc_sub4:           ;退出sub4,date字符串的内容未被改变

    mov ah,0

    call charstack

    jmp sub4_ret

   

    press_enter:

    mov al,0

    mov ah,0

    call charstack      ;0入栈

 

    mov ah,2

    call charstack      ;字符串显示

   

    ;完成输入,复制 date_input 的内容到 date

    mov si,offset date_input

    push cs

    pop es

    mov di,offset date

    mov cx,18

    rep movsb

   

    mov cx,6            ;循环次数=6

    mov di,offset date_pos ;di用来定位需要读取的cmos rom的单元

    mov bx,offset date_char_pos  ;bx用来定位日期各项的位置

   

    set_date:

    push cx         ;保存循环次数

    ;读取日期的一项,放置到日期字符串相应的位置

    mov al,[di]     ;cmos rom 日期的某单元

    out 70h,al          ;向端口70h写入要访问的单元的地址

    mov al,[bx]

    mov ah,0

    mov si,ax

    mov ah,date[si] ;传送日期项的内容

    mov al,date[si+1]

    call ascii2bcd      ;两位数字的ascii码转化为bcd码(ah的高4位=十位,ah的低4位=个位)

    out 71h,al      ;将日期项的bcd码写入到cmos rom

    inc di              ;di+1,定位到下一个单元        

    inc bx              ;bx+1,定位到date字符串下一个位置

    pop cx              ;恢复循环次数

    loop set_date       ;继续传送日期的下一项到date

   

    sub4_ret:

    ret

   

;--------------------------------------------------------------------------------------------

;功能:在指定的位置，用指定的颜色，显示一个用0结尾的字符串。

;参数:(dh)=行号(0~24),(dl)=列号(0~79),(cl)=颜色,ds:si指向字符串的首地址。

;返回:无

    show_str:

    push ax             ;保护现场

    push es

    push dx

    push di

    push si

    mov ax,0b800h       ;显示缓冲区段地址

    mov es,ax           ;(es)=显示缓冲区段地址

    mov al,0a0h         ;以下计算初始字符的偏移地址

    mul dh              ;行数×0a0h(160个字节)

    mov di,ax           ;转移到di中

    mov al,2            ;显示缓冲区中一个字符占两个字节空间

    mul dl              ;2×列号

    add di,ax           ;获得初始字符的偏移地址

    s:

    mov ax,ds:[si]      ;输出字符到显示缓冲区

    mov es:[di],ax

    inc di              ;准备写入颜色信息

    mov es:[di],cl      ;写入颜色信息

    inc si              ;准备输出下一个字符

    push cx             ;保存颜色=(cl)

    mov cx,ds:[si]      ;(cx)=下一个字符

    mov ch,0            ;!!!若ds:[si]的低位字节为零，但其高位字节不为零,

                        ;!!!则程序不能如期望的那样跳转到end_show

    jcxz end_show       ;不为零则继续输出，为零则结束子程序

    pop cx              ;恢复颜色=(cl)

    inc di              ;准备写入下一个字符

    jmp s               ;输出下一个字符

    end_show:

    pop cx              ;!!!如果(cx)≠0,就会跳转到这里,此时(cx)在栈中还没有弹出

                        ;!!!如果不弹出就会引发错误

    pop si              ;恢复现场

    pop di

    pop dx

    pop es

    pop ax

    ret

;--------------------------------------------------------------------------------------------

   

;--------------------------------------------------------------------------------------------

;功能:清屏

;参数:无

;返回:无

    cls:

    push ax

    push cx

    push di

    push es

    mov ax,0b800h

    mov es,ax

    mov di,0

    mov cx,2000

   

    cls_s:

    mov byte ptr es:[di],0 ;为什么把byte改成word会引发崩溃?

    ;然而等我写好了程序再把 byte 改成 word ，发现并不会崩溃，但

    ;一开始最精简的程序又会崩溃，显示不出来东西，这又是为什么呢？

    ;问题待查

    inc di

    inc di

    loop cls_s

   

    ;恢复颜色

    mov di,1

    mov cx,2000

    reset_color:

    mov byte ptr es:[di],7

    inc di

    inc di

    loop reset_color

   

    pop es

    pop di

    pop cx

    pop ax

    ret

;--------------------------------------------------------------------------------------------

 

;--------------------------------------------------------------------------------------------

;功能:把一个byte、两位数的bcd码转变成2个byte的ascii码

;参数:(al)=十进制两位数的bcd码(十位=高4位的bcd码,个位=低4位的bcd码)

;返回:(ah)=十位的ascii码,(al)=个位的ascii码 

    bcd2ascii:

    push cx     ;保存用到的寄存器

    mov ah,al       ;al中的bcd码复制一份到ah中

    mov cl,4        ;右移4位,取得月份十位的值

    shr ah,cl       ;(ah)=月份十位的值

    and al,00001111b;(al)=月份个位的值

    add ah,30h      ;(ah)=月份十位的ascii码

    add al,30h      ;(al)=月份个位的ascii码

    pop cx          ;恢复用到的寄存器

    ret         ;返回

;--------------------------------------------------------------------------------------------

 

;--------------------------------------------------------------------------------------------

;功能:把2个byte的ascii码转变成一个byte、两位数的bcd码

;参数:(ah)=十位的ascii码,(al)=个位的ascii码

;返回:(al)=十进制两位数的bcd码(十位=高4位的bcd码,个位=低4位的bcd码) 

    ascii2bcd:

    push cx     ;保存用到的寄存器

    sub ah,30h      ;(ah的低4位)=月份十位的bcd码

    sub al,30h      ;(al的低4位)=月份个位的bcd码

    mov cl,4        ;左移4位

    shl ah,cl       ;(ah的高4位)=月份十位的bcd码

    or ah,00001111b ;(ah低4位)置1

    or al,11110000b ;(al高4位)置1

    and al,ah       ;(al)=十进制两位数的bcd码

    pop cx          ;恢复用到的寄存器

    ret         ;返回

;--------------------------------------------------------------------------------------------

 

;--------------------------------------------------------------------------------------------

;功能:产生延时

;参数:无

;返回:无

    delay:

    push ax

    push dx

    mov dx,1000

    mov ax,0   

    delay_s: 

    sub ax,1

    sbb dx,0 

    cmp ax,0

    jne delay_s

    cmp dx,0

    jne delay_s

 

    pop dx

    pop ax

    ret         ;返回

;--------------------------------------------------------------------------------------------

 

;字符栈

;--------------------------------------------------------------------------------------------

;功能:0号:字符入栈 1号:字符出栈 2号:显示栈中的字符

;参数:   (ah)=功能选择,(al)=入栈的字符,ds:si指向字符栈空间

;       (dh)=显示的行位置,(dl)=显示的列位置

;返回:(al)=出栈的字符

    charstack:

    jmp charstart

   

    char_table  dw charpush,charpop,charshow

    top         dw  0

       

    charstart:

    push bx

    cmp ah,2

    ja sret     ;没有对应的功能号,结束子程序

    ;调用相应的子功能 

    mov bl,ah

    mov bh,0

    shl bx,1

    call word ptr char_table[bx]

   

    ;限制输入的长度,如果超过了日期字符串的长度,将top置为0

    cmp top,18

    jne sret

    mov top,0

   

    sret:

    pop bx

    ret

   

    ;字符入栈,(al)=入栈的字符 

    charpush:

    cmp al,1bh      ;如果是esc

    je esc_input    ;跳转到esc_input

    push bx

    mov bx,top

    mov [bx][si],al ;字符入栈

    mov byte ptr 1[bx][si],0

    inc top     ;top指向新的栈顶

    pop bx

    jmp charpush_ret

   

    esc_input: 

    mov top,0       ;top置为0

   

    charpush_ret:

    ret

   

    ;字符出栈,(al)=出栈的字符

    charpop:

    push bx

    cmp top,0       ;是否已到栈底

    je charpopret   ;是则不出栈,结束子功能 

    dec top     ;top指向要出栈的字符

    mov bx,top

    mov al,[bx][si] ;字符出栈

    mov byte ptr [bx][si],' '

    charpopret:

    pop bx

    ret

   

    ;ds:si指向字符栈空间,(dh)=显示的行位置,(dl)=显示的列位置

    charshow:

    push ax

    push bx

    push dx

    push di

    push es

    ;使es:si指向显示的位置,ds:si指向字符栈空间

    mov bx,0b800h

    mov es,bx

    mov al,160

    mul dh

    mov di,ax

    mov al,dl

    shl al,1

    mov ah,0

    add di,ax  

   

    mov bx,0

   

    charshows:

    cmp top,0

    je set_cursor       ;处理删除最后一个字符的事件

    cmp bx,top

    je endshow

    mov al,[bx][si]

    mov es:[di],al

    mov es:[di+2],byte ptr ' '

    inc bx

    inc di

    inc di

    jmp charshows

   

    set_cursor:

    mov byte ptr es:[di],' '

       

    endshow:   

    pop es

    pop di

    pop dx

    pop bx

    pop ax

    ret

;--------------------------------------------------------------------------------------------

 

sys ends

;============================================================================================

 

   

;安装过程的第一行指令

end start


