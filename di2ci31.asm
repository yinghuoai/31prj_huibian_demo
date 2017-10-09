assume cs:codesg


	
	
	
	codesg segment
	
		
		

	start:	
	    mov ax,0ffffh
		mov ds,ax
		mov bx,0000h
		mov cx,8
	  s:
		mov dl,[bx]
		mov dh,0
		
		add dx,dx
		mov ax,0020h
		mov ds,ax
		
		add bx,bx
		
		mov [bx],dx
		mov ax,0ffffh
		mov ds,ax
		
		shr bx,1
		
		inc bx
		
		
		loop s
		
		mov ax,4c00h
		int 21h
	
	codesg ends
	end start
	
	
	
