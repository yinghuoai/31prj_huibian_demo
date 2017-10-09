assume cs:code 
code segment
start:
mov ax,0b800h
mov es,ax
mov dh,02h
mov si,18*160

mov dl,'-'
mov cx,3

s:
push cx
mov cx,20

s0:
mov es:[si],dx
add si,2
loop s0 
pop cx 
sub si,160*6
loop s 


mov si,17*160 
mov dl,2 

smile:
mov cx,3

s1:

push cx 
mov cx,20 

s2:
mov es:[si],dx 
push cx 
call sleep
pop cx 
add si,2 
loop s2 
pop cx 
sub si,160*6
loop s1 
jmp over


sleep:
mov cx,444
s8:push cx 
mov cx,444 
s9:
mov ax,98h
mov bl,3
div bl 
loop s9
pop cx 
loop s8 
mov ax,0 
mov es:[si],ax
ret

over: 
mov ax,4c00h
int 21h
code ends
end start




















