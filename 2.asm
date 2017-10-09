assume cs:abc

	abc segment
	
start:	mov ax,abc

	
		mov ax,4c00h
		int 21h
	
	abc  ends
	
	end start