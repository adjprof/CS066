; 

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

Comment !
ALIGN Directive
!

.data
bVal	BYTE ?
ALIGN 2
wVal	WORD ?
bVal2	BYTE ?
ALIGN 2
dVal	DWORD ?
;dVal4	DOWRD ?

.code
main PROC

Comment !
OFFSET Operator
!

.data 
myArray WORD 1,2,3,4,5
myPointerWORD WORD ?
myPointerDWORD DWORD ?
.code
mov esi, OFFSET myArray
;mov al, myArray
mov al,[esi]					; power of pointer but also dangerous 
mov esi, OFFSET myArray+4		; ESI points to the 3rd integer in the array
mov ax, myArray+4
mov bl,[esi]

mov eax, OFFSET myArray			; you can use other register as pointer
mov bl, [eax] 
mov cx, [eax]

mov myPointerDWORD, OFFSET myArray	; interesting experiment here !!
mov esi, myPointerDWORD
mov ecx, [esi] 

.data
bigArray DWORD 500 DUP(?)
pArray DWORD bigArray				; pArray points to the beginning of the bigArray
.code
mov esi, pArray
mov bigArray, 01h
mov bigArray+4, 02h
mov eax, [esi]
mov eax, [esi+4]

Comment !
PTR Operator
!

.data
myDouble DWORD 12345678h
.code
;mov ax,myDouble 				; error – why?
mov ax,WORD PTR myDouble		; loads 5678h; due to little endian storage format
mov eax,DWORD PTR myDouble		; loads 12345678h
mov ebx, myDouble
mov WORD PTR myDouble,4321h		; saves 4321h

.data
myBytes BYTE 12h,34h,56h,78h
.code
mov ax,WORD PTR [myBytes]		; AX = 3412h
mov ax,WORD PTR [myBytes+2]		; AX = 7856h
mov eax,DWORD PTR myBytes		; EAX = 78563412h

.data
wordList WORD 5678h, 1234h
.code
mov eax, DWORD PTR wordList		; EAX = 12345678h

.data
varB BYTE 65h,31h,02h,05h
varW WORD 6543h,1202h
varD DWORD 12345678h
.code
mov ax,WORD PTR [varB+2]		;
mov bl,BYTE PTR varD			; 
mov bl,BYTE PTR [varW+2]		; 
mov ax,WORD PTR [varD+2]		; 
mov eax,DWORD PTR varW			; 

Comment !
Labor Directive
!

.data
dwList   LABEL DWORD
wordListL LABEL WORD
intList  BYTE 00h,10h,00h,20h
dwList2   LABEL DWORD
intlist2  BYTE 00h,10h,00h,20h
.code
mov eax,dwList		; 20001000h
mov cx,wordListL	; 1000h
mov dl,intList		; 00h
mov eax,dwList+4

	INVOKE ExitProcess,0
main ENDP
END main