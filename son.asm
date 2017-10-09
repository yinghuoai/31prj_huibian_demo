assume cs:code 



code segment

start:


	

	;call jiemian
	
	
	;mov ax,4c00h
	;int 21h 
	
	
	

;jiemian:

	first db '1> reset pc     '
    two   db '2> start system '
    three db '3> clock        '
    four  db '4> set clock    '


	push bx 
	push es 
	push si 
	push cx 
	push ax
	push di
	
	;mov si,0
	mov bx,0b800h
	mov es,bx 
	mov di,160*12+40*2

	mov si,0
	
	mov cx,16 
show:
	
	
	mov al,first[si]
	mov ah,0 
	mov byte ptr es:[di],al
	mov byte ptr es:[di+1],02h
	
	mov al,two[si]
	mov ah,0 
	mov byte ptr es:[di+160],al
	mov byte ptr es:[di+160+1],02h
	
    mov al,three[si]
	mov ah,0 
	mov byte ptr es:[di+160*2],al
	mov byte ptr es:[di+160*2+1],02h
	
	mov al,four[si]
	mov ah,0
	mov byte ptr es:[di+160*3],al
	mov byte ptr es:[di+160*3+1],02h
	
	inc si 
	add di,2 
	
	loop show 
	
	



	
	pop di 
	pop ax 
	pop cx 
	pop si 
	pop es 
	pop bx 
	
	
	
	
	
	;ret 







code ends 
end start













