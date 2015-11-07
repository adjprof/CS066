; Chapter 3 Initializer

Comment !
Demo the multiple initializer and the size of EXE impact
> with .data?
9,728 Lab04.exe

> without .data?
33,792 Lab04.exe
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
var3 BYTE "Good afternoon", 0
var4 BYTE "Welcome to Pasadena City College"
	 BYTE "created by Ken Chang.", 0
var5 \
	 BYTE "hello world", 0
var6 BYTE 20 DUP(0)
var7 BYTE 20 DUP(?)
var8 BYTE 4 DUP("CS66")
COUNT = 500

; try comment this out and observe the size of exe
.data			
bigArray DWORD 5000 DUP(?)

.code
main PROC
	mov al, [var1]
	mov al, var2
	COUNT = 600
	mov ebx, COUNT

	INVOKE ExitProcess,0
main ENDP
END main