.model small
.stack
.data
	msg5 db 10,13,"Enter the record no to delete : $"
	msg10 db 10,13,"The record does not exist. Please Re-enter $"
	msg11 db 10,13,"Failed to create file $"
	filename2 db "E:/S1.TXT",0
	filename3 db "E:/Students.txt",0
	filehandle1 dw ?
	num1 db 0
	num2 db 0
	count1 db 0
	arrbuff label byte
	arr1 db 16 dup(0)
	end_of_arr db '20$'
	
	num3 db 0
	num4 db 0
	num5 db 0
	
	
.code
	public fdelete
	extrn count:BYTE
	extrn filehandle:WORD
	extrn rename:far
	

	fdelete proc far
d1:	mov ah,9
	lea dx,msg5
	int 21h
	mov ah,1
	lea dx,num1
	int 21h
	sub al,30h
	mov num1,al
	cmp al,count
        jng n	 
	lea dx,msg10
	mov ah,09h
	int 21h
	jmp d1

n:	mov ah,3ch
	lea dx,filename2
	mov cx,0
	int 21h
	jc exit2
	mov ah,3dh
	mov al,2
	int 21h
	jc exit3
	mov filehandle1,ax
	mov al,0
	mov bx,filehandle
	xor cx,cx
	xor dx,dx
	mov ah,42h
	int 21h
	jmp write

exit2: ;lea dx,msg11
	;mov ah,09h
	;int 21h
	;mov ah,4ch
	;int 21h


write:	mov al,count1
	cmp count,al
	jz  eofwrite
	mov dx,offset arrbuff
	inc count1
	mov al,17
	mov bl,count1
	mul bl
	mov num2,al
	mov cx,ax
	mov ah,3fh
	mov bx,filehandle
	int 21h
        mov al,count1
        cmp num1,al
	jz seek
	mov bx,filehandle1
	mov ah,42h			;Seeking End Of file
	mov al,2			;al=2 means from end of file
	xor cx,cx			;No of bytes = cx:dx to move from specified location
	xor dx,dx
	int 21h	
	mov ah,40h			
	mov cx,17			
	lea dx,arr1
	int 21h
seek:	mov ah,42h
	mov al,1
	mov bx,filehandle
	mov cx,0
	MOV DH,0
	mov dl,num2
	int 21h
        ;mov dl,count1
        ;cmp count,dl
	jmp write
	
eofwrite:mov ax,filehandle1
	mov filehandle,ax
	jmp del


exit3: lea dx,msg11
	mov ah,09h
	int 21h
	mov ah,4ch
	int 21h
	

del: 	mov ah, 41h
	mov dx, offset filename3
	dec count
	int 21h


	

call rename
	ret

fdelete endp




end
