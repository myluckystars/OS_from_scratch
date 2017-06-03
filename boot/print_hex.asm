%ifndef PRINT_HEX_ASM
%define PRINT_HEX_ASM

print_hex:
pusha ; push all register values to the stack
mov bx,HEX ; move base address of HEX string to bx
add bx,5 ; set address to end of HEX string
mov cx,0 ; initialize counter

loop2: 
cmp cx,3 ; if counter greater than 3
jg end2  ; end loop
mov ax,dx ; mov hex value to ax
and ax,0x000F ; mask hex value except for last 4 bits
cmp ax,10 ; if hex value greater or equal to 10 jump to letters
jge letters

digits:
add ax,48 ; convert to ASCII
jmp create_hex

letters:
add ax,55 ; convert to ASCII

create_hex:
mov [bx],al ; move ASCII character to corresponding place the HEX string
dec bx ; decrement address by one so it points to the previous character position in the HEX string
shr dx,4 ; shift hex value to the right so next hex digit can be processed 
inc cx ; inrement counter
jmp loop2

end2:
mov bx,HEX ; move address HEX string to bx
call print_string
popa ; restore original register values
ret ; pop instruction pointer and jump back to caller

%include 'print_string.asm'

HEX: 
db '0x0000',0 ; template for HEX string

%endif
