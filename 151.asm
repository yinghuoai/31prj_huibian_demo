assume cs:code 

stack segment
	db 128 dup(0)

stack ends



code segment

start:
	mov ax,stack 
	mov ss,ax 
	mov sp,128 
	
	


	
	;;;;;;;;;;;;;;;;;;;;save the old cs,ip
	
	mov ax,0
	mov ds,ax 
	push ds:[9*4]
	pop ds:[200]
	push ds:[9*4+2]
	pop ds:[202]
	
	

	;;;;;;;;;;;;;;copy the code to 0:204 处
	push cs
	pop ds 
	
	mov ax,0 
	mov es,ax 
	
	
	mov si,offset int9begin
	mov di,204
	mov cx,offset int9end-int9begin
	cld 
	rep movsb 
	
	mov ax,0 
	mov ds,ax 
	
	;;;;;;;;;;;;;;;;;;;;;new int9
	cli
	mov word ptr ds:[9*4],204
	mov word ptr ds:[9*4+2],0
	
	sti
	
	
	mov ax,4c00h
	int 21h
	
	
	;;;;;what is int9
	int9begin:
	
	push ax 
	push es 
	push si 
	push di 
	push cx 
	
	
	
	;;press a to AAAAAA
	in al,60h
	
	mov bx,0 
	mov ds,bx
	
	pushf 
	call dword ptr ds:[200]
	
	
	
	cmp al,9eh
	jne jieshu
	
	
show:
	
	mov ax,0b800h
	mov es,ax 
	mov si,0 
	mov cx,2000
	
	s:
	
	mov byte ptr es:[si],41h
	
	add si,2 
	
	
	loop s
	
	
	
	

	
	
	
	
	
	jieshu:
	
	
	
	pop cx 
	pop di 
	pop si 
	pop es 
	pop ax 
	iret
	
	
	int9end:
	nop 





code ends
end start
