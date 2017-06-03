;
; A simple boot sector program that loops forever
;

loop:

jmp loop ; jump to current instruction, i.e. hang

times 510-($-$$) db 0 ; pad code with (510-"current position"-"start position" =508) zeroes

dw 0xaa55 ; magic BIOS number ( in little endian format: 55 00)  
