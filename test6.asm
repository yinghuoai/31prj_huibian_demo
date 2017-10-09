assume cs:code ,ds:data

data segment
DB  000H,000H,000H,000H,030H,000H,000H,03CH,000H,000H,038H,000H,000H,038H,000H,000H
DB  038H,000H,038H,038H,01CH,03FH,0FFH,0FCH,018H,038H,038H,018H,038H,038H,018H,038H
DB  038H,018H,038H,038H,018H,038H,038H,018H,038H,038H,03FH,0FFH,0F8H,038H,038H,038H
DB  000H,038H,000H,000H,038H,000H,000H,038H,000H,000H,038H,000H,000H,038H,000H,000H
DB  038H,000H,000H,038H,000H,000H,000H,000H

DB  000H,000H,000H,000H,008H,000H,003H,08EH,000H,003H,0CCH,018H,007H,00CH,03CH,00EH
DB  00CH,0FCH,00FH,00DH,0E0H,01FH,00FH,080H,03FH,00EH,00CH,077H,03CH,00CH,067H,0ECH
DB  00EH,007H,08CH,00EH,007H,00FH,0FEH,007H,038H,000H,000H,03CH,000H,000H,038H,00CH
DB  0FFH,0FFH,0FEH,000H,038H,003H,000H,038H,000H,000H,038H,000H,000H,038H,000H,000H
DB  038H,000H,000H,038H,000H,000H,000H,000H


data ends


code segment

start:
mov ax,0b800h
mov es,ax
mov ax,data
mov ds,ax

mov si,0
mov bh,100b
mov bl,03h
mov ah,0
mov dh,0 
mov di,180
jmp read

over:
mov ax,4c00h
int 21h

check:
cmp si,72
jne next2
mov di,136


next2:
cmp si,144
je over
cmp dh,3
jne read
mov dh,0
add di,112
jmp read

read:
mov al,ds:[si]
inc si
inc dh
jmp div2

doom:
mov cx,8
s1:
pop ax
cmp ah,1
jne next
mov es:[di],bx

next:
add di,2
loop s1
jmp check

div2:
mov cx,8
s0:
mov dl,2 
div dl
mov dl,al
mov al,0 
push ax 
mov al,dl 
loop s0 
jmp doom 

code ends 
end start


















