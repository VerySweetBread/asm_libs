format ELF
public open     as 'file.open'
public close    as 'file.close'
public content  as 'file.content'

include '../include/_file.inc'
include '../include/_macros.inc'
extrn string.len
extrn string.copy
extrn path.filename


section '.strtab'
str1    db "File object ", 0
; str2    db " at "


section '.bss' writeable
pointer rd 1
fd      rd 1
memory  rd 1
sizes_ sizes
file_stat stat


section '.file.text' executable
open:
    prelude

    ; open
    mov eax, 5
    mov ebx, [ebp+2*4]
    mov ecx, O_RDONLY
    mov edx, O_DIRECTORY
    int 80h

    mov [fd], eax

    ; fstat
    mov eax, 108
    mov ebx, [fd]
    mov ecx, file_stat
    int 80h

    push str1
    call string.len
    pop eax
    mov [sizes_.str1], al

    push dword [ebp+2*4]
    call string.len
    pop eax
    mov [sizes_.full_filename], al

    push dword [ebp+2*4]
    call path.filename
    call string.len
    pop ebx
    mov [sizes_.filename], bl

    mov eax, [file_stat.off_t]
    add al , [sizes_.str1]
    add al , [sizes_.full_filename]
    add al , [sizes_.filename]
    add al , [sizes_.fd]
    add al , [sizes_.all_size]
    mov [memory], eax
    push eax

    ; mmap2
    mov eax, 192
    xor ebx, ebx
    pop ecx
    mov edx, PROT_READ
    or  edx, PROT_WRITE
    mov esi, MAP_PRIVATE
    or  esi, MAP_ANONYMOUS
    mov edi, -1
    push ebp
    xor ebp, ebp
    int 80h
    pop ebp

    mov [pointer], eax

    push str1
    push eax
    call string.copy

    xor ebx, ebx
    mov bl , [sizes_.str1]
    add eax, ebx 
    mov ebx, [ebp+2*4]
    push ebx
    call path.filename
    push eax
    call string.copy

    xor ebx, ebx
    mov bl , [sizes_.filename]
    add eax, ebx
    inc eax
    push dword [ebp+2*4]
    push eax
    call string.copy

    xor ebx, ebx
    mov bl , [sizes_.full_filename]
    add eax, ebx
    inc eax
    mov ebx, [fd]
    mov [eax], ebx

    xor ebx, ebx
    mov bl , [sizes_.fd]
    add eax, ebx
    mov ebx, [memory]
    mov [eax], ebx

    xor ebx, ebx
    mov bl , [sizes_.all_size]
    add eax, ebx
    inc eax
    push eax

    ; read
    mov eax, 3
    mov ebx, [fd]
    pop ecx
    mov edx, [file_stat.off_t]
    int 80h

    mov eax, [pointer]
    mov [ebp+2*4], eax

    postlude  
    ret

close:
    prelude

    mov eax, [ebp+2*4]
    push eax
    call string.len
    pop ebx
    add eax, ebx
    inc eax
    push eax
    call string.len
    pop ebx
    add eax, ebx
    inc eax

    push eax

    ; close
    mov ebx, [eax]
    mov eax, 6
    int 80h

    ; munmap
    mov eax, 91
    mov ebx, [ebp+2*4]
    pop ecx
    add ecx, 4
    mov ecx, [ecx]
    int 80h
    
    mov eax, [ebp+4]
    mov [ebp+2*4], eax

    postlude
    add esp, 4
    ret

content:
    prelude

    mov eax, [ebp+2*4]
    push eax
    call string.len
    pop ebx
    add eax, ebx
    inc eax
    push eax
    call string.len
    pop ebx
    add eax, ebx
    add eax, 1+4+4+1

    mov [ebp+2*4], eax
    postlude
    ret

