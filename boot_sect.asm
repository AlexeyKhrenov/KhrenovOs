mov ah, 0x0e

mov al, [msg]
int 0x10

loop:
    jmp loop

msg: db "This is quite simple OS", 0
smb: db "X"

times 510-($-$$) db 0
dw 0xaa55