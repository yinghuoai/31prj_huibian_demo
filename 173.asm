assume cs:code 

data segment
db 'hello world!'


data ends


code segment

start:
	mov ax,0 
	mov es,ax 
	mov word ptr es:[7ch*4],offset fun0
	mov word ptr es:[7ch*4+2],cs
	
	mov bx,0 
	mov ax,data 
	mov es,ax 
	mov dx,0 
	mov ah,1
	int 7ch 
	
	
	mov ax,4c00h
	int 21h 
	
fun0:
	jmp short set
	table dw re,wr 

set:
	push bx 
	cmp ah,1 
	ja ok 
	mov bl,ah 
	mov bh,0
	add bx,bx 
	call word ptr table[bx]
ok:
	pop bx 
	iret 
	
re:
	push cx 
	mov ax,dx 
	mov dx,0 
	mov cx,1440
	div cx 
	mov bx,dx 
	mov dh,al 
	mov cl,18 
	mov ax,bx 
	div cl 
	mov ch,al 
	add ah,1 
	mov cl,ah 
	mov dl,0 
	mov al,1 
	mov ah,2 
	int 13h 
	
	pop cx 
	
	ret 
	
wr:
	push cx 
	
	mov ax,dx 
	mov dx,0 
	mov cx,1440 
	div cx 
	mov bx,dx 
	mov dh,al 
	mov cl,18 
	mov ax,bx 
	div cl 
	mov ch,al;磁道号
	add ah,1 
	
	mov cl,ah ;扇区号
	mov dl,0 
	mov al,1 
	mov ah,3
	int 13h 
	
	pop cx 
	
	ret 
	
	
fun0end:
	nop
	
	





code ends 
end start

