assume cs:codesg


	
	
	
	codesg segment
	
		
		

	start:	
	   
		cmp ax,0h
		jz zero
		mov bx,2h
		jmp s
		
zero:
		mov bx,1h
		jmp s
		
		
		
		
		
		
		

       
		s:
		
		mov ax,4c00h
		int 21h
	
	codesg ends
	end start
	
	
	
