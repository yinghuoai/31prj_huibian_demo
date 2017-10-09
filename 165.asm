assume cs:code 


code segment

	
	 
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	fun ,fun0 =7
	
	
	
begin:


    jmp  short chse
    a dw offset fun0-offset begin+200h,offset fun1-offset begin+200h,offset fun2-offset begin+200h,offset fun3-offset begin+200h    ;;;;地址：020ch--0214h
	
	;dw fun0,fun1,fun2,fun3 
	
	chse:
	;;;;;;;;;;;;;;;;0:215h
	push dx
	push bx
	cmp ah,3
	ja chseret
	mov bl,ah 
	mov bh,0
	add bx,bx 
	
	

	mov ax,0 
	mov es,ax 

	
	call word ptr a[bx+200h];此处显示"cs:"？？？;;;0:222:原语句：call [bx+0036]
	chseret:
	pop bx 
	pop dx
	
		
	jmp ok

	

	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
fun0:				;;;;;;;;;;0:228
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
			
		
		
		
		
		
		
		
		
		
		
		
		

start:
	mov ax,cs
	mov ds,ax 
	mov si,offset begin
	mov ax,0
	mov es,ax 
	mov di,200h
	mov cx,offset beginend-offset begin 
	cld
	rep movsb
	
	
	mov ax,03
	mov es,ax 
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	
	
	
	mov ax,4c00h
	int 21h
			
		
		
		
		
	







code ends 
end start 