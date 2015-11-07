; 

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main PROC

Comment !
INC and DEC examples
!

.data
myWord  WORD 1000h
myDword DWORD 10000000h
saveflags BYTE ?
.code
	inc myWord 	; 1001h
	dec myWord	; 1000h
	inc myDword	; 10000001h

	mov ax,00FFh
	inc ax		; AX = 0100h
	mov ax,00FFh
	inc al		; AX = 0000h, noted that ZR = 1; ZR - ZF where Zero Flag when result as 0

	mov saveflags, 0		; clear up the ELAGS
	mov ah, saveflags
	sahf

	mov ax,00EFh
	inc ax		; AX = 00F0h. AC = 1 
	mov ax,00FEh
	inc al		; AX = 00FFh, 

Comment !
NEG instruction
!

.data
valB BYTE -1
valW WORD +32767
valSW SWORD -32767

.code
	mov al,valB		; AL = -1
	neg al			; AL = +1, from FFh to 01h
    mov bx, valW
	mov cx, valSW
	add bx, cx		; valW + valSW = 0
	neg valW		; valW = -32767
	mov ax, valSW
	neg ax			; 
	neg valSW		; valSW = 32767
	mov bx, valW
	mov cx, valSW
	add bx, cx		; valW + valSW = 0

.data
valB1 BYTE 1,0
valC1 SBYTE -128
.code
	mov saveflags, 0		; clear up the ELAGS
	mov ah, saveflags
	sahf

	neg valB1		; CF = 1, OF = 0
	neg [valB1 + 1]	; CF = 0, OF = 0
	neg valC1		; CF = 1, OF = 1

; Example 1
mov al,+126
add al,1
mov al,+127
add al,1	; OF = 1,   AL = ??

; Example 2
mov al,+126
add al,1
mov al,7Fh	; OF = 1,   AL = 80h
add al,1

; Example 3
mov al,+126
add al,1
mov al,80h
add al,01h
add al,92h		; OF =1

mov al,-2
add al,+127	; OF = 0


	INVOKE ExitProcess,0
main ENDP
END main