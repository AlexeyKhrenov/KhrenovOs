[org 0x7c00]

mov bx, msg

call print_string_function

jmp $

; data
msg: db 'Simple operation system', 0
chart: db 't'

; functions
print_char_function:
    pusha

    mov ah, 0x0e
    mov al, [bx]
    int 0x10

    popa
    ret

print_string_function:
    pusha
    
    start:
        mov ah, 0x0e
        mov al, [bx]

        cmp ax, 0x0e00
        je end

        int 0x10
        add bl, 0x01

        jmp start

    end:
        popa
        ret

times 510-($-$$) db 0
dw 0xaa55

