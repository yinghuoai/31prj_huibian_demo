assume cs:code,ds:data

data segment
		DB 10 dup(0)
	    ;在数据段开辟一段空间存放数据转换后的字符串  
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'  
        db '1984','1985','1986','1987','1988','1989','1990','1991','1992'  
        db '1993','1994','1995'  
        ;以上是表示21年的21个字符串  
        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514  
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000  
        ;以上是表示21年公司总收的21个dword型数据  
        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226  
        dw 11542,14430,45257,17800  
        ;以上是表示21年公司雇员人数的21个word型数据  
		dw 5,3,42,104,85,210,123,111,105,125,140,136,153,211,199,209,224,239,260
		dw 304,333
		;以上是表示21年公司雇员人均收入的21个word型数据
 
data ends




code segment

start:

		mov ax,12666
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