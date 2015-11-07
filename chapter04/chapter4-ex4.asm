; Chapter 4 Loop Example

Comment !

!

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

.data


.code
main PROC

Comment !
Example for Indirect Addressing
!

.data
varx WORD -4
val1 BYTE 10h, 20h, 30h
;val1 WORD 10h, 20h, 30h
.code
;mov eax, eip
; mov DWORD PTR [eax], 1234h
movsx edx, varx
sub ax, varx
mov esi, OFFSET val1
mov al, [esi]			; dereference ESI(AL = 10h)
mov ax, [esi]			; if array data type is WORD
mov eax, [esi]

inc esi
mov al, [esi]			; AL = 20h
inc esi
mov al, [esi]			; AL = 30h

; inc [esi]				; result in error with mismatched operand
inc BYTE PTR [esi]
mov al, [esi]			; AL = 31h

;add [esi],2
add BYTE PTR [esi], 2
mov al, [esi]			; AL = 33h

Comment !
Example for Arrays
!

.data
arrayW WORD 1000h,2000h,3000h
.code
mov esi,OFFSET arrayW
mov ax,[esi]
add esi,2				;
add ax,[esi]
add ax,[esi+2]			; AX = sum of the array

.data
arrayDW DWORD 100000h,200000h,300000h
.code
mov esi,OFFSET arrayDW
mov eax,[esi]
add esi,4				; or: add esi,TYPE arrayDW
add eax,[esi]
add esi, TYPE arrayDW
add eax,[esi]			; EAX = sum of the array

.data
arrayWW WORD 1000h,2000h,3000h
.code
mov esi,0
mov ax,[arrayWW + esi] 			; AX = 1000h
mov ax,arrayWW[esi]				; alternate format
add esi,2
add ax,[arrayWW + esi]

; Index Scaling

.data
arraysB BYTE  0,1,2,3,4,5
arraysW WORD  0,1,2,3,4,5
arraysD DWORD 0,1,2,3,4,5

.code
mov esi,4
mov al,arraysB[esi*TYPE arraysB]		; 04
mov bx,arraysW[esi*TYPE arraysW]		; 0004
mov edx,arraysD[esi*TYPE arraysD]		; 00000004

.data
arrayPW WORD 1000h,2000h,3000h
ptrW DWORD arrayPW
ptrW2 DWORD OFFSET arrayW
.code
mov esi,ptrW
mov ax,[esi]							; AX = 1000h
mov esi,ptrW2
mov ax,[esi]							; AX = 1000h

; simple loop

.data
bCount BYTE ?
pCount WORD ?
pDCount DWORD ?
.code
mov ax, 0
mov ecx, 5
L1:
add bCount, cl							; offset 6
add pCount, cx							; offset 7
add pDCount, ecx						; offset 6
loop L1

.code
mov ax,6
mov ecx,4
L2:
inc ax
loop L2

Comment !
mov ecx,0				; This is dangerous 
L3:
inc eax
loop L3
!

; nested loop

.data
count DWORD ?
.code
	mov ecx,100			; set outer loop count
NL1:
	mov count,ecx		; save outer loop count
	mov ecx,20			; set inner loop count
NL2:	
	inc eax
	loop NL2				; repeat the inner loop
	mov ecx,count		; restore outer loop count
	loop NL1			; repeat the outer loop

.code
	mov ecx, 2
	mov eax, 0
	mov ebx, 0
	loop NL3
	inc ebx
	ret
NL3: 
	inc eax
	ret

INVOKE ExitProcess, 0
main ENDP
END main