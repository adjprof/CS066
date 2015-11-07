; 

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.code
main PROC

.data
arrayD DWORD 1,2,3

.code
mov eax,arrayD

xchg eax,[arrayD+2]		; what is wrong here

xchg eax,[arrayD+4]
xchg eax,[arrayD+8]
mov  arrayD,eax

.data
myBytes BYTE 80h,66h,0A5h

.code
mov al,myBytes
add al,[myBytes+1]
add al,[myBytes+2]

;mov ax,myBytes
;add ax,[myBytes+1]
;add ax,[myBytes+2]

mov	  bx, 0
mov   ax, 0ffffh
movzx ax,myBytes
mov   bl,[myBytes+1]
add   ax,bx
mov   bl,[myBytes+2]
add   ax,bx			; AX = sum

movsx ax,myBytes
mov   bl,[myBytes+1]
add   ax,bx
mov   bl,[myBytes+2]
add   ax,bx			; AX = sum

.data
myNegBytes BYTE -127, -80, 80

.code
mov	  bx, 0
movzx ax,myNegBytes
mov   bl,[myNegBytes+1]
add   ax,bx
mov   bl,[myNegBytes+2]
add   ax,bx				; AX = sum

movsx ax,myNegBytes
mov   bl,[myNegBytes+1]
add   ax,bx
mov   bl,[myNegBytes+2]
add   ax,bx				; AX = sum

.code
mov al,myNegBytes
add al,[myNegBytes+1]
add al,[myNegBytes+2]

.data
myWORDs WORD 08000h,06600h,0A500h

.code
mov	  ebx, 0
movzx eax,myWORDS
mov   bx,[myWORDS+2]
add   eax,ebx
mov   bx,[myWORDS+4]
add   eax,ebx			; AX = sum

movsx eax,myWORDS
mov   bx,[myWORDS+2]
add   eax,ebx
mov   bx,[myWORDS+4]
add   eax,ebx			; AX = sum

	INVOKE ExitProcess,0
main ENDP
END main