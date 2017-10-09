assume cs:code 


code segment

start:

	call setclock
	
	mov ax,4c00h
	int 21h 
	
	
	rdkb0: 
			mov ah,0  ;读取键盘一个输入，同时清除缓冲区  
			int 16h   ;注意此时，键盘没有输入则会等待输入  
			ret  

	rdkb1:
			mov ah,1  ;读取键盘一个输入，不清除缓冲区   
			int 16h   ;此时，此时不会等待键盘输入  
			ret  


	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




setclock: 

		jmp clkconf ;设置时钟  
      
     
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
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	  
	  
	  
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
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	  
	  
	  
	  
        charstack: jmp short charstart  
      
            table  dw charpush,charpop,charshow  
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
                   jmp word ptr table[bx]  
      
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

				   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


			





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			   
				







code ends 

end start