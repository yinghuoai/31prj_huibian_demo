assume cs:codesg,ds:a


a segment
	dd 0123h,0456h,0789h,0abch
a ends

b segment
	dw 10h,20h,10h,20h
b ends

d segment
	dw 0,0,0,0
d ends

codesg segment

	start:
	
	
		mov ax,a 
		mov ds,ax
		
		mov si,10h
		mov di,0h
		
		mov cx,4
	s:
	
		mov ax,ds:[di]
		add di,2
		mov dx,ds:[di]
		add di,2
		
		
		mov bx,ds:[si]
		div bx
		
		add si,10h
		mov ds:[si],ax
		sub si,10h
		
		add si,2
		
	
		loop s
		

		
        mov ax,4c00h
        int 21h
	      
	
codesg ends

end start