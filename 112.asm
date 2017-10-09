assume cs:code , ss:stack 

stack segment

	db 10 dup (0)


stack ends 





code segment

	start:
	
			mov ax,stack 
			mov ss,ax
			mov sp,10
			
			
			pushf
			
			pop ax 
			or ax,0800h   ;  0000100000000000b
			
			push ax 
			 
			popf
			
			
			
			
			



		mov ax,4c00h
		int 21h
		
		
		
		
		

		
		
		
		
		
		
		
		

code ends

end start 