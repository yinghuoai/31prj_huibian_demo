assume  cs:code ,ds:data

data segment
db '.....*........*.......'
db '....*..*.....*.*......'
db '.....*..*....*..*.....'
db '......*..*..*.*.*.....'
db '.....*.........*......'
db '...*.............*....'
db '..*...............*...'
db '.*.................*..'
db '*...................*.'
db '*...................*.'
db '*.....*.......*.....*.'
db '*...................*.'
db '*...@.....U.....@...*.'
db '.*.................*..'
db '..**.............**...'

data ends

code segment

start:
mov ax,0b800h
mov es,ax
mov ax,data
mov ds,ax
mov dh,1

show:

mov bx,0
mov si,1018
mov cx,15

s0:
push cx
mov cx,22
s1:
mov dl,ds:[bx]
mov es:[si],dx
inc bx
add si,2
loop s1
pop cx
add si,116
loop s0


sleep:
mov cx,444
s3:
push cx 
mov cx,444
s:
mov ax,98h
mov bl,3
div bl
loop s
pop cx
loop s3

inc dh
cmp dh,7

je over
jmp show

over :

mov ax,4c00h

int 21h

code ends
end start 





















code ends








