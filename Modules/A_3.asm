.model small
.stack
.data
	msg6 db 10,13,"Enter the record no to find average : $"
	msg7 db 10,13,"Entered record doesnot found please reenter : $"

	readcontent db 10 dup(0)
.code


extrn count:BYTE
extrn filehandle:WORD

extrn dec_hex:far
extrn btod:far

public favg

favg	proc far
L30:
	lea dx,msg6
	mov ah,09h
	int 21h
	 
	mov ah,1
	int 21h
	sub al,30h
	cmp al,count
	jng L31
	lea dx,msg7
	mov ah,09h
	int 21h
	jmp L30
L31:	sub al,1	
	mov cl,17
	mul cl
	add ax,8
	xor cx,cx
	mov dx,ax
	mov bx,filehandle
	mov ah,42h
	mov al,0
	int 21h
	jnc L33
	mov al,1
	ret
L33:
	lea dx,readcontent
	mov ah,3fh
	mov cx,9
	mov bx,filehandle
	int 21h
	jnc L32
	mov al,1
	ret
L32:	
	mov si,0
	mov bx,0
	mov dx,3
read:
	inc si  
	mov al,readcontent[si]
	inc si

	mov ah,readcontent[si]
	inc si
	sub ax,3030h
	xchg ah,al
	mov cl,4
	shl al,cl
	shr ax,cl
	jmp l2_a

l2_a: 
	call dec_hex
	add bx,al
	dec dx
	jnz read

    
l1:	
	mov cl,3
	mov ax,bx
	div cl
	call btod
	mov al,0
	ret
favg endp

end
