.model small
.stack 200h
.data
	filename db "E:/Students.txt",0
	filehandle dw ?
	
	
	
	num db 00h
	count db 00h
	
	
	readerror db 10,13,"File contents cannot be read $"
	msg1 db 10,13,"Enter 1 - Insert, 2 - Delete, 3 - Avg of particular student 4 - Exit $"
	msg2 db 10,13,"Invalid choice. Please reenter $"
	msg5 db 10,13,"Enter the record no to delete : $"
	
	
	error1 db 10,13,"ERROR!!!! $"

.code
	mov ax,@data
	mov ds,ax
	mov es,ax
	
	public filehandle,count,filename
	extrn btod:far
	extrn dec_hex:far
	extrn fwrite:far
	extrn favg:far
	extrn fdelete:far
	
	mov ax,@data
	mov ds,ax
	mov ah,3ch
	lea dx,filename
	mov cx,0
	int 21h
	jc exit
	mov ah,3dh
	mov al,2
	int 21h
	jc exit
	mov filehandle,ax
start:
	lea dx,msg1
	mov ah,9
	int 21h
	mov ah,1
	lea dx,num
	int 21h   
	mov num,al
	cmp al,'1'
	je Loop1
	cmp al,'2'
	je Loop2
	cmp al,'3'
	je Loop3
	cmp al,'4'
	je exit
	lea dx,msg2
	mov ah,09h
	int 21h
	jmp start
Loop1:
	call fwrite
	inc count
	jmp start
Loop2:
	;to delete the record
	;disp msg5
	call fdelete
	jmp start
Loop3:
	call favg
	cmp al,1
	je exit
	jmp start
exit:
	mov ah,3eh
	mov bx,filehandle
	int 21h
	mov ah,4ch
	int 21h

end