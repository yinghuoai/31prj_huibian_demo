assume cs:code 



code segment

start:
	
	mov ah,0
	;mov al,44h
	int 7ch
	
	
	
	mov ax,4c00h
	int 21h
	







code ends 
end start