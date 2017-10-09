assume cs:code , ds:data 

data segment

	db 10 dup (0)


data  ends 





code segment

	start:
	
			mov ax,0 

			
			mov al,1eh			   ;+98
			sub al,9eh	           ;-99

			

			
			
			
			
			



		mov ax,4c00h
		int 21h
		
		
		
code ends

end start 
		