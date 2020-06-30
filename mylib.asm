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

; DH - number of sectors to read
; DL - drive number

disk_load_function:
    pusha
        mov ah, 0x02 ; BIOS function

        ; CH - cylinder - head distance from outer edge
        ; DH - track - specific platter surface within the cylinder (base of 0)
        ; CL - sector on the track (base of 1)
        ; AL - number of sectors to be read from start point and how many sectors were read
        push dx

        mov al, dh
        mov ch, 0x00; cylinder 0
        mov dh, 0x00; head 0
        mov cl, 0x02; second sector

        int 0x13

        jc disk_error

        pop dx
        cmp dh, al

        je end_of_disk_read_function

        disk_error:
            mov bx, disk_error_msg
            call print_string_function

    end_of_disk_read_function:
        popa
        ret

; VARIABLES
disk_error_msg: db "Disk read error!", 0