assume cs:codesg,ds:datasg,ss:stacksg
	datasg segment
	
	datasg ends
	
	
	stacksg segment
	
	
	stacksg ends

	
	
	
	codesg segment
	
		
		

	start:	
	    mov ax,1000h
		mov ds,ax
		mov bx,0h
		mov cx,8
	  s:
		mov dx,[bx]
		mov ax,2000h
		mov ds,ax
		mov [bx],dx
		mov ax,1000h
		mov ds,ax
		add bx,2
		
		
		loop s
		
		mov ax,4c00h
		int 21h
	
	codesg ends
	end start
	
	
	
