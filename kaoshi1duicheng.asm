assume cs:codesg,ss:stacksg

    stacksg segment
	
	   dw 0,0,0,0,0,0,0,0
	
	stacksg ends


	
	
	
	codesg segment
	
		
		

	start:	
	    mov ax,0020h
		mov ds,ax
		mov bx,0000h
		mov cx,128
	  s1:
        mov al,0000h
		mov [bx],al
		inc bx
		
		
		loop s1
	     
		 
		 
		 
		 mov bx,0000h
	     mov cx,8
		 mov dx,0000h
		 mov si,0000h
	  s2:
	     mov dx,cx
	     push cx
	    
		
	     dec dx
		 mov si,dx
		 mov dx,000fh
		 sub dx,si
	     mov cx,16
	   
	   
	   s3:
	   
	     
	     
	     
	     
		
	    
		 
		 mov al,2ah
		
		 mov [bx+si],al
		 
		
		 
		 cmp si,dx
		 jz tiaochu 

		 
		  inc si
		  jmp jixu
	  
   tiaochu:
        dec si
	jixu:
	   loop s3
	   
	   
       

	  
	  
	   
	   mov si,0000h
	   add bx,0010h
	   pop cx
	  
	  loop s2
		
		
		

       
		
		
		mov ax,4c00h
		int 21h
	
	codesg ends
	end start
	
	
	
