; Evaluate Expression (5+4)-(2+3) = 4

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
var1 DWORD 5
var2 DWORD 4
var3 DWORD 2
var4 DWORD 3
result DWORD ?

.code
main proc
	mov eax, var1
	add eax, var2
	mov ebx, var3
	add ebx, var4
	sub eax, ebx
	mov result, eax

	invoke ExitProcess,0
main endp
end main