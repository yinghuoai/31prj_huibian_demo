assume cs:code 




code segment

start:




	call jiemian
	
	mov ax,4c00h
	int 21h


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

code ends 
end start

