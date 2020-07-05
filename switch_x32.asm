[bits 16]
switch_x32_function:
    cli                                 ; switch off interrupts

    lgdt [gdt_descriptor]

    mov eax, cr0
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:start_protected_mode   ; far jump

[bits 32]
    start_protected_mode:
    
        mov ax, DATA_SEG
        mov ds, ax
        mov ss, ax                          ; stack segment
        mov es, ax                          ; destination segment
        mov fs, ax                          ; ?
        mov gs, ax                          ; ?


        mov ebp, 0x9000
        mov esp, ebp

    call begin_pm

