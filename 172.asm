;实验17  编写包含多个功能子程序的中断例程

;安装一个新的 int 7ch 中断例程,用逻辑扇区号对软盘进行读写

;用ah寄存器传递功能号,0表示读,1表示写

;用dx寄存器传递要读写的扇区的逻辑扇区号

;用es:bx指向存储读出数据或者写入数据的内存区



assume cs:code

 

data segment

    db 32 dup ("welcome to masm!")     

data ends

   

code segment

start:

    ;安装新的 int 7ch 中断

    push cs

    pop ds

    mov si,offset new_int7ch_start 

    mov ax,0

    mov es,ax

    mov di,200h

    mov cx,offset new_int7ch_end-offset new_int7ch_start

    cld

    rep movsb

       

    ;设置新的中断向量表

    cli

    mov word ptr es:[4*7ch],200h

    mov word ptr es:[4*7ch+2],0

    sti

   

    ;测试新的 int 7ch 中断

    mov ax,data

    mov ds,ax

   

    ;写

    push ds ;es:bx指向要写的单元

    pop es

    mov bx,0

   

    mov dx,0

    mov al,1

    mov ah,1

    int 7ch

   

    ;读      ;es:bx指向要读的单元

    mov ax,2000h    ;读到2000:0处

    mov es,ax

    mov bx,0

   

    mov dx,0

    mov al,1

    mov ah,0

    int 7ch

   

    mov ax,4c00h

    int 21h

   

    ;新的 int 7ch 中断

;-----------------------------------------------------------------------------------   

;功能:用逻辑扇区号对软盘进行读写

;参数:   (ah)=功能号,0=读,1=写;(dx)=要读写的扇区的逻辑扇区号,(al)=读取或写入的扇区数

;       es:bx指向存储读出数据或者写入数据的内存区

;返回:同 int 7ch 的返回,操作成功:(ah)=0,(al)=读入或写入的扇区数,操作失败:(ah)=错误代码  

    newint7 proc near

    new_int7ch_start:

    jmp new_int7ch_real_start

    table dw sub0-newint7+200h,sub1-newint7+200h

   

    new_int7ch_real_start:

    push dx

    push cx

    push si

    mov cl,ah

    mov ch,0

    shl cx,1

    mov si,cx

    call convert

    call word ptr cs:[table-newint7+200h+si]

    jmp new_int7ch_ret

   

    sub0:

    ;不能在子程序中再来pop!!因为在调用子程序的时候会压入ip

    ;此时pop会导致一系列不可预知的错误

    mov dl,0

    mov ah,02

    int 13h 

    ret

   

    sub1:

    mov dl,0

    mov ah,03

    int 13h

    ret

   

    new_int7ch_ret:

    pop si

    pop cx

    pop dx

    iret

   

    convert:

    ;-------------------------------------------------------------------------------   

    ;功能:根据逻辑扇区号计算物理扇区号

    ;参数:(dx)=逻辑扇区号(0~2879)

    ;返回:(dh)=面号(0,1),(ch)=磁道号(1~79),(cl)=扇区号(1~18)

    push ax

    mov ax,dx

    mov dx,0

    mov cx,1440

    div cx      ;(ax)=面号

    mov dh,al 

    push dx

    mov ax,dx

    mov dx,0

    mov cx,18

    div cx      ;(ax)=磁道号

    mov ch,al

    add dx,1    ;(dx)=扇区号

    mov cl,dl

    pop dx

    pop ax

    ret

    ;-------------------------------------------------------------------------------   

   

    new_int7ch_end:

    nop

    newint7 endp

;-----------------------------------------------------------------------------------   

code ends

end start