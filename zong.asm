    ;本程序主要分为3部分：  
    ;1、把程序复制到软盘  
    ;2、把软盘从第二个扇区开始读入内存  
    ;3、系统程序，实现本课程设计的4个要求  
    code segment  
    assume cs:code  
            start:  ;把install1复制到软盘的第一个扇区  
                    mov ax,install1  
                    mov es,ax  
                    mov bx,0  
                    mov ah,3  
                    mov al,1  
                    mov ch,0  
                    mov cl,1  
                    mov dh,0  
                    mov dl,0  
                    int 13h  
                    ;从第二个扇区开始，把install2全部复制到软盘  
                    mov ax,install2  
                    mov es,ax  
                    mov bx,0  
                    mov ah,3  
                    mov al,15  
                    mov cl,2  
                    int 13h  
                      
                    mov ax,4c00h  
                    int 21h  
    code ends  
      
    install1 segment  ;负责把主程序从软盘的第二个扇区开始全部读入内存  
    assume cs:install1  
                    mov ax,2000h  
                    mov es,ax  
                    mov ah,2  
                    mov al,15  
                    mov ch,0  
                    mov cl,2  
                    mov dh,0  
                    mov dl,0  
                    mov bx,0  
                    int 13h  
      
                    mov ax,2000h  
                    push ax  
                    mov ax,0  
                    push ax  
                    retf  
      
                    mov ax,4c00h  
                    int 21h  
    install1 ends  
    install2 segment  
    assume cs:install2  
        ;主程序实现4个小功能  
            ready:  jmp short main  
      
            table   dw resetpc, startos, clock, setclock  
               
             main:  
                    call manu  
                    call rdkb0  
                    cmp ah,02  
                    jb main  
                    cmp ah,05  
                    ja main  
                    mov al,ah  
                    mov ah,0  
                    sub al,2  
                    add al,al  
                    mov bx,ax  
                    call word ptr table[bx]  
                    jmp short main  
                    mov ax,4c00h  
                    int 21h  
      
             rdkb0: mov ah,0  ;读取键盘一个输入，同时清除缓冲区  
                    int 16h   ;注意此时，键盘没有输入则会等待输入  
                    ret  
      
             rdkb1: mov ah,1  ;读取键盘一个输入，不清除缓冲区   
                    int 16h   ;此时，此时不会等待键盘输入  
                    ret  
      
          resetpc:  call clear     ;重启计算机  
                    mov ax,0ffffh  
                    push ax  
                    mov ax,0  
                    push ax  
                    retf  
      
          startos:  call clear     ;引导操作作系统  
                    mov ax,0  
                    mov es,ax  
                    mov bx,7c00h  
                      
                    mov al,1  
                    mov ch,0  
                    mov cl,1  
                    mov dh,0  
                    mov dl,80h  
      
                    mov ah,2  
                    int 13h  
                   
                    mov ax,0  
                    push ax  
                    mov ax,7c00h  
                    push ax  
                    retf  
        
            clock:  jmp short showclock0    ;显示时钟  
      
          clkchar:  db 'xx/xx/xx xx:xx:xx',0  
          clkaddr:  db 9,8,7,4,2,0  
      
       showclock0:    
                    push ds  
                    push bp  
                    push bx  
                    push cx  
                    push ax  
                    push es  
                    push di  
                    push dx  
      
                    call clear  
                    mov dl,2  
      
       showclock1:    
                    push cs  
                    pop ds  
                    mov bp,offset clkchar  
                    mov bx,offset clkaddr  
                    mov cx,3  
             clks:  push cx  
                    mov al,[bx]  
                    out 70h,al  
                    in al,71h  
                    mov ah,al  
                    mov cl,4  
                    shr ah,cl  
                    and al,00001111b  
                    add ah,30h  
                    add al,30h  
                    mov ds:[bp],ah  
                    mov ds:[bp+1],al  
                    inc bx  
                    add bp,3  
                    pop cx  
                    loop clks  
      
                    mov cx,3  
            clks2:  push cx  
                    mov al,[bx]  
                    out 70h,al  
                    in al,71h  
                    mov ah,al  
                    mov cl,4  
                    shr ah,cl  
                    and al,00001111b  
                    add ah,30h  
                    add al,30h  
                    mov ds:[bp],ah  
                    mov ds:[bp+1],al  
                    inc bx  
                    add bp,3  
                    pop cx  
                    loop clks2  
      
                    mov ax,0b800h  
                    mov es,ax  
                    mov di,12*160+20*2  
                    mov bx,offset clkchar  
           clks4:   mov cl,[bx]  
                    mov ch,0  
                    jcxz clks3  
                    mov es:[di],cl  
                    mov es:[di+1],dl  
                    inc bx  
                    add di,2  
                    jmp short clks4  
      
           clks3:   call rdkb1  
                    cmp al,1bh  
                    je clks5  
                    cmp ah,3bh  
                    je clks6  
           clks7:   jmp near ptr showclock1  
           clks6:   call rdkb0  
                    inc dl  
                    jmp near ptr showclock1  
           clks5:   call rdkb0  
                    call clear  
                    pop dx  
                    pop di  
                    pop es  
                    pop ax  
                    pop cx  
                    pop bx  
                    pop bp  
                    pop ds  
                    ret  
      
         setclock: jmp near ptr clkconf ;设置时钟  
      
      instruction:  db '             Warning!             ',0  
                    db 'Please strictly follow the example',0  
                    db '      yy/mm/dd hh:mm:ss           ',0  
        clocktemp:  db 20 dup (0)  
          setaddr:  db 9,8,7,4,2,0  
          clkconf:  push ax  
                    push bx  
                    push cx  
                    push dx  
                    push bp  
                    push si  
                    push di  
                    push ds  
                    push es  
                    call clear  
                    push cs  
                    pop ds  
                    
                    mov ax,0b800h  
                    mov es,ax  
                    mov di,10*160+20*2  
                    mov bx,offset instruction  
      
                    mov cx,3  
          strs3:    push cx  
                    mov bp,0  
          strs2:    mov cl,[bx]  
                    mov ch,0  
                    jcxz strs1  
                    mov es:[di+bp],cl  
                    mov byte ptr es:[di+bp+1],4  
                    inc bx  
                    add bp,2  
                    jmp short strs2  
            strs1:  pop cx  
                    inc bx  
                    add di,160  
                    loop strs3  
      
                    mov si,offset clocktemp  
                    mov dh,13  
                    mov dl,26  
                    call getstr  
                
                    mov bx,offset clocktemp  
                    mov bp,offset setaddr  
      
                    mov cx,6  
            strs4:  push cx  
                    mov ch,0  
                    mov cl,4  
                    mov ah,[bx]  
                    mov al,[bx+1]  
                    sub ah,30h  
                    sub al,30h  
                    shl ah,cl  
                    add ah,al  
                    mov al,ds:[bp]  
                    out 70h,al  
                    mov al,ah  
                    out 71h,al  
                    pop cx  
                    add bx,3  
                    inc bp  
                    loop strs4  
         rdagain:   call rdkb0  
                    cmp al,1bh  
                    jne rdagain  
                    call clear  
                    pop es  
                    pop ds  
                    pop di  
                    pop si  
                    pop bp  
                    pop dx  
                    pop cx  
                    pop bx  
                    pop ax  
                    ret  
      
         getstr:    push ax  
      
         getstrs:   mov ah,0  
                    int 16h  
                    cmp al,20h  
                    jb nochar  
                    mov ah,0  
                    call charstack  
                    mov ah,2  
                    call charstack  
                    jmp getstrs  
      
         nochar:    cmp ah,0eh  
                    je backspace  
                    cmp ah,1ch  
                    je enter  
                    jmp getstrs  
        backspace:  mov ah,1  
                    call charstack  
                    mov ah,2  
                    call charstack  
                    jmp getstrs  
         enter:     mov al,0  
                    mov ah,0  
                    call charstack  
                    mov ah,2  
                    call charstack  
                    pop ax  
                    ret  
      
        charstack: jmp short charstart  
      
            table2  dw charpush,charpop,charshow  
             top    dw 0  
      
        charstart: push bx  
                   push dx  
                   push di  
                   push es  
      
                   cmp ah,2  
                   ja sret  
                   mov bl,ah  
                   mov bh,0  
                   add bx,bx  
                   jmp word ptr table2[bx]  
      
         charpush: mov bx,top  
                   mov [si][bx],al  
                   inc top  
                   jmp sret  
      
         charpop:  cmp top,0  
                   je sret  
                   dec top  
                   mov bx,top  
                   mov al,[si][bx]  
                   jmp sret  
      
         charshow: mov bx,0b800h  
                   mov es,bx  
                   mov al,160  
                   mov ah,0  
                   mul dh  
                   mov di,ax  
                   add dl,dl  
                   mov dh,0  
                   add di,dx  
      
                   mov bx,0  
      
        charshows: cmp bx,top  
                   jne noempty  
                   mov byte ptr es:[di],' '  
                   jmp sret  
          noempty: mov al,[si][bx]  
                   mov es:[di],al  
                   mov byte ptr es:[di+1],2  
                   mov byte ptr es:[di+2],' '  
                   inc bx  
                   add di,2  
                   jmp charshows  
            sret:  pop es  
                   pop di  
                   pop dx  
                   pop bx  
                   ret  
      
      
                    
      
             manu:  jmp short show  
                    db '1) reset pc',0  
                    db '2) start system',0  
                    db '3) clock',0  
                    db '4) set clock',0  
                                                            
             show:  push ds  
                    push si  
                    push ax  
                    push es  
                    push bx  
                    push cx  
                    push di  
      
                    push cs  
                    pop ds  
                    mov si,offset manu  
                    add si,2  
                    mov ax,0b800h  
                    mov es,ax  
                    mov bx,12*160+25*2  
      
                    mov cx,4  
              s3:   push cx  
                    mov di,0  
              s1:   mov cl,[si]  
                    mov ch,0  
                    jcxz s2  
                    mov es:[bx+di],cl  
                    mov byte ptr es:[bx+di+1],2  
                    inc si  
                    add di,2  
                    jmp short s1  
              s2:   pop cx  
                    inc si  
                    add bx,160  
                    loop s3  
      
                    pop di  
                    pop cx  
                    pop bx  
                    pop es  
                    pop ax  
                    pop si  
                    pop ds  
                    ret                               
                                                                  
            clear:  push ax  
                    push es  
                    push cx  
                    push si  
                      
                    mov ax,0b800h  
                    mov es,ax  
                    mov cx,2000  
                    mov si,0  
         clears:    mov byte ptr es:[si],' '  
                    add si,2  
                    loop clears  
                    mov cx,2000  
                    mov si,1  
        clears2:    mov byte ptr es:[si],07  
                    add si,2  
                    loop clears2  
                      
                    pop si  
                    pop cx  
                    pop es  
                    pop ax  
                    ret  
      
      
             
    install2 ends  
      
      
    end start  
	
	
	
	
	
	
	
	小结：

