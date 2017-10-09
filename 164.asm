assume cs:code  
  
code segment  
start:  
    mov ax,cs  
    mov ds,ax  
    mov si,offset begin  
    mov ax,0  
    mov es,ax  
    mov di,200h  
    mov cx,offset beginend-offset begin  
    cld  
    rep movsb  
  
    mov ax,0  
    mov es,ax  
    mov word ptr es:[7ch*4],200h  
    mov word ptr es:[7ch*4+2],0  
  
    mov ax,4c00h  
    int 21h  
      
    ;伪指令，表示下一条指令从偏移地址200H开始，正好和安装后的偏移地址相同    
    ;因为如果没有ORG 200H，此中断例程被安装以后，标号所代表的地址变了，和之前编译器编译有别  
    org 200h    
  
;ah中保存了功能号，0清屏，1改前景，2改背景，3上滚动一行  
begin:  

    jmp short choose
  
    fun dw fun0,fun1,fun2,fun3 
  
    choose:  
    push bx  
    cmp ah,3  
    ja chooseret  
    mov bl,ah  
    mov bh,0  
    add bx,bx ;dw占2个字节，乘2来取得对应位置  
  
      
    call word ptr fun[bx]  
  
    chooseret:  
    pop bx  
    iret  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
fun0: 
		push bx  
		push cx  
		push es  
		mov bx,0b800h  
		mov es,bx  
		mov bx,0  
		mov cx,2000  
	s0:
		mov byte ptr es:[bx],' '  
		add bx,2  
		loop s0  
		pop es  
		pop cx  
		pop bx  
		ret  
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
    
fun1:
		push bx  
		push cx  
		push es  
		mov bx,0b800h  
		mov es,bx  
		mov bx,1  
		mov cx,2000  
    s1: 
		add byte ptr es:[bx],11111000b  
		or es:[bx],al  
		add bx,2  
		loop s1 
		pop es  
		pop cx  
		pop bx  
		ret  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fun2:
		push bx  
		push cx  
		push es  
		mov cl,4  
		shl al,cl  
		mov bx,0b800h  
		mov es,bx  
		mov bx,1  
		mov cx,2000  
    s2:  
		add byte ptr es:[bx],10001111b  
		or es:[bx],al  
		add bx,2  
		loop s2  
		pop es  
		pop cx  
		pop bx  
		ret  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  
fun3:
		push cx  
		push si  
		push di  
		push es  
		push ds  
		mov si,0b800h  
		mov es,si  
		mov ds,si  
		mov si,160  
		mov di,0  
		cld  
		mov cx,24  
    s3:  
		push cx  
		mov cx,160  
		rep movsb  
		pop cx  
		loop s3  
		mov cx,80  
		mov si,0  
    clear:  
		mov byte ptr [160*24+si],' '  
		add si,2  
		loop clear  
		pop ds  
		pop es  
		pop di  
		pop si  
		pop cx  
		ret  
  
beginend:  
    nop  
code ends  
end start