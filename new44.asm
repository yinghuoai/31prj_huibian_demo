assume cs:codesg,ds:data


data segment
dw 0,0
data ends

codesg segment

	start:
	
	
		mov ax,data
		mov ds,ax
		
		mov ax,1
		mov bx,ax
		mov dx,1
		
		mov cx,122
	s:
		
		inc dx
		inc ax
		add bx,ax
		push bx
		
		sub bx,122
		and bx,10000000B
		cmp bx,0
		jz tiaochu
		
		pop bx
		
		
	
		loop s
		
		
		tiaochu :
		pop bx
		mov ds:[0],bx
		mov ds:[2],dx

		
        mov ax,4c00h
        int 21h
	      
	
codesg ends

end start