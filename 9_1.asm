assume cs:code,ds:data

data segment
 DB 'Welcome to masm!',0

data ends




code segment

start:

		mov dh,8
		mov dl,3
		mov cl,2
		mov ax,data
		mov ds,ax
		mov si,0
		
		

		call show_str
	
	jieshu:	mov ax,4c00h
		int 21h
		
		
	  show_str:
		mov ax,0b800h
		mov es,ax
		mov ax,160
		mul dh   ;160*8,即结果存放在ax中，此处ax就是第八行的第一个字节处的对应的显存位置的偏移地址
		mov dh,0
		mov bx,ax 
		mov di,dx ;由于dh归零，所以此处di为dl即列的数值，即3
		
		add di,di ;这里是因为屏幕中的第三列对应第3个字符,但是实际上却是第6个字节之后开始输入，也就是偏移地址6开始
		mov ax,0 
		
		bijiao:		
		mov al,ds:[si]
		cmp al,0
		jz jieshu
		mov es:[bx+di],al
		mov es:[bx+di+1],cl
		inc si
		add di,2

        jmp bijiao
		
		
	    



code ends

end start