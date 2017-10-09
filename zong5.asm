assume cs:xieru

xieru segment		;写入软盘

start:

    ;复制读入程序到软盘0面0道1扇区 

    mov ax,duru 
    mov es,ax
    mov bx,0  ;es:bx指向要写的单元
	
    mov dx,0
    mov cx,1
    mov al,1
    mov ah,3
    int 13h

   

    ;复制所有程序到软盘0面0道2~11扇区

    mov ax,code
    mov es,ax       
	mov bx,0
					;es:bx指向要写的单元
    mov dx,0
    mov cx,2        
    mov al,10 
    mov ah,3
    int 13h

    mov ax,4c00h
    int 21h

xieru ends

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 
duru segment
assume cs:duru 

    ;读程序到3000:0
	
	
    mov ax,3000h
    mov es,ax
    mov bx,0
    push ax
    push bx
		
    mov dx,0
    mov cx,2
    mov al,2 
    mov ah,2
    int 13h

    retf		;将cs:ip指向任务程序的首地址3000:0

duru ends
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
code segment  

assume cs:code 


	 
		jmp  kaishi  
  
		choice   dw chongqi, xitong, clock, change  
		   
		kaishi:  
				call jiemian  
				mov ah,0  
				int 16h 
				
				cmp ah,02  
				jb kaishi  
				
				cmp ah,05  
				ja kaishi  
				
				mov al,ah  
				mov ah,0  
				sub al,2  
				add al,al  
				mov bx,ax  
				call word ptr choice[bx]  
				jmp kaishi  
				
				;;;;;;;;;;;;;;;;
				mov ax,4c00h  
				int 21h  
  

  

  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;重启计算机 
  
chongqi: 
				call clear      
				mov ax,0ffffh  
				push ax  
				mov ax,0  
				push ax  
				retf  
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;引导操作系统 
  
  
xitong:  
				call clear      
				mov ax,0  
				mov es,ax  
				mov bx,7c00h  
				  
				mov al,1  
				mov ch,0  
				mov cl,1  
				mov dh,0  
				mov dl,80h  
  
				mov ah,2  
				int 13h  
			   
				mov ax,0  
				push ax  
				mov ax,7c00h  
				push ax  
				retf  
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;显示时钟
	
clock:  
				jmp  zhunbei      
  
				geshi: db '  /  /     :  :  ',0  
				time:  db 9,8,7,4,2,0  
  
    zhunbei:    
				push ds  
				push bp  
				push bx  
				push cx  
				push ax  
				push es  
				push di  
				push dx  
  
				call clear  
				mov dl,2  
  
    showtime:    
				push cs  
				pop ds  
				
				
				
				
				;;;;;;;;;;;;;;;;;;;;先把实时的时间搬运到geshi
				mov bp,offset geshi  
				mov bx,offset time 

				
				mov cx,6  
		 sht1:  
		 
				push cx  
				mov al,[bx]  
				out 70h,al  
				in al,71h  
				mov ah,al  
				mov cl,4  
				shr ah,cl  
				and al,00001111b  
				add ah,30h  
				add al,30h  
				mov ds:[bp],ah  
				mov ds:[bp+1],al  
				inc bx  
				add bp,3  
				
				
				pop cx  
				
				
				loop sht1  
			;;;;;;;;;;;;;;;;;;;;;;;;;;
			
			

			
			
			
				mov ax,0b800h  
				mov es,ax  
				mov di,10*160+40*2  
				mov bx,offset geshi  
	   sht2:   
				mov cl,[bx]  
				mov ch,0  
				jcxz bijiao  
				mov es:[di],cl  
				mov es:[di+1],dl  
				inc bx  
				add di,2  
				jmp sht2  
  
	    bijiao:   
				mov ah,1   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				int 16h   
				
				cmp al,1bh  
				je fanhui  	;esc返回
				cmp ah,3bh  
				je bianse  ;f1变色
				
				
				jmp qita
				
				jmp showtime 
				
				
				
				
				;;;;;;;;;;;
				
		qita:
				mov ah,1  
				int 16h  
				jz showtime  
				mov ah,0 
				int 16h 
				
				jmp qita

				
				
				
				
				
	    bianse:   
	   
				mov ah,0  
				int 16h   
				
				inc dl  
				jmp showtime

				
	    fanhui:   
	   
				mov ah,0  
				int 16h   
				
				call clear  
				pop dx  
				pop di  
				pop es  
				pop ax  
				pop cx  
				pop bx  
				pop bp  
				pop ds  
				ret  
  
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;改变时间
  
  
  
change: 
				
				jmp shezhi  
  
 

	 geshi2:    db '  /  /     :  :  ',0 
	 time2:  	db 9,8,7,4,2,0  
	  
	  
	  
	    shezhi:  
				push ax  
				push bx  
				push cx  
				push dx  
				push bp  
				push si  
				push di  
				push ds  
				push es  
				
				
				call clear  
				
				
				
				push cs  
				pop ds  
				
				mov ax,0b800h  
				mov es,ax  
				mov di,13*160+40*2  

 
				mov bx,0 
				mov si,offset geshi2  
				mov dh,13  
				mov dl,40  
				call getstr  
				
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;


			
				mov bx,offset geshi2   
				mov bp,offset time2  
				
				
				mov cx,6  
		biantime:  
							;;;;;十进制-》BCD码
				push cx  
				
				mov ch,0  
				mov cl,4  
				mov ah,[bx]  ;high
				mov al,[bx+1]  ;low
				sub ah,30h  
				sub al,30h  
				shl ah,cl  
				add ah,al  
				
				
				mov al,ds:[bp]  
				out 70h,al 

 
				mov al,ah  
				out 71h,al  
				
				pop cx  
				
				add bx,3  
				inc bp  
				loop biantime   
				
			;;;;;;;;;;;;;;;;;;;;;;;;;;;

				
			
			;;;;;;;;;;;;;;;;;;;;;;;;;;
				

				
				
	 read00:  				;;;;;不esc 就继续读
				mov ah,0  
				int 16h 
				
				cmp al,1bh  
				jne read00  
				call clear  
				pop es  
				pop ds  
				pop di  
				pop si  
				pop bp  
				pop dx  
				pop cx  
				pop bx  
				pop ax  
				ret  
				
				
				
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;字符串
  
	getstr:   
				push ax  
