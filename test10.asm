assume cs:code ,ds:data

data segment
db 'happy spring festival'


data ends


code segment


start:
mov ax,0b800h
mov es,ax
mov ax,data
mov ds,ax
mov di,0
show:
mov si,346
mov bp,0
mov cx,22
s:
push cx 
mov cx,3 
s0:
mov al,ds:[di]
mov es:[si+bp],al 
add bp,6
loop s0 
pop cx 
inc di 
add bp,146
loop s 
mov dx,1 


color:

mov bp,0 
mov cx,25
s1:

push cx 
mov si,dx 
mov cx,9
s2:
mov ah,1
mov es:[si+bp],ah
add si,6
mov ah,2
mov es:[si+bp],ah
add si,6
mov ah,4
mov es:[si+bp],ah
add si,6
loop s2
pop cx 
add bp,164
loop s1
jmp sleep


sleep:
mov cx,888
s8:
push cx
mov cx,888
s9:
mov ax,98h
mov bl,3 
div bl 
loop s9
pop cx 
loop s8 
cmp dx,317
je over
add dx,158
jmp color 

over:
mov ax,4c00h
int 21h



























code ends
end start


























