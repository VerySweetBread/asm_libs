format ELF
public filename as 'path.filename'

include '../include/_macros.inc'
extrn string.len

section '.text' executable
filename:
    prelude

    mov eax, [ebp+2*4]
    push eax
    call string.len
    pop ebx

    .loop:
        cmp [ebx+eax], byte '/'
        je .break
        cmp ebx, 0
        je .break

        dec ebx
        jmp .loop
    .break:
        add eax, ebx
        inc eax
        mov [ebp+2*4], eax
        postlude
        ret