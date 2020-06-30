[org 0x7c00]

mov [boot_drive], dl ; store boot drive

; allocate stack
mov bp, 0x8000
mov sp, bp

mov bx, 0x9000 ; loading 5 sectors from 0x0000 (ES) : 0x9000 (BX)
mov dh, 0x05
mov dl, [boot_drive]

call disk_load_function

mov bx, [0x9000]
call print_hex_function

jmp $

%include './mylib.asm'

; variables (data):
boot_drive: db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface