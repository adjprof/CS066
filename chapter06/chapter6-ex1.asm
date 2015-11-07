; Chapter 6 Logical Example

Comment !
!

INCLUDE Irvine32.inc

.data

lowA BYTE 'a'
decDig BYTE 0
convtByte BYTE 11011111b

.code
main PROC

; Task: Convert the Char in al to upper case
; Solution: Use the AND instruction to clear bit 5

	mov ecx, 26
N1:
	movzx eax,lowA			; AL = 01100001b
	;and eax,convtByte		; AL = 01000001b
	;and al,convtByte
	and al, 11011111b
	call writeHex
	call Crlf
	inc lowA
	loop N1

; Convert a binary decimal byte into its equivalent ASCII decimal digit
; Solution: use the OR instruction to set bit 4 and 5

	mov ecx, 10
N2:
	movzx eax,decDig	; AL = 00000110b
	or	eax,00110000b	; AL = 00110110b
	call writeHex
	call Crlf
	inc decDig
	loop N2

; Turn on the keyboard CapsLock key
; Solution: use the OR instruction to set bit 6 in the keyboard flag byte at 0040:0017h in the BIOS data area
comment!
	mov eax,040h			; BIOS segment
	mov	ds,eax
	mov ebx,017h			; keyboard flag byte
	or BYTE PTR [ebx],01000000b	; CapsLock on
!

; Jump to a label if an integer is even
; Solution: AND the lowest bit with a 1.  If result is Zero, the number was even

comment!
.data
	str1 BYTE "This is Odd Number",0
	str2 BYTE "This is Even Number",0
	str3 BYTE "Please enter an integer",0
.code
	mov  edx,OFFSET str3
	call WriteString
	call Crlf
	call ReadDec
	; mov ax,31
	;and eax,1		; low bit set?
	test eax,1		; TEST low bit set where zero flag will be affect but not eax
	jz  EvenValue	; jump if Zero flag set
	mov  edx,OFFSET str1
	jmp  printHere
EvenValue:
	mov  edx,OFFSET str2
printHere:
	call WriteString
	call Crlf

; Jump to a label if the value in AL is not zero
; Solution; OR the byte with itself, then use the JNZ (jump is not zero) instruction

.data
	str4 BYTE "You have entered an Zero",0
.code
	mov  edx,OFFSET str3
	call WriteString
	call Crlf
	call ReadDec
	or eax, eax
	jnz endHere

	mov  edx,OFFSET str4
	call WriteString
	call Crlf

endHere:
!

; cmp example

mov al,5
cmp al,4	; Sign flag == Overflow flag

mov al,4
cmp al,5	; Sign flag != Overflow flag

mov al,5
cmp al,5	; ZF flag is 1


	exit
main ENDP
END main