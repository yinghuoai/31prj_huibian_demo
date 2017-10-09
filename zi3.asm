assume cs:code




code segment

start:
      
	  
	  
	time   db 9,8,7,4,2,0
		
	s3:
		
		

		mov si,0 
		mov di,0 
		mov bx,0b800h
		mov es,bx 
		
		mov byte ptr es:[160*12+40*1+4],2fh
		mov byte ptr es:[160*12+40*1+5],02h
		mov byte ptr es:[160*12+40*1+10],2fh 
		mov byte ptr es:[160*12+40*1+11],02h
		
		mov byte ptr es:[160*12+40*1+16],20h
		mov byte ptr es:[160*12+40*1+17],02h
		mov byte ptr es:[160*12+40*1+22],3ah 
		mov byte ptr es:[160*12+40*1+23],02h
		
		
		mov byte ptr es:[160*12+40*1+28],3ah
		mov byte ptr es:[160*12+40*1+29],02h

		mov cx,6
		
	s:	
		push cx 
		
		mov al,byte ptr time[si]
		;
		;mov al,8
		out 70h,al 
		in al,71h
		
		
		mov ah,al 
		mov cl,4
		shr ah,cl 
		and al,00001111b
		
		
		add ah,30h
		add al,30h
		

		mov byte ptr es:[160*12+40*1+di],ah
		mov byte ptr es:[160*12+40*1+di+1],02h
		mov byte ptr es:[160*12+40*1+di+2],al 
		mov byte ptr es:[160*12+40*1+di+3],02h
		
		add di,6
		inc si
		pop cx 
		
		loop s
		
		

		jmp s3
		
jieshu:

		mov ax,4c00h
		int 21h
		
		
code ends

end start
		
		