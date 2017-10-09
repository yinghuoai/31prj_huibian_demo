assume cs:code 

stack segment

	db 10 dup (0)


stack ends 


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
			mov word ptr es:[1h*4],200h
			mov word ptr es:[1h*4+2],0
			
			mov di,160*8+40
	

			mov ax,0b800h
			mov es,ax 
			
			
			mov ax,stack 
			mov ss,ax
			mov sp,10
			
			
			pushf
			
			pop ax 
			or ax,0100h   ;  0000000100000000b
			
			push ax 
			 
			popf
			
			
			
			
			nop
			nop
			nop
			nop
			nop
			nop
			
			

			
			
			
			mov ax,4c00h
			int 21h
			
		setup:

			push es
			push cx
			
			
			
			
	
			
			mov cl,2h
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			
			mov byte ptr es:[di],2h
			mov es:[di+1],cl 
		
		
			add di,2
			pop cx 
			pop es 
		
			

			
			
			
			

			;nop 
			
		
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
					
			iret
		
		setupend:
			nop
			
			
			
			
			
			
			
code ends

end start			
			