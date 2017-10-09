assume cs:code


code segment
mov ax,0b800h 
mov es,ax 
mov bx,2160 
mov ax,41h 
; mov cx,02h  
mov es:[bx],ax
;mov es:[bx+1],cx
mov ax,4c00h 
int 21h 


code ends
end  