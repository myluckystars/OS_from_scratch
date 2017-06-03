;
; A simple boot sector program that demonstrates segment offsetting
;

mov ah,0xe ; scrolling teletype BIOS routine
mov al,[the_secret] ; move content (character) at the_secret address to al
int 0x10 ; invoke screen-related ISR

mov bx,0x7c0 ; move base address to bx
mov ds,bx ; move base address for correcting label references by CPU to data segment register
mov al,[the_secret] ; move content (character) at the_secret address to al
int 0x10 ; invoke screen-related ISR


mov al,[es:the_secret] ; tell CPU to use es segment as a base for correcting the_secret label reference
int 0x10 ; invoke screen-related ISR


mov bx,0x7c0 ; move base address to bx
mov es,bx ; move base address for correcting label references by CPU to es register
mov al,[es:the_secret] ; tell CPU to use es segment as a base for correcting the_secret label reference
int 0x10 ; invoke screen-related ISR


jmp $ ; hang

; data
the_secret:
db "X"

times 510-($-$$) db 0 ; zero padding
dw 0xaa55 ; magic BIOS number

