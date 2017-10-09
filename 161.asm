assume cs:code 


code segment

start:
	mov ax,cs
	mov ds,ax 
	mov si,offset begin
	mov ax,0
	mov es,ax 
	mov di,204h
	mov cx,offset beginend-offset begin 
	cld
	rep movsb
	
	
	push es:[9*4]
	pop es:[200h]
	push es:[9*4+2]
	pop es:[202h]
	
	
	
	mov ax,0
	mov es,ax
    cli	
	mov word ptr es:[9*4],200h
	mov word ptr es:[9*4+2],0
	sti 
	
	
	
	mov ax,4c00h
	int 21h
	
	
	 
	
	;org 200h
	
	
begin:
	call choose
	
	jmp ok
	

	
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	
	
choose:


    jmp chse
	fun dw fun0,fun1,fun2,fun3
	
	chse:
	push ax 
	push bx
	push cx 
	push es 
	
	
	in al,60h
	
	;mov bx,0 
	;mov cs,bx 
	
	
	pushf 
	call dword ptr cs:[200h]
	
	cmp al,0bh
	je dofun0
	
	cmp al,02h
	je dofun1 
	
	
	cmp al,03h
	je dofun2 
	
	
	cmp al,04h
	je dofun3 
	
	jmp chseret
	
	
	
	
	
dofun0:
	call fun0
	jmp chseret



dofun1:
	call fun1
	jmp chseret
	


dofun2:
	call fun2
	jmp chseret




dofun3:
	 
	 
	call fun3
	jmp chseret
	 
	
	 
	
	
	
	
	chseret:
	
	pop es 
	pop cx 
	pop bx 
	pop ax 
	
	ret	

	

	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
fun0:
		push bx
		push cx 
		push es 
		mov bx,0b800h
		mov es,bx 
		mov bx,0 
		mov cx,2000
	s0:
		mov byte ptr es:[bx],' '
		add bx,2 
		loop s0 
		pop es 
		pop cx 
		pop bx 
		ret 
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		
fun1:

		push bx 
		push cx 
		push es 
		
		mov bx,0b800h
		mov es,bx 
		mov bx,1
		mov cx,2000
	s1:
		and byte ptr es:[bx],11111000b
		or es:[bx],al 
		add bx,2 
		loop s1 
		
		pop es 
		pop cx 
		pop bx 
		ret 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
fun2:
		push bx 
		push cx 
		push es 
		
		
		mov cl,4 
		shl al,cl 
		mov bx,0b800h
		mov es,bx 
		mov bx,1 
		mov cx,2000
	s2:
		and byte ptr es:[bx],10001111b
		or es:[bx],al 
		add bx,2 
		loop s2 
		
		pop es 
		pop cx 
		pop bx 
		ret 
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
fun3:
		push cx 
		push si
		push di 
		push es 
		push ds 
		
		
		mov si,0b800h
		mov es,si 
		mov ds,si 
		mov si,160
		mov di,0 
		cld 
		mov cx,24
	s3:
		push cx 
		mov cx,160
		rep movsb
		
		pop cx 
		loop s3
		
		mov cx,80
		mov si,0 
	clear:
		mov byte ptr ds:[160*24+si],' '
		add si,2 
		loop clear 
		
		
		pop ds 
		pop es 
		pop di 
		pop si 
		pop cx 
		ret 
		
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		
	ok:
	iret
		
beginend:
	nop
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	







code ends 
end start