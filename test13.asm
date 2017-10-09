assume cs:code,ds:data

data segment

db 0F0H,000H,000H,01FH,0FFH,0FFH,0F0H,000H,000H,01FH,0F0H,000H,000H,01FH,0FFH,0FFH
db 0F0H,000H,000H,01FH,0F0H,000H,000H,01FH,0FFH,0FFH,0F0H,000H,000H,01FH,0F1H,0FFH
db 0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,01FH,0F1H,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH
db 0FFH,01FH,0F1H,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,01FH,0F0H,000H,000H,003H
db 0FFH,0FFH,080H,000H,000H,01FH,0F0H,000H,000H,003H,0FFH,0FFH,080H,000H,000H,01FH
db 03FH,0FFH,0FFH,0E0H,000H,000H,00FH,0FFH,0FFH,0FFH,03FH,0FFH,0FFH,0E0H,000H,000H
db 00FH,0FFH,0FEH,000H,03FH,0FFH,0FFH,0FFH,000H,001H,0FFH,0FFH,0FCH,000H,000H,000H
db 000H,000H,000H,000H,000H,000H,001H,0FFH,000H,000H,000H,000H,000H,000H,000H,000H
db 001H,0FFH,03FH,0FFH,0FFH,0FFH,0F8H,00FH,0FFH,0FFH,0FCH,000H,03FH,0FFH,0FFH,0FFH
db 0F8H,00FH,0FFH,0FFH,0FEH,000H,03FH,0FFH,0FFH,0FFH,0F0H,087H,0FFH,0FFH,0FFH,0FFH
db 0FFH,0E0H,003H,0FFH,0E1H,0C3H,0FFH,0E0H,003H,0FFH,0FFH,0E0H,003H,0FFH,0C3H,0E1H
db 0FFH,0E0H,003H,0FFH,0FFH,0E7H,0F3H,0FFH,087H,0F0H,0FFH,0E7H,0F3H,0FFH,0FFH,0E7H
db 0F3H,0FFH,00FH,0F8H,07FH,0E7H,0F3H,0FFH,0FFH,0E7H,0F3H,0FEH,01FH,0FCH,03FH,0E7H
db 0F3H,0FFH,0FFH,0E7H,0F0H,000H,03FH,0FEH,000H,007H,0F3H,0FFH,0FFH,0E7H,0F0H,000H
db 03FH,0FEH,000H,007H,0F3H,0FFH,000H,007H,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0F0H,000H
db 000H,007H,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0F0H,000H
db 2048 dup(0)










data ends






code segment 

start:

mov ax,0b800h
mov es,ax 
mov ax,data 
mov ds,ax 


lattice:

mov di,0
mov si,250
mov ah,0 
mov cx,250
s:
push cx 
read:
mov al,ds:[di]
inc di
div2:
mov cx,8
div2s0:
mov dl,2
div dl
mov dl,al 
mov al,0 
push ax 
mov al,dl 
loop div2s0 

mov cx,8
div2s1:
pop ax 
mov ds:[si],ah 
inc si 
loop div2s1 
pop cx 
loop s 

show:
mov cx,2000
mov si,0 
mov ah,40h
mov al,0 

s0:
mov bl,ds:[di]
inc di 
cmp bl,0 
je next 
mov es:[si],ax 

next:
add si,2 
loop s0 


sign:
mov ax,2000h
mov si,1758
mov es:[si],ax 
mov al,17 
mov ah,8h
mov si,2398
mov es:[si],ax 
mov cx,1 
jmp direction


direction:
cmp si,1758
je over
cmp al,30
je j_up 
cmp al,31
je j_down
cmp al,17 
je j_left
cmp al,16
je j_right


j_up:
jmp up 
j_down:
jmp down
j_left:
jmp left 
j_right:
jmp right


over:
mov ah,0aeh
mov es:[si],ax
mov ax,4c00h
int 21h

