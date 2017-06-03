;
; A boot sector that prints a hex string using our function.
;

[org 0x7c00] ; base address for correcting label references by assembler

mov dx,0xFAA4
call print_hex


jmp $ ; hang

%include "print_hex.asm"


times 510-($-$$) db 0 ; zero padding
dw 0xaa55 ; magic BIOS number
