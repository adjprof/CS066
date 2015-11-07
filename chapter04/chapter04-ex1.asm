; Chapter 4 Data Transfer Instructions 

Comment !
Example commet
!

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
var1 BYTE 10, 20, 30, 40
var2 \
BYTE 10, 20, 30, 40
BYTE 50, 60, 70, 80

.code
main PROC
	mov al, [var1]
	mov al, var2

Comment !
This section illustrate the storage size limitation on the destation and source operands
!
.data
count BYTE 65h
wVal  WORD 2

.code
	mov bx,0ffffh
	mov bl,count
	mov bh, bl
	mov ax,wVal
	mov count,ah	; swap al with ah

	; mov al,wVal		; error with "instruction operands must be the same size"
	; mov ax,count		; error with "instruction operands must be the same size"
	; mov eax,count		; error with "instruction operands must be the same size"
	
Comment !
Your Turn: This section illustrate the storage size limitation on the destation and source operands
!
.data
yr_bVal  BYTE   100
yr_bVal2 BYTE   ?
yr_wVal  WORD   2
yr_dVal  DWORD  5

.code
	; mov ds,45				; can not move to segment from immediate 
	mov ds, ax				; ds and ax both in 16 bits 
	mov ah, al
	mov al,ah
	;mov esi,yr_wVal		; size mismatch; esi as 32 bits and yr_wVal as 16 bits
	;mov esi, yr_dVal		; esi and DWORD both in 32 bits, watch out the memory access violation
	;mov eip,yr_dVal		; eip can not be destination		
	;mov 25,yr_bVal			; immediate can not be the destination
	;mov yr_bVal2,yr_bVal	; memory to memory not allowed
	;mov yr_bVal2,ah			; register to memory, watch out the memory access violation

Comment !
Overlapping Value
!
.data
oneByte BYTE 78h
oneWord WORD 1234h
oneDword DWORD 12345678h

.code
mov eax, 0
mov al, oneByte
mov ax, oneWord
mov eax, oneDword
mov ax, 0

Comment !
Copying Smaller values to Larger ones
!

.data 
count1 WORD 1
.code
mov ecx, 0
mov cx, count1

; move with signed integer 
.data
signedVal SWORD -16
.code
mov ecx, 0
mov cx, signedVal		; EXC = 0000FFF0h losing signed bit 

Comment !
Sign Extension
!

.code
mov ecx, 0FFFFFFFFh
mov cx, signedVal

.code
mov ecx, 0
movsx ecx, signedVal

.code
mov ecx, 0FFFFFFFFh
movsx ecx, count1

Comment !
LAHF / SAHF
!

.data
saveflags BYTE ?

.code
lahf					; load flags into AH
mov saveflags, ah		; save them in a variable
mov ah, saveflags		; load saved flags from variable to AH
sahf					; copy into Flags register


	INVOKE ExitProcess,0
main ENDP
END main