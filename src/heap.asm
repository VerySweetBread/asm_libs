format ELF
public _add as 'heap.add'
public del  as 'heap.del'

include '../include/macros.inc'
extrn exit

section '.bss' writeable
_heap:
    db 0xB  ; flag
    dd 4    ; size
    dd 4096 ; available memory
    
    rd 4096

section '.text' executable
_add:
    prelude

    mov ecx, [ebp+2*4]  ; size
    mov eax, _heap
    xor edx, edx

    .loop:
        cmp [eax], byte 0
        je .empty

        mov bl, [eax]
        bt  bx, 0
        jc .busy

        inc eax
        cmp edx, 0
        jne @f
            mov edx, eax
        @@:
        cmp ecx, [eax]
        jl .more
        je .equal
        ; less
            sub ecx, [eax]
            add eax, [eax]
            add eax, 4
            jmp .loop
        .equal:
            mov [edx], byte 9
            mov ebx, [ebp+2*4]
            mov [edx+1], ebx
            add edx, 5
            mov [ebp+2*4], edx
            postlude
            ret
        .more:
            mov ebx, edx
            add ebx, [ebp+2*4]
            mov [ebx], byte 9
            inc ebx
            mov eax, [eax]
            sub eax, ecx
            mov [ebx], eax
            
            add ebx, [ebp+2*4]
            mov [edx-1], byte 9
            mov edx, ebx

            add edx, 5
            mov [ebp+2*4], edx
            postlude
            ret
        
        .empty:
            cmp edx, 0
            jne @f
                mov edx, eax
            @@:
            je @f
                dec edx
            @@:
            jmp .equal

        .busy:
        xor edx, edx
        inc eax
        add eax, [eax]
        add eax, 4

        jmp .loop

del:
    push eax
    mov eax, [esp+4*2]
    sub eax, 5
    and byte [eax], 254
    mov eax, [esp+4]
    mov [esp+4*2], eax
    pop eax
    add esp, 4
    ret
