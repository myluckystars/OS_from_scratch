;
; Boot sector program demonstrating if-else in assembly
;


mov bx,3

; if (bx <= 4) {
; 	mov al,'A';
; } else if ( bx < 40 ) {
; 	mov al, 'B';
; } else {
; mov al,'C'
; }

cmp bx,4
jle if_block
cmp bx,40
jl else_if_block
mov al, 'C'
jmp end_block

if_block:
mov al,'A'
jmp end_block

else_if_block:
mov al,'B'

end_block:
mov ah,0x0e
int 0x10

times 510-($-$$) db 0
dw 0xaa55
