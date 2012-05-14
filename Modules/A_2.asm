.model small

.stack

.data
	namebuff label byte
	maxchar db 10
	readchar db 0
	names db 8 dup(0)
	end_of_name db '$'
	marksbuff label byte
	maxchar2 db 11
	readchar2 db 0
	marks db 9 dup('$')
	
	msg3 db 10,13,"Enter Name : $"
	msg4 db 10,13,"Enter the 3 marks of the student : $"

.code

	extrn filehandle:WORD

public fwrite

fwrite	proc far
	lea dx,msg3
	mov ah,09h
	int 21h
	mov dx,offset namebuff
	mov ah,10
	int 21h
	mov dx,offset msg4
	mov ah,09h
	int 21h
	mov ah,10
	mov dx,offset marksbuff
	int 21h
	mov bx,filehandle
	mov ah,42h			;Seeking End Of file
	mov al,2			;al=2 means from end of file
	xor cx,cx			;No of bytes = cx:dx to move from specified location
	xor dx,dx
	int 21h	
	mov ah,40h			
	mov cx,8			
	lea dx,names
	int 21h

	mov bx,filehandle
	mov ah,42h			;Seeking End Of file
	mov al,2			;al=2 means from end of file
	xor cx,cx			;No of bytes = cx:dx to move from specified location
	mov dx,1
	int 21h	
	mov cx,8
	mov ah,40h
	lea dx,marks
	int 21h
	ret
fwrite endp

END