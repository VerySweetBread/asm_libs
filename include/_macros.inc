macro prelude {
    push ebp
    mov ebp, esp
    push eax ebx ecx edx esi edi
}

macro postlude {
    pop edi esi edx ecx ebx eax ebp
}