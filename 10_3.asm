assume cs:code,ds:data

data segment
 DB 10 dup(0)

data ends




code segment

start:

		mov ax,23765
		mov dx,0
		mov bx,data
		mov ds,bx

		mov si,4
		call dtoc
	jixu:	
		
		
		mov dh,8
		mov dl,3
		mov cl,2	
		mov si,0
		call show_str
	
	jieshu:	mov ax,4c00h
			int 21h
		
		
	dtoc:
		
		
		
		s:
		mov cx,10
		call divdw
		
		add cx,30h
		mov ds:[si],cl
		dec si
		cmp ax,0
		jz jixu
		jmp s
		
		
			
		
		
		
	show_str:
		mov ax,0b800h
		mov es,ax
		mov ax,160
		mul dh   ;160*8,即结果存放在ax中，此处ax就是第八行的第一个字节处的对应的显存位置的偏移地址
		mov dh,0
		mov bx,ax 
		mov di,dx ;此处di为dl即列的数值，即3
		
		add di,di ;这里是因为屏幕中的第三列对应第3个字符,但是实际上却是第6个字节之后开始输入，也就是偏移地址6开始
		mov ax,0 
		
	bijiao:		
		
		mov al,ds:[si]
		cmp si,5
		jz jieshu
		mov es:[bx+di],al
		mov es:[bx+di+1],cl
		inc si
		inc dx
		
		add di,2

        jmp bijiao
		
		
	divdw:
	 
	push ax
	mov ax,dx
	mov dx,0
	div cx
	mov bx,ax
	pop ax 
	div cx
	mov cx,dx
	mov dx,bx 
	
	ret   



code ends

end start