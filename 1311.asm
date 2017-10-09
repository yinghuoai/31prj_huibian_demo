assume cs:code 


code segment

start:
			mov ax,cs 
			mov ds,ax 
			mov si,offset setup
			mov ax,0
			mov es,ax 
			mov di,200h
			mov cx,offset setupend-offset setup
			cld
			rep movsb 
			
			mov ax,0
			mov es,ax 
			mov word ptr es:[7ch*4],200h
			mov word ptr es:[7ch*4+2],0
			
			



			mov ax,4c00h
			int 21h
			
		setup:
		
			mov ax,0b800h
			mov es,ax 
		
			mov al,160
			mov ah,0
			mul dh
			mov dh,0
			add dl,dl
			add ax,dx
			mov di,ax 
			mov si,0
			
			
		
		show:
			cmp byte ptr ds:[si],0
			jz ok 
			mov ax,ds:[si]
			mov es:[di],ax
			mov es:[di+1],cl 
			
			inc si 
			add di,2
		
			jmp show
		
		ok:


			iret
		
		setupend:
			
			
			
			
			
			
			
			
code ends

end start			
			