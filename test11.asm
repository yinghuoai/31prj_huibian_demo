assume cs:code,ds:data

data segment

db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789ABCDE'
dw 80,236,392,548,704,860,1016
dw 1172,1176,1180,1184,1188,1192,1196
dw 1352,1508,1664,1820,1976,2132,2288,2444,2600
dw 2756,2760,2764,2768,2772,2776,2780,2784,2788,2792,2796
dw 2956,3116,3276,3436,3596,3756,3916
dw 3920,3924
dw 3928,3768,3608,3448,3288,3128,2968
dw 2808,2812,2816,2820,2824,2828,2832,2836,2840,2844,2848
dw 2684,2520,2356,2192,2028,1864,1700,1536,1372
dw 1208,1212,1216,1220,1224,1228,1232
dw 1068,904,740,576,412,248,84

data ends

code segment

start:
mov ax,0b800h
mov es,ax
mov ax,data 
mov ds,ax

;mov bp,3998

mov bp,0
mov ah,2 
mov cx,25;5 

s:
mov si,0 
push cx 
mov cx,20 



s0:
mov bx,3996

mov al,ds:[si]
mov es:[bp],ax 
push bp
sub bx,bp 
mov al,ds:[bx]
mov di,39
sub di,si
mov bp,di 
mov al,ds:[bp]
mov es:[bx],ax
pop bp
add bp,8 
add si,2 



loop s0


mov cx,4444
s1:
push cx
mov cx,500
s2:

loop s2  
pop cx

loop s1 




;add bp,2
pop cx 

loop s

mov si,40
mov cx,84
mov ah,0

s3:
inc ah
inc ah
mov al,1
mov bx,ds:[si]
mov es:[bx],ax

add si,2


mov cx,4444
s4:
push cx
mov cx,500
s5:

loop s5  
pop cx

loop s4 








loop s3





mov ax,4c00h
int 21h










code ends
end start







