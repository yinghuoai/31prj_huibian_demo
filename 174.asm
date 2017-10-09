assume cs:code 

data segment
db 'hello world!'


data ends


code segment

start:


	mov ax,cs
	mov ds,ax 
	mov si,offset fun0
	mov ax,0
	mov es,ax 
	mov di,200h
	mov cx,offset fun0-offset fun0end  
	cld
	rep movsb
	
	
	mov ax,0
	mov es,ax 
	mov word ptr es:[7ch*4],200h
	mov word ptr es:[7ch*4+2],0
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	
	mov bx,0 
	mov ax,0b800h ;;;;data
	mov es,ax 
	
	mov dx,0 
	mov ah,1
	int 7ch 
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov ax,4c00h
	int 21h 
	
	
	
	org 200h 
	
fun0:
	jmp short set
	table dw read,write

	
	
	
set:
	push bx 
	cmp ah,1 
	ja jieshu
	mov bl,ah 
	mov bh,0
	add bx,bx 	
	call word ptr table[bx]
	
	
jieshu:
	pop bx 
	iret 
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
read:
	push cx 
	mov ax,dx 
	mov dx,0 
	mov cx,1440
	div cx 
	mov bx,dx ;余数给bx,继续除法
	mov dh,al 
	mov cl,18 
	mov ax,bx ;余数继续除法
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
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
write:
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

