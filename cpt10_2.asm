assume cs:code,ds:data

data segment
		

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
		DB 10 dup(0)
		
		
data ends




code segment

start:


		mov bx,data
		mov ds,bx
		
		mov bx,0 
		mov si,0
		mov di,0
				
		mov dl,07h	
		mov ax,0b800h
		mov es,ax

		call show_str
				
	jieshu:
		
		mov ax,4c00h
		int 21h	
		
		
	show_str:	
		
		mov cx,21
				
		s1:
		
		mov al,ds:[bx]
		mov es:[si],al
		mov es:[si+1],dl
		
		mov al,ds:[bx+1]
		mov es:[si+2],al
		mov es:[si+3],dl
		
		
		mov al,ds:[bx+2]
		mov es:[si+4],al
		mov es:[si+5],dl
		
		mov al,ds:[bx+3]
		mov es:[si+6],al
		mov es:[si+7],dl
		
		
		

		
		call dotc1
		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		
	jixu1:		
		;pop es:[si+40]
		;mov es:[si+40+1],dl
		
		
		
		
		
		
		
		call clear
		
		call dotc2
				
	jixu2:
		;mov ax,[di+21*4*2]
		;mov es:[si+80],ax
		
		call clear 
		call dotc3
	

	jixu3:
		;mov ax,[di+21*10]
		;mov es:[si+120],ax
		
		
		add bx,4 
		add di,2 
		add si,160 
		
		
		
		
		loop s1 
		jmp jieshu 
	
	
	

	
	
		
	bijiao1:		
		push cx
		push bp 
		push di
		mov cx,9
		
		
		s6:
		mov di,cx
		mov al,ds:[di+21*12]

		mov es:[si+bp+40],al
		mov es:[si+bp+40+1],dl
		
		dec di
		add bp,2
		loop s6
		
		
		pop di
		pop bp 
		pop cx

        jmp jixu1
		
		
		
		
	dotc1:	

		mov bp,0
	    mov ax,ds:[bx+21*4]
		mov dx,ds:[bx+21*4+2]
	
		s2:
		mov cx,10

		call divdw
		
		add cx,30h
		mov ds:[bp+21*12],cl
		inc bp
		
		cmp ax,0
		jz bijiao1
		
		
		
		
		jmp s2
		
		
		
		
	bijiao2:		
		push cx
		push bp 
		push di
		mov cx,9
		mov bp,0
		
		s7:
		
		mov di,cx
		mov al,ds:[di+21*12]

		mov es:[si+bp+80],al
		mov es:[si+bp+80+1],dl
		
		dec di
		add bp,2
		
		
		loop s7
		
		
		pop di
		pop bp 
		pop cx

        jmp jixu2
				
				
	dotc2:
		
		mov bp,0
		mov ax,ds:[bx+21*8]
		mov dx,0 
		

		
		s3:
		mov cx,10

		call divdw
		
		add cx,30h
		mov ds:[bp+21*12],cl
		inc bp 
		
		
		cmp ax,0
		jz bijiao2
		jmp s3		
		
		
bijiao3:		
		push cx
		push bp
		push di
		mov cx,9
		mov bp,0
		
		s8:
		
		mov di,cx 
		mov al,ds:[di+21*12]

		mov es:[si+bp+120],al
		mov es:[si+bp+120+1],dl
		
		
		
		
		dec di  
		add bp,2
		loop s8
		
		
		pop di 
		pop bp 
		pop cx

        jmp jixu3
				
				
	dotc3:
		mov bp,0 
		mov ax,ds:[bx+21*10]
		mov dx,0 	
	
		s9:
		mov cx,10

		call divdw
		
		add cx,30h
		mov ds:[bp+21*12],cl
		inc bp
		
		cmp ax,0
		jz bijiao3
		jmp s9				
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
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
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	    
		
		
		
		
		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	clear:
			push cx
			push si
			mov cx,10
			mov si,0
			s5:
				mov byte ptr ds:[si+21*12],32h
				inc si 
			
			
			loop s5
			pop si 
			pop cx
	
		ret 
	
	


code ends

end start