;;;;;;;;;
  
	getstrs:  
				mov ah,0  
				int 16h  
				;;;;;;;;;;;;;

				;;;;;;;;;;;;;;;;
				
				cmp al,20h  
				jb nochar  
				

				
				
				
				mov ah,0  
				call charstack  
				mov ah,2  
				call charstack  
				
				
				jmp getstrs  
  
	nochar:    
			    
				cmp ah,0eh  
				je backspace  
				cmp ah,1ch  
				je enterr 
				jmp getstrs  
	backspace: 

				mov ah,1  
				call charstack  
				mov ah,2  
				call charstack  
				jmp getstrs  
	enterr:    
				
				mov al,0  
				mov ah,0  
				call charstack  
				
				mov ah,2  
				call charstack  
				
				

				pop ax  
				ret  
  
  
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	charstack: jmp short charstart  
  
		table  dw charpush,charpop,charshow  
		top    dw 0  
  
	charstart: push bx  
			   push dx  
			   push di  
			   push es  
			   
			
			   cmp ah,2  
			   ja xun  
			   mov bl,ah  
			   mov bh,0  
			   add bx,bx  
			   jmp word ptr table[bx] 


	 charpush: 
			   ;;;;;;

			   ;;;;;;;
			   mov bx,top  
			   mov [si][bx],al  
			   inc top  
			   
			   jmp xun  
  
	 charpop:  cmp top,0  
			   je xun  
			   dec top  
			   mov bx,top  
			   mov al,[si][bx]  
			   jmp sret   
  
	 charshow: mov bx,0b800h  
			   mov es,bx  
			   mov al,160  
			   mov ah,0  
			   mul dh  
			   mov di,ax  
			   add dl,dl  
			   mov dh,0  
			   add di,dx  
  
			   mov bx,0  
  
	charshows: cmp bx,top  
			   jne noempty  
			   mov byte ptr es:[di],' '  
			   jmp sret  
	  noempty: mov al,[si][bx]  
			   mov es:[di],al  
			   mov byte ptr es:[di+1],2  
			   mov byte ptr es:[di+2],' '  
			   inc bx  
			   add di,2  
			   jmp charshows  
			   
			   
		xun:	   


				
				
				cmp top,13
				je xiao5
				
			
			
				cmp top,14
				je xiao9
				
				;cmp top,10
				;jmp xiao222	
			
		
			
			
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		jixu:	 
		
		
			   cmp top,18
			   jne sret 
			   ;;;;;;;;;;;;;;;;;
			   
			   jmp wei0
			   
			  ;;;;;;;;;;;;;;; 
			   

		
		xiao5:
				cmp byte ptr [si][bx],35h
				ja wei12
				cmp byte ptr [si][bx],30h
				jb wei12
				
				jmp sret
				
		xiao9:
				cmp byte ptr [si][bx],39h
				ja wei13
				cmp byte ptr [si][bx],30h
				jb wei13
				
				jmp sret 
			   
		
		wei12:
				mov top,12
				jmp jixu 
		wei13:
				mov top,13
				jmp jixu  
			   
			   
			   
		wei0:	   
		
			   mov top,0
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

			   
		sret:  
			;;;;;;;;;;;;;;
				

			   
			;;;;;;;;;;;;;;
		
		
			  
			   pop es  
			   pop di  
			   pop dx  
			   pop bx  
			   ret  
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				
  
		 jiemian:  
		 
		 
				jmp short show  
				db '1) reset pc',0  
				db '2) start system',0  
				db '3) clock',0  
				db '4) set clock',0  
														
		 show:  push ds  
				push si  
				push ax  
				push es  
				push bx  
				push cx  
				push di  
  
				push cs  
				pop ds  
				mov si,offset jiemian  
				add si,2  
				mov ax,0b800h  
				mov es,ax  
				mov bx,12*160+25*2  
  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
				mov cx,4  
		  show1:   
				push cx  
				mov di,0 
				
				
		  show2:   
		  
				mov cl,[si]  
				mov ch,0  
				jcxz show3 	;是否到达字符串尾部
				
				mov es:[bx+di],cl  
				mov byte ptr es:[bx+di+1],2  
				inc si  
				add di,2  
				jmp show2  
				
		  show3:   
				pop cx  
				inc si  
				add bx,160  
				
				
				
				loop show1  
  
				pop di  
				pop cx  
				pop bx  
				pop es  
				pop ax  
				pop si  
				pop ds  
				
				
				ret                               


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
clear: 
				push ax  
				push es  
				push cx  
				push si  
				  
				mov ax,0b800h  
				mov es,ax  
				mov cx,2000  
				mov si,0  
		kong:   
				mov byte ptr es:[si],' ' 
				mov byte ptr es:[si+1],07
				add si,2  
				loop kong   

				  
				pop si  
				pop cx  
				pop es  
				pop ax  
				
				
				ret  
  
  
		 

code ends 
  
end start  


