assume cs:code 


code segment
start:
mov ax,0b800h
mov es,ax
mov bx,2160
mov ax,48h
mov cx,02h
mov es:[bx],ax
mov es:[bx+1],cx

mov ax,65h
mov cx,02h
mov es:[bx+2],ax
mov es:[bx+3],cx

mov ax,6ch
mov cx,02h
mov es:[bx+4],ax
mov es:[bx+5],cx

mov ax,6ch
mov cx,02h
mov es:[bx+6],ax
mov es:[bx+7],cx

mov ax,6fh
mov cx,02h
mov es:[bx+8],ax
mov es:[bx+9],cx


mov ax,21h
mov cx,02h
mov es:[bx+10],ax
mov es:[bx+11],cx

mov ax,4eh
mov cx,02h
mov es:[bx+12],ax
mov es:[bx+13],cx

mov ax,69h
mov cx,02h
mov es:[bx+14],ax
mov es:[bx+15],cx

mov ax,63h
mov cx,02h
mov es:[bx+16],ax
mov es:[bx+17],cx


mov ax,65h
mov cx,02h
mov es:[bx+18],ax
mov es:[bx+19],cx

mov ax,20h
mov cx,02h
mov es:[bx+20],ax
mov es:[bx+21],cx

mov ax,74h
mov cx,02h
mov es:[bx+22],ax
mov es:[bx+23],cx

mov ax,6fh
mov cx,02h
mov es:[bx+24],ax
mov es:[bx+25],cx


mov ax,20h
mov cx,02h
mov es:[bx+26],ax
mov es:[bx+27],cx

mov ax,6dh
mov cx,02h
mov es:[bx+28],ax
mov es:[bx+29],cx


mov ax,65h
mov cx,02h
mov es:[bx+30],ax
mov es:[bx+31],cx

mov ax,65h
mov cx,02h
mov es:[bx+32],ax
mov es:[bx+33],cx


mov ax,74h
mov cx,02h
mov es:[bx+34],ax
mov es:[bx+35],cx

mov ax,20h
mov cx,02h
mov es:[bx+36],ax
mov es:[bx+37],cx

mov ax,79h
mov cx,02h
mov es:[bx+38],ax
mov es:[bx+39],cx


mov ax,6fh
mov cx,02h
mov es:[bx+40],ax
mov es:[bx+41],cx

mov ax,75h
mov cx,02h
mov es:[bx+42],ax
mov es:[bx+43],cx

mov ax,21h
mov cx,02h
mov es:[bx+44],ax
mov es:[bx+45],cx




mov ax,4c00h
int 21h

code ends 
end start