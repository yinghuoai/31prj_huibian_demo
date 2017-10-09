assume cs:code ,ds:data

data segment
	db "welcome to masm!",0



data ends 


code segment

start:

			int 1h
			mov dh,10
			mov dl,10 
			mov cl,2
			mov ax,data 
			mov ds,ax 
			mov si,0


			mov ax,4c00h
			int 21h
			
			
code ends

end start			
			