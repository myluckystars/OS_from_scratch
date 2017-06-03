[bits 16]
%ifndef PRINT_STRING_ASM
%define PRINT_STRING_ASM

print_string:
pusha ; push all register values to the stack
mov ah,0xe ; scrolling teletype BIOS routine

loop: ;  loop while character is not equal to \0
mov cl,[bx]; move character to cl 
cmp cl,0x0 ; compare character to \0
je end ; if equal then end loop
mov al,[bx] ; move character to al 
int 0x10 ; invoke screen-related ISR
inc bx ; increment pointer in bx to next character
jmp loop; redo loop

end: ; end loop
popa ; restore original register values
ret ; pop instruction pointer and jump back to the caller

%endif
