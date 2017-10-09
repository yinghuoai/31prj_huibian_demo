assume cs:codesg,ds:data




data segment
	db '1975','1976','1977','1978'
	dd 16,22,382,1356
	dw 3,7,9,13



data ends

table segment

	db 4 dup('year summ ne ?? ')


codesg segment

	start:

	
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		

		
		mov cx,4
		s1:
		mov ax,data
		mov ds,ax
		
		mov al,ds:[bx+si]
		mov dx,table
		mov ds,dx
		mov ds:[di],al
		
		inc si
		inc di
		
		
		loop s1
		
	
		
		mov si,0	
		mov di,5
		add bx,16

		mov cx,2
		s2:
		mov ax,data
		mov ds,ax
		
		
		
		mov ax,ds:[bx+si]
		mov dx,table
		mov ds,dx
		mov ds:[di],ax
		
		add si,2
		add di,2
			
		
		loop s2
		
		mov si,bx
		add si,32
		mov di,5h
		
		
		;mov cx,1
		;s3:
		mov si,0	
		mov di,0ah
		add bx,16
		
		mov ax,data
		mov ds,ax
		
		mov ax,ds:[bx+si]
		mov dx,table
		mov ds,dx
		mov ds:[di],ax
		
		;loop s3
		
	   
		
		mov si,5
		mov cx,1
		s4:
		mov bx,0
		mov ax,ds:[bx+si]
		mov dx,table
		mov ds,dx
		mov ax,ds:[bx+si]
		add si,2
		mov dx,ds:[si]
		

		mov si,0ah

		
		mov bx,ds:[si]
		div bx
		
		
		
		mov si,0dh 
		
		
		mov ds:[si],ax
		

		
		loop  s4
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	

		

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
        mov ax,4c00h
        int 21h
	      
	
codesg ends

end start