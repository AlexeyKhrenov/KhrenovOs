[org 0x7c00]
    
    KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl

    mov bp, 0x9000 ; set-up stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string_function

    call load_kernel

    call switch_x32_function

    jmp $

    %include './disk_load.asm'
    %include './mylib.asm'
    %include './gdt_table.asm'
    %include './switch_x32.asm'
    %include './32bit_print.asm'

    [bits 16]
    load_kernel:
        mov bx, MSG_LOAD_KERNEL
        call print_string_function

        mov bx, KERNEL_OFFSET
        mov dh, 15
        mov dl, [BOOT_DRIVE]

        call disk_load_function
        
        ret

    [bits 32]
    begin_pm:
        mov ebx, MSG_PROT_MODE
        call print_string_pm

        call KERNEL_OFFSET

        jmp $

BOOT_DRIVE:         db 0
MSG_REAL_MODE:      db "Started in 16-bit real mode", 0 ;0xA, 0xD
MSG_PROT_MODE:      db "Switched to 32-bit protected mode", 0
MSG_LOAD_KERNEL:    db "Loading kernel into memory", 0
MSG_DEBUG:          db "Debug", 0

times 510-($-$$) db 0
dw 0xaa55