assume cs:code 


code segment

start:

	call startOs

	mov ax,4c00h
	int 21h 
	




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
startOs:  
		call clear     ;引导操作系统  
		mov ax,0  
		mov es,ax  
		mov bx,7c00h  
		  
		mov al,1  
		mov ch,0  
		mov cl,1  
		mov dh,0  
		mov dl,80h  

		mov ah,2  
		int 13h  
	   
		mov ax,0  
		push ax  
		mov ax,7c00h  
		push ax  
		retf  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


clear: 
		push ax  
		push es  
		push cx  
		push si  
		  
		mov ax,0b800h  
		mov es,ax  
		mov cx,2000  
		mov si,0  
clears:    
		mov byte ptr es:[si],' '  
		add si,2  
		loop clears  
		mov cx,2000  
		mov si,1  
clears2:    
		mov byte ptr es:[si],07  
		add si,2  
		loop clears2  
		  
		pop si  
		pop cx  
		pop es  
		pop ax  
		ret  














code ends 

end start





	;mov ax,0
	;mov es,ax 
	;mov bx,7c00h
	
	;mov al,156
	;mov ch,0
	;mov cl,1
	;mov dl,80h
	;mov dh,0
	;mov ah,2 
	;int 13h 


	;mov ax,7c00h 
	;mov ds:[0],ax 
	;mov word ptr ds:[2],0
	;jmp dword ptr ds:[0]









