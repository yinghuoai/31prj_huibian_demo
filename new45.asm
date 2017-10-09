assume cs:codesg,ds:data


data segment
db 'welcome to masm!'
data ends


codesg segment

	start:
	
	    
		mov bx,0h
		
		mov si,0h
		mov cx,0ffffh
	s:	
	
		push cx
	
	
		mov ax,data
		mov ds,ax
		
		mov al,ds:[bx]
		
		mov ah,cl
		mov dx,0b800h
		mov ds,dx
		mov ds:[si],ax
		inc bx
		add si,2
	    cmp bx,10h
	   
	    jz fan
	   
	  
	   
	    jmp jixu
	   
	   
	   
	fan:
	   mov bx,0
	   mov si,0
	

	
	   jmp jixu
	   
	jixu:  
	 
		mov cx,0ffffh
	   s1:
	     nop
		 nop
		 nop
		 nop

	   
	   
	   loop s1
	
		
		
		
		
		
		
		
		
		pop cx
		
		
		loop s
		
		

		
		
        mov ax,4c00h
        int 21h
	      
	
codesg ends

end start