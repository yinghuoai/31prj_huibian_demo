assume cs:codesg





codesg segment

	start:
	
	    
		mov bx,0h
		
		mov si,0h
		mov cx,0ffffh
	s:	
	
		
	
	
		mov dx,0b800h
		mov ds,dx
		
		mov al,ds:[si]
		cmp al,61h
		jz gaibian
		jmp jixu
		
		
	gaibian:
		mov ah,84h

		mov ds:[si],ax
		
		jmp jixu
		
	jixu:	
		
		
		add si,2
	    
	   
	   
	
		
		
		
		
		loop s
		
		

		
		
        mov ax,4c00h
        int 21h
	      
	
codesg ends

end start