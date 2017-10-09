assume cs:code
data segment
		
		db '1975','1976','1977','1978','1979','1980','1981','1982','1983'  
        db '1984','1985','1986','1987','1988','1989','1990','1991','1992'  
        db '1993','1994','1995'  
        ;以上是表示21年的21个字符串  
        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514  
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000  
        ;以上是表示21年公司总收的21个dword型数据  
        dd 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226  
        dd 11542,14430,45257,17800  
        ;以上是表示21年公司雇员人数的21个word型数据  
		dd 5,3,42,104,85,210,123,111,105,125,140,136,153,211,199,209,224,239,260
		dd 304,333
		;以上是表示21年公司雇员人均收入的21个word型数据
		DB 10 dup(20h)
data ends


stack segment

DB 100 dup(0)

stack ends 



code segment

start:
		mov ax,data 
		mov ds,ax 
	
		mov ax,0b800h
		mov es,ax
		
		mov bx,0
		
	
		mov dl,02h
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
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		add bx,4 
		add si,160 

	    loop s1 
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		call clear
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

mov dl,02h
mov bx,0 
mov si,0
mov di,0
mov ax,0 
mov cx,0 
mov dx,0



mov cx,21				
s2:		
		
			
		mov ax,ds:[bx+21*4]
		mov dx,ds:[bx+21*4+2]
		
		push di
		push ax 
		push cx 
		push dx
		push bx
		
		
		call dtoc
		



			mov di,9
			mov bx,0 
			mov cx,10
			
					s9:
					mov dl,02h
					mov al,ds:[di+21*16]
					mov es:[si+bx+40],al
					mov es:[si+bx+40+1],dl

					
					dec di
					add bx,2
					
					
					loop s9
		
		pop bx	
		pop dx
		pop cx 
		pop ax 
		pop di
		
	
		add bx,4 

		add si,160 

		
		    
		
		 call clear 
		
		
loop s2 		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
	   

		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		call clear
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

mov dl,02h
mov bx,0 
mov si,0
mov di,0
mov ax,0 
mov cx,0 
mov dx,0



mov cx,21				
s3:		
		
			
		mov ax,ds:[bx+21*8]
		mov dx,ds:[bx+21*8+2]
		
		push di
		push ax 
		push cx 
		push dx
		push bx
		
		
		call dtoc
		



			mov di,9
			mov bx,0 
			mov cx,10
			
					s8:
					mov dl,02h
					mov al,ds:[di+21*16]
					mov es:[si+bx+80],al
					mov es:[si+bx+80+1],dl

					
					dec di
					add bx,2
					
					
					loop s8
		
		pop bx	
		pop dx
		pop cx 
		pop ax 
		pop di
		
	
		add bx,4 

		add si,160 

		
		    
		
		 call clear 
		
		
loop s3 		
		
			   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		call clear
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

mov dl,02h
mov bx,0 
mov si,0
mov di,0
mov ax,0 
mov cx,0 
mov dx,0



mov cx,21				
s4:		
		
			
		mov ax,ds:[bx+21*12]
		mov dx,ds:[bx+21*12+2]
		
		push di
		push ax 
		push cx 
		push dx
		push bx
		
		
		call dtoc
		


			mov di,9
			mov bx,0 
			mov cx,10
			
					s7:
					mov dl,02h
					mov al,ds:[di+21*16]
					mov es:[si+bx+120],al
					mov es:[si+bx+120+1],dl

					
					dec di
					add bx,2
					
					
					loop s7
		
		pop bx	
		pop dx
		pop cx 
		pop ax 
		pop di
		
	
		add bx,4 

		add si,160 

		
		    
		
		 call clear 
		
		
loop s4		
		
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		


		mov ax,4c00h
		int 21h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
dtoc:
		
		
		;push di
		;push ax 
		;push cx 
		;push dx
		;push bx
		
		mov di,0
		s:
		mov cx,10
		call divdw
		
		add cx,30h
		
		mov byte ptr ds:[di+21*16],cl
		inc di
		cmp ax,0
		jnz s
		cmp dx,0 
		jnz s
		
		
		;pop bx 
		;pop dx
		;pop cx 
		;pop ax 
		;pop di
		
		
		ret
		
		
		

		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		
divdw:
	
	
	;push di
	;push cx 
	;push dx
	;push bx
	;push si 
	
	
	
	push ax
	mov ax,dx
	mov dx,0
	div cx
	mov bx,ax
	pop ax 
	div cx
	mov cx,dx
	mov dx,bx 	

	
	;pop si 
	;pop bx 
	;pop dx
	;pop cx 
	;pop di
	
	ret   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		
clear:
			push di
			push ax 
			push cx 
			push dx
			push bx
			push si 
		
		
			mov cx,10
			mov si,0
			s5:
				mov byte ptr ds:[si+21*16],20h
				inc si 
			
			
			loop s5
			
			pop si
			pop bx 
			pop dx
			pop cx 
			pop ax 
			pop di
			
			
			
	
		ret 		
		
		
code ends

end start
