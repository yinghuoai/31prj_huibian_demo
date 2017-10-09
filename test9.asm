assume cs:code 
code segment
start:
mov ax,0b800h
mov es,ax
mov dh,02h
mov si,430

mov dl,0
mov cx,7

s:
push cx 
mov bp,0 
mov cx,20

s0:

mov es:[si+bp],dx
add bp,160
inc dl 
cmp dl,128
je over
push cx 
call sleep
pop cx 
loop s0 
pop cx 
sub si,10
loop s 

sleep:mov cx,444
s8:
push cx
mov cx,444 
s9:
mov ax,98h
mov bl,3
div bl 
loop s9
pop cx 
loop s8 
ret

over:
mov ax,4c00h
int 21h

code ends
end start 







