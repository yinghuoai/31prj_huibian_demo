assume cs:codesg


	
	
	
	codesg segment
	
		
		

	start:	
	    mov ax,0000h
		mov ds,ax
		mov bx,0000h
		mov cx,256
	  s:
		mov dl,[bx]
		mov dh,0
		
		mov ax,0h
		cmp dx,10h
		jz zero
		jmp jia
zero:
		inc ax
		
		jmp jia
		
		
	jia:
		inc bx
		
		
		loop s
		
		

       
		
		
		mov ax,4c00h
		int 21h
	
	codesg ends
	end start
	
	
	
