format ELF
public char as 'print.char'
public _str as 'print.str'
public nl   as 'print.nl'
public _bin as 'print.bin'
public _int as 'print.int'
public exit

include '../include/_macros.inc'

_new_line equ 10

section '.bss' writeable
buffer rb 32

section '.std.text' executable
char:
    prelude

    mov cl, [ebp+2*4]
    mov [buffer], cl

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 1
    int 80h

    mov [buffer], byte 0

    mov eax, [ebp+4]
    mov [ebp+2*4], eax

    postlude
    add esp, 4
    ret

_str:
    prelude

    mov ecx, [ebp+2*4]

    xor edx, edx

    @@:
        cmp [ecx+edx], byte 0
        je @f
        inc edx
        jmp @b
    @@:
    mov eax, 4
    mov ebx, 1
    int 80h

    mov eax, [ebp+4]
    mov [ebp+2*4], eax

    postlude
    add esp, 4
    ret
    
nl:
    push _new_line
    call char
    ret
    
_bin:
    prelude

    mov eax, [ebp+2*4]

    push 2
    mov ebx, 2

    @@:
        cmp eax, 2
        jl @f

        div ebx
        push edx
        xor edx, edx
        jmp @b
    @@:
    push eax
    mov ebx, buffer
    @@:
        pop eax
        cmp al, 2
        je @f

        add al, '0'
        mov [ebx], al
        inc ebx

        jmp @b
    @@:
    push buffer
    call _str

    mov eax, buffer

    @@:
        cmp eax, ebx
        je @f

        mov [ebx-1], byte 0
        dec ebx

        jmp @b
    @@:
    mov eax, [ebp+4]
    mov [ebp+2*4], eax

    postlude
    add esp, 4
    ret

_int:
    prelude
    mov eax, [ebp+2*4]

    push 10
    mov ebx, 10

    @@:
        cmp eax, 10
        jl @f

        div ebx
        push edx
        xor edx, edx
        jmp @b
    @@:
    push eax
    mov ebx, buffer
    @@:
        pop eax
        cmp al, 10
        je @f

        add al, '0'
        mov [ebx], al
        inc ebx

        jmp @b
    @@:
    mov [ebx], byte 0
    push buffer
    call _str

    mov eax, buffer

    @@:
        cmp eax, ebx
        je @f

        mov [ebx-1], byte 0
        dec ebx

        jmp @b
    @@:
    mov eax, [ebp+4]
    mov [ebp+2*4], eax

    postlude
    add esp, 4
    ret


exit:
    mov eax, 1
    xor ebx, ebx
    int 80h