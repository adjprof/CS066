; Chapter 5 with Irvine Lib

Comment !
Part of Week 10 inclass demo
!

INCLUDE Irvine32.inc

.data

.code
main PROC

mov  eax,1234h	; input argument
call WriteHex	; show hex number
call Crlf		; end of line

; delay the program for 500 miniseconds; clear the screen, and dump the register and flags

mov  eax,3000
call Delay
call Clrscr
call DumpRegs

; display a null-terminated string and move the cursor to the beginning of the next screen line

.data
str1 BYTE "PCC CS66 students say - Assembly language is easy!",0
str2 BYTE "This can not be true. ;-)",0Dh,0Ah,0

.code
call Delay
call Crlf
mov  edx,OFFSET str1
call WriteString
call Crlf

mov edx, OFFSET str2
call WriteString

; display an unsigned integer in binary, hex in separate line

IntVal = 35	
.code
	mov  eax,IntVal
	call WriteBin	; display binary
	call Crlf
	call WriteDec	; display decimal
	call Crlf
	call WriteHex	; display hexadecimal
	call Crlf

; Input a string from the user. EDX points to the string and ECX specifies the maximum number of characters the user is permitted to enter

comment!
!

.data
fileName BYTE 80 DUP(0)
.code
	mov  edx,OFFSET fileName
	mov  ecx,(SIZEOF fileName)-1
	call ReadString
	call WriteString		; echo what user input
	call Crlf


; Generate and display ten pseudorandom signed integers in the range 0 – 99. Pass each integer to WriteInt in EAX and display it on a separate line.

.code
	mov ecx,10	; loop counter

L1:	mov  eax,100	; ceiling value
	call RandomRange	; generate random int
	call WriteInt	; display signed int
	call Crlf	; goto next display line
	loop L1	; repeat loop

; Display a null-terminated string with yellow characters on a red background.

.data
str3 BYTE "PCC Color output is easy!",0

.code
	mov  eax,yellow + (red * 16)
	call SetTextColor
	mov  edx,OFFSET str3
	call WriteString
	mov  eax,yellow + (blue * 16)
	call SetTextColor
	call WriteString
	call Crlf

exit

main ENDP
END main