非常激动，第一次，自己写了一个类似开机引导的的小程序。在这里要感谢网友shiying的程序分享。在我的程序中，参考了他编写的安装程序的结构，以及子程序中的一些小细节。在整个过程中，我自己遇到的几个大问题归结如下。本程序可能还是有很多小问题，但是整体已经实现所要求的内容。
问题1、程序无法编译，或者编译出现一系列错误
原因：我把安装程序和系统程序全都放在了code段中。这样做非常紊乱，自己分不清，何况编译器，所以把要安装的子程序放到es段中。此外，bios开机只会把软盘的第一个扇区复制到内存，所以，这里有两种做法，把系统程序从第一个扇区开始安装，此外在第一个扇区一进来就把剩余的扇区读入内存。第二种做法，也就是第一个扇区只做一件事，把剩余的扇区读入到内存，最后跳转到读入内存的起始地址。我使用了第二种做法，这样的好处就是我不管第一个扇区末尾的地址在哪里，因为第二个扇区的读入地址非常重要，此时如果读错，程序将跑飞，所以使用第二种做法就不会有这种问题。
问题2、开机后可以显示table界面，但是无法引导操作系统
原因：我在进入主程序前定义了一个128B的栈段。删掉我定义的这个栈后就可以引导操作系统。我觉得可能的原因是bios默认的栈段是一个很大的空间，至少可以满足int中断例程的开销。但是当我们重新定义了一个栈段后，由于栈空间太小，导致调用bios的中断程序的时候不够用。总结：在我们自己系统程序中，不要定义栈，因为虽然我们自己写的子程序栈的大小可以满足，但是调用bios的中断程序不知道栈要开销多少，所以，不定义栈也就是使用bios的默认栈。另外，平时写的程序没有发生这种问题原因是：1、本身程序小栈空间用的少；2、程序本身是运行在操作系统上，操作系统有自己的保护机制。
问题3、程序在不清屏下，可以引导操作系统，但是加入清屏程序后，进入操作系统后屏幕全黑，光标也不见。
原因：我在清屏程序中，对字符的属性设置成了0，即背景，前景全为0。实际上清屏中对字符属性设置应该为07h，而不是0。可能原因是操作系统的背景设置是0，前景为111，这样在系统中看起来就是屏幕是黑色，字符是白色。如果设置成了全0，这样字符就看不见了，这就导致屏幕全黑，光标和字符全都看不见。
问题4、可以显示时间，刷新时间有问题，只能改变颜色的时候刷新一次。
原因：我在读取键盘的时候给ah的参数为0，也就是读取键盘缓冲区之后，清除缓冲区该数值，注意，如果缓冲区为空，则程序一直在循环读取键盘缓冲区，直到缓冲区有数据。这就导致了按下改变颜色能刷新一次，但是不按时间一直显示不变。解决方法就是，配合使用缓冲区的另一种读法，给ah=0，即读取缓冲区时，不清除缓冲区。
问题5、键盘无输入读出的扫描码和ESC键扫描码相同
解决方法：扫描码不行，那就读字符码，这两个的字符码不同，从al读。
问题6、主程序进入子程序的时候没有问题，但是子程序回到主程序中，程序跑飞。
原因：我在主程序中进入子程序是用jmp word ptr table[bx]。使用这句进入子程序非常危险，因为它没有保存当前的ip值，也就是没有push ip。当子程序ret时候，相当于pop ip 此时整个程序的栈空间就崩溃了，所以程序跑飞。
总结：凡是涉及到栈空间的使用都要非常小心，除了明显可以看出来的push和pop,跳转指令jmp、返回指令ret、retf、调用指令call都会对栈有影响。栈空间如果没有平衡，程序就会跑飞，所以当程序跑飞的时候，可以考虑对栈空间的使用进行检查。
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	