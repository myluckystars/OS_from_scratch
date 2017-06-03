;
; A simple boot sector program that demonstrates the stack
;

mov ah,0x0e ; scrolling teletype BIOS routine

mov bp, 0x8000 ; Set the base of the stack a little above where BIOS
mov sp, bp     ; loads our boot sector - so it won't overwrite us.

push 'A' ; Push some character on the stack for later retrieval. Note, these
push 'B' ; are pushed on as 16-bit values, so the most significant byte will
push 'C' ; be added by our assembler as 0x00.

pop bx	  ; Note, we can only pop 16-bits, so pop to bx then copy bl
mov al,bl ; (i.e. 8-bit char) to al
int 0x10  ; invoke screen-related ISR

pop bx    ; Pop the next value
mov al,bl
int 0x10

mov al,[0x7ffe] ; To prove our stack grows downwards from bp, fetch the char
		; at 0x8000 - 0x2 ( i.e. 16-bits)

int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
