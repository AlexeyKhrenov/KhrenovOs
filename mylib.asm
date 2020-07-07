; accepts a pointer to the string in [bx]
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

; accepts a pointer to the char in [bx]
print_char_function:
    pusha

    mov ah, 0x0e
    mov al, [bx]
    int 0x10

    popa
    ret

; accepts hex value inside bx
print_hex_function:
    pusha

    mov ah, 0x0e
    mov al, '0'
    int 0x10
    mov al, 'x'
    int 0x10

    mov ax, bx
    shr ax, 12
    call compare_and_print
    mov ax, bx
    shr ax, 8
    call compare_and_print
    mov ax, bx
    shr ax, 4
    call compare_and_print
    mov ax, bx
    shr ax, 0
    call compare_and_print
    jmp end_of_print_hex_function

    ; private function in function
        compare_and_print:
            and ax, 0x000f
            add al, 0x30

            cmp ax, 0x003a
            jl output

            add al, 0x27 ; letter
                    
            output:
                mov ah, 0x0e
                int 0x10
                ret

    end_of_print_hex_function:
        popa
        ret