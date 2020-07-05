[org 0x7c00]

    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string_function

    call switch_x32_function

    jmp $

    %include './mylib.asm'
    %include './gdt_table.asm'
    %include './switch_x32.asm'
    %include './32bit_print.asm'

    [bits 32]
    begin_pm:
        mov ebx, MSG_PROT_MODE
        call print_string_pm
        jmp $

MSG_REAL_MODE: db "Started in 16-bit real mode", 0 ;0xA, 0xD
MSG_PROT_MODE: db "Switched to 32-bit protected mode", 0

times 510-($-$$) db 0
dw 0xaa55