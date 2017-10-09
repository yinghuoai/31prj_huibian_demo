assume cs:codesg


	codesg segment
	
start:
	mov ax,0b800h
	mov ds,ax
	mov ds:[068ah],814ch
	mov ds:[068ch],8249h
	mov ds:[068eh],835ah
	mov ds:[0690h],8448h
	mov ds:[0692h],8549h
	mov ds:[0694h],8659h
	mov ds:[0696h],8755h
	
	
	mov bx,068ah
	
     mov cx,2
	 
	 s0:
	   mov si,0
	   mov ax,814ch
       mov [bx+si],ax
	   add si,2
	   mov ax,8249h
	   mov [bx+si],ax
	   add si,2
	   mov ax,835ah
	   mov [bx+si],ax
	   add si,2
	   mov ax,8448h
	   mov [bx+si],ax
	   add si,2
	   mov ax,8549h
	   mov [bx+si],ax
	   add si,2
	   mov ax,8659h
	   mov [bx+si],ax
	   add si,2
	   mov ax,8755h
	   mov [bx+si],ax
	   
	   
	   mov cx,0ffffh
	   s1:
	     nop
		 nop
		 nop
		 nop

	   
	   
	   loop s1
	   
	   
	   
	   mov si,0
	   mov ax,0020h
	   
	   
	   mov cx,7
	   s4:
	   mov [bx+si],ax
	   add si,2

	   
	   loop s4
	   
	   mov cx,0ffffh
	   s3:
	     nop
		 nop
		 nop
		 nop

	   
	   
	   loop s3
	   
	   
	   

	   cmp bx,0640h
	   jz fan
	   
	   sub bx,2
	   
	   jmp jixu
	   
	   
	   
	fan:
	   mov bx,06d0h
	
	   jmp jixu
	   
	jixu:  
	 
	 
	mov cx,2
	loop s0
	 
	
	
	
	
	
	
	
	mov ax,4c00h
	int 21h

	
	
	codesg ends
	
	end start