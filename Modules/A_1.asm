.model small
.stack
.data
.code
public dec_hex
public btod
dec_hex proc far
	push bx
	push cx
	push dx
	mov cl,4
	shl ax,cl
	shr al,cl
	xchg ah,al
	mov bh,ah
	mov bl,10
	mul bl
	add al,bh
	pop dx
	pop cx
	pop bx
	ret
dec_hex endp 

btod proc far
	push dx
	push bx
	push cx
	mov dx,0
	mov cx,2
	mov bx,10
do: div bx
	push dx
	mov dx,0
	loop do
	mov ah,2
	mov dl,10
	int 21h
	mov dl,13
	int 21h
	mov cx,2
d1: pop dx
	add dx,30h
	int 21h
	loop d1
	pop cx
	pop bx
	pop dx
	ret
btod endp

END