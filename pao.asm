assume cs:codesg

	codesg segment
	
start:
	mov ax,0b800h
	mov ds,ax
	mov ds:[068ah],814ch
	mov ds:[068ch],8249h
	mov ds:[068eh],835ah
	mov ds:[0690h],8448h
	mov ds:[0692h],8549h
	mov ds:[0694h],8659h
	mov ds:[0696h],8755h
	
	
	
	mov ax,4c00h
	int 21h
	
	codesg ends
	end start
	
	
	
	