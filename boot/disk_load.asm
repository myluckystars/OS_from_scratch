[bits 16]
;
; Load dh sectors to es:bx from drive dl
;


%ifndef DISK_LOAD_ASM
%define DISK_LOAD_ASM

disk_load:
push dx ; Store dx on stack so later we can recall how many sector
        ; were request to be read, even if it is altered in the mean time
mov ah,0x02 ; BIOS read sector function
mov al,dh ; Read dh sectors
mov ch,0x00 ; Select cylinder 0
mov dh,0x00 ; Select head 0
mov cl,0x02 ; Start reading from second sector (i.e. after the boot sector)
int 0x13 ; Invoke disk-related ISR

;jc disk_error ; Jump if error (i.e. carry flag set)

pop dx ; Restore dx from the stack
;cmp dh,al ; if al (sectors read) != dh (sectors expected)
;jne disk_error ; display error message
ret

disk_error:
mov bx,DISK_ERROR_MSG
call print_string
jmp $

%include "print_string.asm"

; Variables
DISK_ERROR_MSG: db "Disk read error!",0

%endif
