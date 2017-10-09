assume cs:code,ds:data

data segment
		
        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'  
        db '1984','1985','1986','1987','1988','1989','1990','1991','1992'  
        db '1993','1994','1995'  
        ;以上是表示21年的21个字符串  
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        db '16     ','22     ','382    ','1356   ','2390   ','8000   ','16000  ','24486  ','50065  ','97479  ','140417 ','197514 '  
        db '345980 ','590827 ','803530 ','1183000','1843000','2759000','3753000','4649000','5937000'  
        ;以上是表示21年公司总收的21个dword型数据  
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        db '3      ','7      ','9      ','13     ','28     ','38     ','130    ','220    ','476    ','778    ','1001   ','1442   ','2258   ','2793   ','4037   ','5635   ','8226   '  
        db '11542  ','14430  ','45257  ','17800  '  
        ;以上是表示21年公司雇员人数的21个word型数据  
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		db '5   ','3   ','42  ','104 ','85  ','210 ','123 ','111 ','105 ','125 ','140 ','136 ','153 ','211 ','199 ','209 ','224 ','239 ','260 '
		db '304 ','333 '
data ends




code segment

start:
		mov ax,data 
		mov ds,ax 
		
		mov ax,0b800h
		mov es,ax
		
		mov cx,21
		mov dl,02h
		mov bx,0
		mov si,0 
		mov di,0 
				
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
		
		
		
		add bx,4 
		add di,7
		add si,160 
		
		
	
		
		loop s1 	
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

		mov cx,21
		mov dl,02h
		mov bx,0
		mov si,0 
		mov di,0 
				
s2:		


		
		mov al,ds:[bx+84]
		mov es:[si+40],al
		mov es:[si+40+1],dl
		
		mov al,ds:[bx+84+1]
		mov es:[si+40+2],al
		mov es:[si+40+3],dl
		
		mov al,ds:[bx+84+2]
		mov es:[si+40],al
		mov es:[si+40+1],dl
		
		mov al,ds:[bx+84+3]
		mov es:[si+40+2],al
		mov es:[si+40+3],dl
		
		mov al,ds:[bx+84+4]
		mov es:[si+40],al
		mov es:[si+40+1],dl
		
		mov al,ds:[bx+84+5]
		mov es:[si+40+2],al
		mov es:[si+40+3],dl
		
				
		mov al,ds:[bx+84+6]
		mov es:[si+40],al
		mov es:[si+40+1],dl
		
		
		
		
		add bx,7
		add si,160 
		
		
	
		
		loop s2 
			
		
		mov cx,21
		
		mov bx,0
		mov si,0 
		mov di,0 
		
		s3:
		mov dl,02h
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
	
		mov al,ds:[bx+231]
		mov es:[si+80],al
		mov es:[si+80+1],dl
		
		mov al,ds:[bx+231+1]
		mov es:[si+80+2],al
		mov es:[si+80+3],dl
		
		mov al,ds:[bx+231+2]
		mov es:[si+80],al
		mov es:[si+80+1],dl
		
		mov al,ds:[bx+231+3]
		mov es:[si+80+2],al
		mov es:[si+80+3],dl
		
		mov al,ds:[bx+231+4]
		mov es:[si+80],al
		mov es:[si+80+1],dl
		
		mov al,ds:[bx+231+5]
		mov es:[si+80+2],al
		mov es:[si+80+3],dl
		
				
		mov al,ds:[bx+231+6]
		mov es:[si+80],al
		mov es:[si+80+1],dl
		
		
		
		 
		add bx,7
		add si,160 
		
		loop s3	
		
		;	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		mov cx,21
		mov dl,02h
		mov bx,0
		mov si,0 
		mov di,0 
				
		s4:

		
		mov al,ds:[bx+21*18]
		mov es:[si+120],al
		mov es:[si+120+1],dl
		
		mov al,ds:[bx+21*18+1]
		mov es:[si+120+2],al
		mov es:[si+120+3],dl
		
		
		mov al,ds:[bx+21*18+2]
		mov es:[si+120+4],al
		mov es:[si+120+5],dl
		
		mov al,ds:[bx+21*18+3]
		mov es:[si+120+6],al
		mov es:[si+120+7],dl
		
		
		add bx,4 
		add di,7
		add si,160 
		
		loop s4

		

		mov ax,4c00h
		int 21h

		
		
		
		
		


code ends

end start
