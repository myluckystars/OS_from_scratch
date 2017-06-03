; Read some sectors from the boot disk using our disk_load function
[org 0x7c00]

mov [BOOT_DRIVE],dl ; BIOS stores our boot drive in dl, so it's 
                    ;  best to remember this for later.

mov bp,0x8000 ; Here we set our stack safely out of the way, at 0x8000
mov sp,bp

mov bx,0x9000 ; Load 5 sectors to 0x0000(es):0x9000(bx) from the boot disk.
mov dh,5
mov dl,[BOOT_DRIVE]
call disk_load

mov dx,[0x9000] ; Print out the first loaded word, which we expect to be
call print_hex  ; 0xdada, stored at address 0x9000


mov dx,[0x9000 + 512] ; Also, print the first word from the 2nd loaded sector:
call print_hex        ; should be 0xface


jmp $

%include "print_hex.asm"
%include "disk_load.asm"

; Global variable
BOOT_DRIVE db 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

; We know that BIOS will load only th first 512-byte sector from the disk,
; so if we purposely add a few more sectors to our code by repearing some
; familiar numbers, we can prove to ourselfs what we actually loaded those
; additional two sectors from the disk we booted from.
times 256 dw 0xdada
times 256 dw 0xface