up :
mov bp,si 
sub bp,2 
mov bx,es:[bp]
and bh,01110000b
call far ptr wall
cmp bh,0 
jne Cf1
mov ah,8h 
mov al,17
mov es:[si],ax
mov es:[bp],ax 
mov si,bp 
inc cx 
jmp sleep

Cf1:
mov bp,si
mov bp,si
sub bp,160
mov bx,es:[bp]
and bh,01110000b
call far ptr wall
cmp bh,0 
jne T_r1
mov es:[bp],ax
mov si,bp 
inc cx 
jmp sleep 

T_r1:
mov ah,8h
mov al,16
mov es:[si],ax
mov bp,si
add bp,2 
mov es:[bp],ax 
mov si,bp 
inc cx 
jmp sleep

down:
mov bp,si 
add bp,2 
mov bx,es:[bp]
and bh,01110000b
call far ptr wall 
cmp bh,0 
jne Cf2
mov ah,8h
mov al,16 
mov es:[si],ax
mov es:[bp],ax
mov si,bp 
inc cx
jmp sleep

Cf2:
mov bp,si 
add bp,160
mov bx,es:[bp]
and bh,01110000b
call far ptr wall 
cmp bh,0 
jne T_r2
mov es:[bp],ax
mov si,bp 
inc cx 
jmp sleep 

T_r2:
mov ah,8h
mov al,17 
mov es:[si],ax
mov bp,si 
sub bp,2 
mov es:[bp],ax 
mov si,bp 
inc cx 
jmp sleep  

left:

mov bp,si 
add bp,160
mov bx,es:[bp]
and bh,01110000b
call far ptr wall 
cmp bh,0 
jne Cf3
mov ah,8h
mov al,31 
mov es:[si],ax
mov es:[bp],ax
mov si,bp 
inc cx 
jmp sleep

Cf3:
mov bp,si 
sub bp,2 
mov bx,es:[bp]
and bh,01110000b
call far ptr wall
cmp bh,0 
jne T_r3
mov es:[bp],ax 
mov si,bp 
inc cx 
jmp sleep

T_r3:
mov ah,8h
mov al,30
mov es:[si],ax
mov bp,si 
sub bp,160
mov es:[bp],ax
mov si,bp 
inc cx 
jmp sleep


right:

mov bp,si 
sub bp,160
mov bx,es:[bp]
and bh,01110000b
call far ptr wall 
cmp bh,0 
jne Cf4
mov ah,8h
mov al,30
mov es:[si],ax
mov es:[bp],ax
mov si,bp 
inc cx 
jmp sleep

Cf4:

mov bp,si
add bp,2 
mov bx,es:[bp]
and bh,01110000b
call far ptr wall 
cmp bh,0 
jne T_r4
mov es:[bp],ax
mov si,bp 
inc cx 
jmp sleep

T_r4:
mov ah,8h
mov al,31 
mov es:[si],ax
mov bp,si 
add bp,160
mov es:[bp],ax 
mov si,bp 
inc cx 
jmp sleep

wall:

w_up:
cmp bp,0 
jnb w_down
mov bh,1 
ret 

w_down:
cmp bp,4000
jb w_left
mov bh,1
ret 

w_left:
push ax
mov ax,si 
sub ax,bp 
cmp ax,2
jne w_right
mov ax,bp
mov dl,160
div dl 
cmp ah,158
jne w_right 
mov bh,1 
pop ax 
ret

w_right:
mov ax,bp 
sub ax,si
cmp ax,2 
jne back 
mov ax,bp 
mov dl,160
div dl 
cmp ah,0 
jne back 
mov bh,1 

back:
pop ax 
ret 

sleep:

push cx 
push ax 
push bx 
mov cx,4444
s8:
push cx
mov cx,500
s9:

loop s9  
pop cx

loop s8 
pop bx 
pop ax 
pop cx 
jmp direction 

code ends 
end start 




















































































code ends 
end start