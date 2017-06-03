;
; A simple boot sector program that demonstrates addressing.
;

[org 0x7c00] ; base address (where our code is loaded) used for correcting label references by assembler

mov ah,0x0e ;scrolling teletype BIOS routine

; First attempt

mov al,the_secret
int 0x10 ; Does this print an X? With/without org -> NO

; Second attempt

mov al,[the_secret] 
int 0x10 ; Does this print an X? With org -> YES. Without org -> NO

; Third attempt

mov bx,the_secret
add bx,0x7c00
mov al,[bx]
int 0x10 ; Does this print an X? With org -> NO. Without org -> YES

; Fourth attempt

mov al,[0x7c1d]
int 0x10; Does this print an X? With/without org -> YES

jmp $ ; Jump forever

the_secret:
db "X"

; Padding magic BIOS number
times 510-($-$$) db 0
dw 0xaa55
