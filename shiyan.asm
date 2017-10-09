assume cs:codesg,ss:stacksg,ds:datasg


stacksg segment
	dt 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
	db '1.HeBEInOnGYedAx'
	db '2.UeDAAsSemBLyla'
	db '3.NGuAGE        '
	db '4.              '


datasg ends


codesg segment

	start:
		mov ax,datasg
      	mov ds,ax

        mov ax,stacksg
        mov ss,ax
        mov sp,10h

        mov bx,0
		
	mov cx,40h	
	
	xun:
		mov al,5bh
		cmp [bx],al
		jc bxiao
		
      
	  
		
		
	bda:
		mov al,[bx]
        sub al,20h
        mov [bx],al
        inc bx
	
		jmp jixu	
		
	  
	bxiao:
		mov al,[bx]
        or al,20h
        mov [bx],al
        inc bx
        jmp jixu	

		jixu:
		
		loop xun
		
        mov ax,4c00h
        int 21h
	      
	
codesg ends

end start