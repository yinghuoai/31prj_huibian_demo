assume cs:codesg,ss:stacksg,ds:datasg


stacksg segment
	db 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
	db 0,0,0,0,0,0,0,0


datasg ends


codesg segment

	start:
	
	   and ax,1h
	   mov cx,ax
	   mov bx,2h
	   
	   loop s
			mov bx,1h	
	    s:
	    
		
        mov ax,4c00h
        int 21h
	      
	
codesg ends

end start