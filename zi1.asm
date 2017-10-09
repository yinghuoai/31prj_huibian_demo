assume  cs:code 



code segment

start:



	call resetpc
	
	
	mov ax,4c00h
	int 21h
	
	;;;;;;;;;;;;;;;;;;;;;;;;
	

	;;;;;;;;;;;;;;;;;;;;;;;;;3
	
	
resetpc: 

	call clear     ;重启计算机  
	mov ax,0ffffh  
	push ax  
	mov ax,0  
	push ax  
	retf  

	
clear: 
			push ax  
			push es  
			push cx  
			push si  
			  
			mov ax,0b800h  
			mov es,ax  
			mov cx,2000  
			mov si,0  
clears:    mov byte ptr es:[si],' '  
			add si,2  
			loop clears  
			mov cx,2000  
			mov si,1  
clears2:    mov byte ptr es:[si],07  
			add si,2  
			loop clears2  
			  
			pop si  
			pop cx  
			pop es  
			pop ax  
			ret  


code ends 
end start













	;push bp 
	;push bx 
	
	;;;;;;;;;;;;;;;;;;;1
	;pushf 
	;mov bp,sp 
	;mov bx,0
	;mov [bp+2],bx 
	;mov bx,0ffffh
	;mov [bp+4],bx  
	
	;popf 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	
	;pop bx 
	;pop bp  
	
	;;;;;;;;;;;;;;;;;;2
	;mov ax,0 
	;mov ds:[0],ax 
	;mov word ptr ds:[2],0ffffh
	;jmp dword ptr ds:[0]
	
	









