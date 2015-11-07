; Chapter 5

Comment !

!

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
myPopByte BYTE 06h
myPopWord WORD 00a5h

.code
main PROC

; stack illustration, monitor esp

push 06h
;push myPopWord
push 0a5h
push 01h
push 02h
pop ax			; observe the error al and ax
pop ebx
pop ecx
pop edx

; push and pop example

push esi		; push registers
push ecx
push ebx

.data
dwordVal DWORD 12345678h

.code
mov  esi,OFFSET dwordVal 		; display some memory
mov  ecx,LENGTHOF dwordVal
mov  ebx,TYPE dwordVal

pop  ebx		; restore registers
pop  ecx
pop  esi

; nested loop with push pop

.data
;count DWORD ?			; no need as we uses stack to store ecx
.code
	mov ecx,10			; set outer loop count
NL1:
	; mov count,ecx		; save outer loop count
	push ecx
	mov ecx,2			; set inner loop count
NL2:	
	inc eax
	loop NL2				; repeat the inner loop
	;mov ecx,count		; restore outer loop count
	pop ecx
	loop NL1			; repeat the outer loop

; example for pushfd and popfd for EFLAGS
mov al, 80h
add al, 80h
pushfd
add al, 01h
popfd

; example for 32bits register {pushad, popad} and 16bits register {pusha, popa}

.data
myWord WORD 1234h
.code
mov eax, 1h
mov ebx, 2h
mov ecx, 3h
mov edx, 4h
mov esi, offset myword
mov ebp, 5h
mov edi, 6h
pushad
mov eax, 0
mov ebx, 0
mov ecx, 0
mov edx, 0
mov esi, 0
mov ebp, 0
mov edi, 0
pop eax		; watch out the consequence of popad values
popad		; monitor the registers

; demonstrate the procedure 
	mov ax, 0FFFFh
	push ax
	call proc_1
LMain::
	pop ax
	add ax, 1

	INVOKE ExitProcess,0
main ENDP

; definition of procedures

.code
proc_1 PROC
	mov eax, 1234h
	push eax
	call proc_2
	pop eax
	add eax, 1
	;jmp LP2			; LP2 not in the scope
LP1:
	add eax, 2
	ret
proc_1 endp

.code
proc_2 PROC
	mov eax, 4567h
LP2::
	add eax, 3
	jmp LMain			; LMain as Global scope
	ret
proc_2 endp

END main