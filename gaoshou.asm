assume  cs:code, ds:data


data  segment
 Chars db 'O'  ;字符 
 Color db 04  ;颜色 : 红
 DelayTime dw 1  ;迟时 1/18秒
 Rows db 12
 Cols db 0
 pos dw 0  ;字符水平位置
 HDirect dw 1  ;水平方向  ,右为1 , 左为 -1
 VDirect dw 1  ;垂直方向  ,下为1 , 上为 -1
 DisplayStr db 79 dup (20h) ,0
data ends
 
code segment

start: 
 mov ax,data
 mov ds,ax  
 mov es,ax
 Call ClrScr ;清屏
 mov cx,3031h ;关光标
 Call SetCurSz  
Next:
 mov ah,1 ;检查键盘输入
 int 16h
 jz next2 ;没有
 mov ah,0 ;读键
  int 16h
 jmp short quit ;任何键也离开
next2:
 mov ax,DelayTime    ;延时ax /18秒
 Call delay_proc ;延时
 Call ClearStr ;显示字符串
 Call DispStr ;显示字符串
 Call NewStr ;制作新字符
 Call NewRows
 Call DispStr ;显示字符串
 jmp short Next
quit:
 mov cx,0c0dh  ;正常光标
 Call SetCurSz  ; 开启光标
 mov ah,4ch ;离开
 int 21h
;----------------------------------------------------------------------------------
NewStr:
 Call ClearStr
 mov ax,HDirect ;方向
 add ax,pos  ;加上位置
 jnz New3  ;是否到了左边界,0则到了
 Neg HDirect ;到了,反向
 jmp short New4
New3:
 cmp ax,79 ;是否到了右边界
 jb New4  ;未
 Neg HDirect  ;到了,反向
New4:
 mov pos,ax ;存新位置
 mov di,offset DisplayStr
 add di,ax ;决定那个位置放字符
 mov al,Chars ;字符
 mov [di],al ;放字符
 ret
;----------------------------------------------------------------------------------
NewRows:
 mov al,Rows
 mov ah,0
 add ax,VDirect
 jnz NewR10
 Neg VDirect
 jmp short NewR20
NewR10:
 cmp ax,22
 jb NewR20
 Neg VDirect
NewR20:
 mov Rows,al
 ret
;----------------------------------------------------------------------------------
delay_proc: ;延迟子程式,  延迟   ax/18秒
 push es
 push dx 
 mov dx,40h
 mov es,dx
 mov dx,es:[006ch] ;取系统1/18秒计数
 add dx,ax  ; 延时 x/18
delay10: 
 cmp es:[006ch],dx ;时限到了?
 jbe delay10  ;没
 pop dx
 pop es
 ret
;-------------------------
ClrScr: ;清屏
  mov ax,0600h       ;cls
  mov bh,7       ;normal attribute
  mov cx,0       ;top left
  mov dx,6079       ;bottom right
  int 10h
  mov ah,02       ;move curvor to left top
  mov bx,0       ;zero page
  mov dx,0000       ;top left
  int 10h
 ret
;-------------------------------------------------------------------------------
SetCurSz:  ;设定光标大小
  mov ah,01h
  int 10h
 ret
;-------------------------------------------------------------------------------
DispStr:  ;以int 10h , ah=13h显示es:bp指向的字符串
 mov dh,rows
 mov dl,cols
 mov bh,0
 mov bl,color
 mov cx,79
 mov bp,offset DisplayStr
 mov ax,1300h
 int 10h
 ret
;------------------------------------------------------------------------------
ClearStr:
 mov di,offset DisplayStr
 mov cx,79
 mov al,20h
 rep stosb  ;清除字符串
 ret
;------------------------------------------------------------------------------
 
code ends
end start