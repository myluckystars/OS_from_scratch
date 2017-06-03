;
; Boot sector program demonstrating function calls in assembly.
;

;mov bp,0x8000
;mov sp,bp

mov ah,0x0e
mov al,'i'
call print_H
int 0x10
jmp $


print_H:
pusha
mov al,'H'
int 0x10
popa
ret

times 510-($-$$) db 0
dw 0xaa55
