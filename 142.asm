assume cs:code 

stack segment

	db 10 dup (0)


stack ends 

 

code segment

start:

		
		
		
		;mov ax,data
		;mov ds,ax 
		;mov si,0 
		mov di,0 
		mov bx,0b800h
		mov es,bx 
		mov dx,0
		
		mov cx,9;倒计时数	
	
	s:
		mov al,0
		out 70h,al
		in al,71h
		
		mov dl,al
	
		dumiao:
		
		mov al,0
		out 70h,al
		in al,71h
		
		cmp dl,al
		jz dumiao 
		
		
		mov dh,cl
		add dh,30h
		mov byte ptr es:[160*12+40*2],dh
		mov byte ptr es:[160*12+40*2+1],02h
		
		
		
		
		
		
		
		loop s 
		
		
		
		
		mov ax,4c00h
		int 21h

		
		
		
		
		
		
			
			
			
			
			
			
code ends

end start			
			