; Chapter 6

Comment !
Part of Week 12 inclass demo
!

INCLUDE Irvine32.inc

.data
	str1 BYTE "leftOp > RighOps",0
	str2 BYTE "leftOp <= RighOps",0
	str3 BYTE "Please enter an unsigned integer",0
	str4 BYTE "Please enter an signed integer",0
.code
main PROC

; Task: Jump to a label if unsigned EAX is greater than EBX
; Solution: Use CMP, followed by JA
; Task Jump to label L1 if unsigned EAX is less than or equal to Val1
; Solution: Use CMP, followed by JBE

	mov  edx,OFFSET str3
	call promptText
	mov ebx, eax
	call promptText
	cmp ebx,eax
	ja Larger
	;jbe LessEqual
LessEqual: 
	mov  edx,OFFSET str2
	jmp  printHere
Larger:
	mov  edx,OFFSET str1
printHere:
	call WriteString
	call Crlf

;Task: Jump to a label if signed EAX is greater than EBX
;Solution: Use CMP, followed by JG
;Task: Jump to label L1 if signed EAX is less than or equal to Val1
;Solution: Use CMP, followed by JLE

	mov  edx,OFFSET str4
	call promptTextSignd
	mov ebx, eax
	call promptTextSignd
	cmp ebx,eax
	;jg  Greater
	jle LessEqual1
LessEqual1: 
	mov  edx,OFFSET str2
	jmp  printHere1
Greater:
	mov  edx,OFFSET str1
printHere1:
	call WriteString
	call Crlf

; loop until key pressed

.data
char BYTE ?
.code
L1: 
	mov eax, 10
	call Delay
	call ReadKey
	jz L1
	mov char, AL
	call WriteHex

; example of conditional loop instructions

.data
array SWORD -3,-6,-1,-10,10,30,40,4
sentinel SWORD 0
.code
	mov esi,OFFSET array
	mov ecx,LENGTHOF array
next:
	test WORD PTR [esi],8000h	; test sign bit
	pushfd	; push flags on stack
	add esi,TYPE array
	popfd	; pop flags from stack
	loopnz next	; continue loop
	jnz quit	; none found
	sub esi,TYPE array	; ESI points to value
quit:

	exit
main ENDP

promptText proc
	call WriteString
	call Crlf
	call ReadDec
	ret
promptText endp

promptTextSignd proc
	call WriteString
	call Crlf
	call ReadInt
	ret
promptTextSignd endp

END main