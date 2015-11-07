; Location Counter asm

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
list BYTE 10,20,30,40
; listx BYTE 10,20,30,40
ListSize = ($ -list)
; ListxSize = ($ -list)

list2 WORD 1000h, 2000h, 3000h, 4000h
List2Size = ($-list2)/2

list3 DWORD 10000000h, 20000000h, 30000000h, 40000000h
List3Size = ($-list3)/4

matrix EQU 10 * 10
; no redefinition on symbol defined with EQU
; matrix EQU <10 * 10>
matrix1 EQU <100 * 100>
matrix2 EQU matrix

; text macro
rowSize = 5
count TEXTEQU %(rowSize *2)
move	TEXTEQU <mov>
setupAL TEXTEQU <move al, count>

.code
main proc
	mov eax, ListSize
	mov eax, List2Size
	mov eax, List3Size
	mov eax, matrix
	mov eax, matrix1
	mov eax, matrix2
	mov eax, count
	setupAL

.data
move	TEXTEQU <add>
setupAL2 TEXTEQU <move al, count>

.code
	setupAL2

	invoke ExitProcess,0
main endp
end main