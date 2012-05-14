.model small
.stack
.data

oldname db "E:/S1.TXT",0
newname db "E:/Students.txt",0
msg1 db 10,13,"Bad Rename $"

.code
public rename
mov ax,@data
mov ds,ax
mov es,ax
rename proc far
lea dx,oldname
lea di,newname
mov ah,56h
int 21h
jc badrename

ret
rename endp

badrename: lea dx,msg1
	mov ah,09
	int 21h
	mov ah,4ch
	int 21h

end