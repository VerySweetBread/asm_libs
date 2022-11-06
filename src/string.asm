format ELF
public copy as 'string.copy'
public len  as 'string.len'

include "../include/_macros.inc"

section '.string.text' executable
copy:
    prelude

    mov eax, [ebp+3*4]
    mov ebx, [ebp+2*4]
    xor ecx, ecx      

    .loop:
        cmp [eax+ecx], byte 0
        je .break

        mov dl, [eax+ecx]
        mov [ebx+ecx], dl
        inc ecx
        
        jmp .loop
    .break:
        mov eax, [ebp+4]
        mov [ebp+3*4], eax
        postlude
        add esp, 4*2
        ret

len:
    prelude

    mov eax, [ebp+2*4]
    xor ebx, ebx

    .loop:
        cmp [eax+ebx], byte 0
        je .break

        inc ebx
        jmp .loop
    .break:
        mov [ebp+2*4], ebx
        postlude
        ret