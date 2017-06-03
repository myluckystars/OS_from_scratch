;
; A boot sector that prints a string using our function.
;

[org 0x7c00] ; base address for correcting label references by assembler



mov bx,HELLO_MSG ; move address of HELLO_MSG string to bx
call print_string; push instruction pointer onto stack and jump to print_string routine

mov bx,GOODBYE_MSG ; move address of GOODBYE_MSG string to bx
call print_string ; push instruction pointer onto stack and jump to print_string routine

jmp $ ; hang

%include "print_string.asm"

; Data
HELLO_MSG:
db 'Hello world!', 0 

GOODBYE_MSG:
db 'Goodbye!', 0

times 510-($-$$) db 0 ; zero padding
dw 0xaa55 ; magic BIOS number
