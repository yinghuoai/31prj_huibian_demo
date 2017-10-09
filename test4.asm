assume cs:code 


code segment
start:
mov ax,0b800h
mov es,ax
mov bx,2160
mov ax,34h
mov cx,02h
mov es:[bx],ax
mov es:[bx+1],cx

mov ax,5eh
mov cx,02h
mov es:[bx+160],ax
mov es:[bx+161],cx

mov ax,33h
mov cx,02h
mov es:[bx+480],ax
mov es:[bx+481],cx

mov ax,5fh
mov cx,02h
mov es:[bx+640],ax
mov es:[bx+641],cx

mov es:[bx+642],ax
mov es:[bx+643],cx
mov es:[bx+644],ax
mov es:[bx+645],cx
mov es:[bx+646],ax
mov es:[bx+647],cx



mov ax,36h
mov cx,02h
mov es:[bx+800],ax
mov es:[bx+801],cx
mov ax,34h
mov cx,02h
mov es:[bx+802],ax
mov es:[bx+803],cx




mov ax,4c00h
int 21h

code ends 
end start