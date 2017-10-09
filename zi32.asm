assume cs:code 

code segment
           

start:


             main:  
                    call jiemian 
                    call rdkb0  

					
					call clock  
					
                    jmp main  
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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
jiemian:

	jmp short show  
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
			mov si,offset jiemian  
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








;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

clock:  jmp short showclock0    ;显示时钟  
      
		time   db 9,8,7,4,2,0
		
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
					
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


			
					
					
					
code ends 

end start
					
					
					
					