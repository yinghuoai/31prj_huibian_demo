assume cs:code , ds:data


data segment
	
	db "Beginner's All-purpose Symbolic Instruction Code.",0




data ends



code segment

	start:
	
			mov ax,data
			mov ds,ax
			mov si,0
			call letterc 
			
			

jieshu:

		mov ax,4c00h
		int 21h
		
		
		
		
		
	letterc:
			
		cmp byte ptr ds:[si],0
		jz jieshu
		
		cmp byte ptr ds:[si],'a'
		jnb shangjie
		
		inc si
		jmp letterc
		
		shangjie:
		cmp byte ptr ds:[si],'z'
		jnz manzu
		
		inc si
		jmp letterc
				
		
		manzu:
		
		sub byte ptr ds:[si],20h
		inc si 
		jmp letterc 
		
		
		
		
		
		
		
		

code ends

end start 