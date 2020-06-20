%include "includes/io.inc"

extern getAST
extern freeAST

section .bss
    ; La aceasta adresa, scheletul stocheaza radacina arborelui
    root: resd 1
section .data
    expresie times 400 dd 0 ;aici se retine expresia
section .text
global main

PREORDER:
    cmp ebx, 0
    je STOP ;se opreste apelul la pointer NULL
    mov edx, [ebx]
    cmp byte [edx], '+' ;verific daca stringul e operator
    je OPERATOR
    cmp byte [edx], '*'
    je OPERATOR
    cmp byte [edx], '/'
    je OPERATOR
    cmp byte [edx], '-'
    je MINUS
    jmp ATOI    ;daca e numar se face convertirea
MINUS:
    cmp byte [edx+1], '0'
    jl OPERATOR
    cmp byte [edx+1], '9'
    jg OPERATOR ;se verifica daca '-' e operator sau nu
ATOI:
    PUSH ecx    ;salvez numarul de elemente din vector
    XOR eax, eax    ;in eax se stocheaza numarul
    XOR ecx, ecx    ;in ecx se stocheaza cifra curente
    XOR esi, esi    ;daca e 1 inseamna ca numarul e negativ
    cmp byte [edx], '-'
    jne CURRENT_CHAR
    mov esi, 1
    inc edx
CURRENT_CHAR:
    cmp byte [edx], 0
    je CHECK_IF_NEGATIVE
    mov cl, BYTE[edx]
    sub cl, '0' ;se obtine cifra curenta
    imul eax, 10
    add eax, ecx    ;nr=nr*10+cifra_curenta
    inc edx
    jmp CURRENT_CHAR
CHECK_IF_NEGATIVE:
    cmp esi,1   ;daca numarul incepe cu '-' acesta se neaga
    jne END_NUMBER
    neg eax
END_NUMBER:
    mov ecx, eax
    pop ecx
    mov [expresie+ecx*4], eax ;se adauga rezultatul in vector
    inc ecx ;creste numarul de elemente ale vectorului
    jmp STOP
OPERATOR:
    push edx
    mov edx, [edx]
    mov [expresie+ecx*4], edx
    pop edx
    inc ecx
    push ebx    ;se salveaza nodul pentru urmatorul apel
    mov ebx, [ebx+4]    ;apel recursiv pe stanga
    call PREORDER
    pop ebx
    mov ebx, [ebx+8]    ;apel recursiv pe dreapta
    call PREORDER
STOP:
    ret

main:
    mov ebp, esp; for correct debugging
    ; NU MODIFICATI
    push ebp
    mov ebp, esp
    
    ; Se citeste arborele si se scrie la adresa indicata mai sus
    call getAST
    mov [root], eax
    ; Implementati rezolvarea aici:
    mov ebx, [root]
    xor ecx, ecx    ;in ecx se stocheaza numarul de elemente
    call PREORDER
EVALUATE:
    dec ecx
    mov ebx, [expresie+4*ecx]   ;se pune in ebx elementul
    cmp ebx, '+'
    je ADDITION
    cmp ebx, '-'
    je SUBTRACT
    cmp ebx, '*'
    je MULTIPLY
    cmp ebx, '/'
    je DIVIDE
    jmp NUMBER
ADDITION:
    pop eax
    pop edx
    add eax, edx
    push eax
    jmp CHECK_END
SUBTRACT:
    pop eax
    pop edx
    sub eax, edx
    push eax
    jmp CHECK_END
MULTIPLY:
    pop eax
    pop edx
    imul eax, edx
    push eax
    jmp CHECK_END
DIVIDE:
    pop eax
    pop edi
    xor edx, edx
    cdq ;extensie de semn
    idiv edi
    push eax
    jmp CHECK_END
NUMBER:
    push ebx    ;daca e numar, se pune pe stiva
CHECK_END:
    cmp ecx, 1
    jl END
    jmp EVALUATE
END:
    ; NU MODIFICATI
    ; Se elibereaza memoria alocata pentru arbore
    pop eax ;rezultatul a ramas pe stiva
    PRINT_DEC 4, eax
    push dword [root]
    call freeAST
    xor eax, eax
    leave
    ret