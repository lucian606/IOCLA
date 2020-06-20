%include "include/io.inc"

extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text
global main

brute_force:    
    mov eax, [esp+4] ;iau pointer [img] de pe stiva
    xor ebx, ebx ;contor de coloane
    xor ecx, ecx ;contor de linii
    xor edx, edx ;cheia
    xor edi, edi ;contor pentru deplasarea in 'revient'
    xor esi, esi ;indexul de deplasare in vector
repeat:
    mov eax, [esp+4]
    mov eax, [eax+4*esi] ;elementul curent
    xor eax, edx ;aplic xorul
    cmp edi, 0 ;verific la a cata litera din revient sunt
    je prima_litera
    cmp edi, 1
    je a_doua_litera
    cmp edi, 2
    je a_treia_litera
    cmp edi, 3
    je a_patra_litera
    cmp edi, 4
    je a_cincea_litera
    cmp edi, 5
    je a_sasea_litera
    cmp edi, 6
    je ultima_litera
prima_litera:
    cmp eax, 'r' ;verific daca e litera buna
    jne resetare_contor
    inc edi
    jmp urmatorul_numar
a_doua_litera:
    cmp eax, 'e' ;verific daca e litera buna
    jne resetare_contor
    inc edi
    jmp urmatorul_numar
a_treia_litera:
    cmp eax, 'v' ;verific daca e litera buna
    jne resetare_contor
    inc edi
    jmp urmatorul_numar
a_patra_litera:
    cmp eax, 'i' ;verific daca e litera buna
    jne resetare_contor
    inc edi
    jmp urmatorul_numar
a_cincea_litera:
    cmp eax, 'e' ;verific daca e litera buna
    jne resetare_contor
    inc edi
    jmp urmatorul_numar
a_sasea_litera:
    cmp eax, 'n' ;verific daca e litera buna
    jne resetare_contor
    inc edi
    jmp urmatorul_numar
ultima_litera:
    cmp eax, 't' ;verific daca e litera buna
    jne resetare_contor
    sub esi, ebx ;reparcurg linia
    xor ebx, ebx ;resetez contorul de linie
    ret
resetare_contor:
    xor edi, edi
urmatorul_numar:
    inc esi ;trec la urmatorul int
    inc ebx ;trec la urmatoarea coloana
    cmp ebx, [esp+12] ;vad daca se termina linia
    jne repeat
    inc ecx ;trec la urmatoarea linie
    xor ebx, ebx ;resetez contorul de coloana
    cmp ecx, [esp+8] ;vad daca se termina matricea
    jne repeat
    inc edx ;cresc cheia
    cmp edx, 256
    je end
    xor ecx, ecx
    xor esi, esi ;reparcurg matricea
    jmp repeat
end:
    leave
    ret
    
inserare_mesaj:    
    xor esi, esi
    mov edi, [esp+12]
    imul edi, [esp+8]
xor_matrice:
    mov eax, [esp+4]
    xor [eax+4*esi], edx ;aflu imaginea originala prin cheie
    inc esi
    cmp esi, edi
    jne xor_matrice
    xor esi, esi
    inc ecx
    mov esi, ecx
    imul esi, [esp+12] ;se introduce mesajul pe linie
    mov dword [eax+4*esi], 'C'
    inc esi
    mov dword [eax+4*esi], "'"
    inc esi
    mov dword [eax+4*esi], 'e'
    inc esi
    mov dword [eax+4*esi], 's'
    inc esi
    mov dword [eax+4*esi], 't'
    inc esi
    mov dword [eax+4*esi], ' '
    inc esi
    mov dword [eax+4*esi], 'u'
    inc esi
    mov dword [eax+4*esi], 'n'
    inc esi
    mov dword [eax+4*esi], ' '
    inc esi
    mov dword [eax+4*esi], 'p'
    inc esi
    mov dword [eax+4*esi], 'r'
    inc esi
    mov dword [eax+4*esi], 'o'
    inc esi
    mov dword [eax+4*esi], 'v'
    inc esi
    mov dword [eax+4*esi], 'e'
    inc esi
    mov dword [eax+4*esi], 'r'
    inc esi
    mov dword [eax+4*esi], 'b'
    inc esi
    mov dword [eax+4*esi], 'e'
    inc esi
    mov dword [eax+4*esi], ' '
    inc esi
    mov dword [eax+4*esi], 'f'
    inc esi
    mov dword [eax+4*esi], 'r'
    inc esi
    mov dword [eax+4*esi], 'a'
    inc esi
    mov dword [eax+4*esi], 'n'
    inc esi
    mov dword [eax+4*esi], 'c'
    inc esi
    mov dword [eax+4*esi], 'a'
    inc esi
    mov dword [eax+4*esi], 'i'
    inc esi
    mov dword [eax+4*esi], 's'
    inc esi
    mov dword [eax+4*esi], '.'
    inc esi
    mov dword [eax+4*esi], 0
    xor esi, esi
    mov eax, edx
    xor edx, edx
    mov ebx, 5
    add eax, eax
    add eax, 3
    div ebx
    sub eax, 4
    mov edx, eax ;se calculeaza noua cheie
    xor ebx, ebx
recriptare:
    mov eax, [esp+4]
    xor [eax+4*esi], edx ;xorez imaginea cu noua cheie
    inc esi
    cmp esi, edi ;verific daca se termina matricea
    jne recriptare
    mov ebx, [esp+8] ;inaltimea
    mov ecx, [esp+12] ;latimea
    push ebx
    push ecx
    push eax
    call print_image
    add esp, 12
    leave
    ret    

criptare_morse:
    mov eax, [esp+4]  ;mesajul
    mov ebx, [esp+16] ;sirul
    mov ecx, [esp+20] ;indicele
morse:
    cmp byte [ebx], 'A'
    je litera_A
    cmp byte [ebx], 'B'
    je litera_B
    cmp byte [ebx], 'C'
    je litera_C
    cmp byte [ebx], 'D'
    je litera_D
    cmp byte [ebx], 'E'
    je litera_E
    cmp byte [ebx], 'F'
    je litera_F
    cmp byte [ebx], 'G'
    je litera_G
    cmp byte [ebx], 'H'
    je litera_H
    cmp byte [ebx], 'I'
    je litera_I
    cmp byte [ebx], 'J'
    je litera_J
    cmp byte [ebx], 'K'
    je litera_K
    cmp byte [ebx], 'L'
    je litera_L
    cmp byte [ebx], 'M'
    je litera_M
    cmp byte [ebx], 'N'
    je litera_N
    cmp byte [ebx], 'O'
    je litera_O
    cmp byte [ebx], 'P'
    je litera_P
    cmp byte [ebx], 'Q'
    je litera_Q
    cmp byte [ebx], 'R'
    je litera_R
    cmp byte [ebx], 'S'
    je litera_S
    cmp byte [ebx], 'T'
    je litera_T
    cmp byte [ebx], 'U'
    je litera_U
    cmp byte [ebx], 'V'
    je litera_V
    cmp byte [ebx], 'W'
    je litera_W
    cmp byte [ebx], 'X'
    je litera_X
    cmp byte [ebx], 'Y'
    je litera_Y
    cmp byte [ebx], 'Z'
    je litera_Z
    cmp byte [ebx], ' '
    je spatiu
    cmp byte [ebx], ','
    je virgula
    cmp byte [ebx], '0'
    je cifra_0
    cmp byte [ebx], '1'
    je cifra_1
    cmp byte [ebx], '2'
    je cifra_2
    cmp byte [ebx], '3'
    je cifra_3
    cmp byte [ebx], '4'
    je cifra_4
    cmp byte [ebx], '5'
    je cifra_5
    cmp byte [ebx], '6'
    je cifra_6
    cmp byte [ebx], '7'
    je cifra_7
    cmp byte [ebx], '8'
    je cifra_8
    cmp byte [ebx], '9'
    je cifra_9
litera_A:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_B:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_C:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_D:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_E:
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx  
    jmp morse
litera_F:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_G:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_H:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse        
litera_I:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_J:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_K:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_L:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_M:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_N:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_O:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_P:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_Q:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse       
litera_R:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_S:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_T:
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_U:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_V:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_W:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_X:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_Y:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
litera_Z:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
spatiu:
    mov dword [eax+4*ecx], '|'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
virgula:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_0:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse        
cifra_1:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_2:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_3:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_4:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_5:
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_6:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_7:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_8:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse
cifra_9:
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '-'
    inc ecx
    mov dword [eax+4*ecx], '.'
    inc ecx
    inc ebx
    cmp byte [ebx], 0
    je stop
    mov dword [eax+4*ecx], ' '
    inc ecx
    jmp morse                                
stop:
    mov dword [eax+4*ecx], 0 ;se pune terminator de sir
    mov ebx, [esp+8] ;inaltimea
    mov ecx, [esp+12] ;latimea
    push ebx
    push ecx
    push eax
    call print_image
    add esp, 12
    leave
    ret
    
    
codificare_lsb:
    mov ecx, [esp+20] ;indicele de la care incep codificarea
    mov eax, [esp+4] ;imaginea
    mov edi, [esp+16] ;mesajul
    xor edx, edx ;stochez bitii caracterului curent
    xor ebx, ebx ;masca
    mov esi, 7 ;numarul de biti ramasi din caracter
itereaza_sirul:
    mov dl, byte [edi] ;caracterul curent
    mov bl, 1 ;initializez masca
    push esi
creare_masca:
    shl bl, 1 ;se fac shiftari pana 1 ajunge pe pozitia esi
    dec esi
    cmp esi, 0
    jne creare_masca
    pop esi
    dec esi
    and dl, bl ;aflu cat era bitul pe pozitia respectiva
    shr dword [eax+4*ecx], 1
    shl dword [eax+4*ecx], 1
    cmp dl, 0 ;se seteasa bitul ca lsb al elementului
    je lsb_null
    inc dword [eax+4*ecx]
lsb_null:
    inc ecx ;trec la urmatorul numar
    cmp esi, 0 ;daca am ajuns la ultimul bit din char
    jne itereaza_sirul
    shr dword [eax+4*ecx], 1
    shl dword [eax+4*ecx], 1
    mov dl, byte [edi]
    mov bl, 1
    and bl, dl
    cmp bl, 0
    je nu_adaug
    inc dword [eax+4*ecx]
nu_adaug:
    inc ecx ;trec la urmatoru element din vector
    inc edi ;trec la urmatorul char
    mov esi, 7
    cmp byte [edi], 0
    jne itereaza_sirul
    inc esi
ultimul_byte:
    shr dword [eax+4*ecx], 1
    shl dword [eax+4*ecx], 1
    inc ecx
    dec esi
    cmp esi, 0
    jne ultimul_byte
    mov ebx, [esp+8]
    mov ecx, [esp+12]
    push ebx
    push ecx
    push eax
    call print_image
    add esp, 12
    leave
    ret    
   
decriptare_lsb:
    mov eax, [esp+4] ;imaginea
    mov ecx, [esp+8] ;indexul
    xor ebx, ebx ;stochez caracterul curent
    xor edi, edi
    mov edx, 8 ;contor
extrage_lsb:
    mov edi, [eax+4*ecx] ;iau elementul curent
    shl ebx, 1
    and edi, 1 ;aflu lsb
    cmp edi, 0
    je lsb_e_zero ;se adauga bitul la caracter
    inc ebx
lsb_e_zero:
    inc ecx
    dec edx
    cmp edx, 0 
    jne extrage_lsb
    mov edx, 8
    cmp ebx, 0
    je final_sir
    PRINT_CHAR ebx ;am aflat caracterul
    xor ebx, ebx ;se creaza un caracter nou
    jmp extrage_lsb
final_sir:        
    leave
    ret

blur:    
    xor esi, esi ;parcurgere vector
    xor edi, edi ;folosit la impartire
    xor edx, edx ;suma vecinilor
    xor ebx, ebx ;contor coloana
    xor ecx, ecx ;contor linie
    xor eax, eax ;imaginea
    mov eax, [esp+4]
check_blur:
    cmp ecx, 0
    je pixel_neblurat ;verific daca sunt pe margini
    cmp ebx, 0
    je pixel_neblurat
    mov edx, [esp+8]
    dec edx
    cmp ecx, edx
    je pixel_neblurat
    mov edx, [esp+12]
    dec edx
    cmp ebx, edx
    je pixel_neblurat
    mov eax, [img]
    push esi
    imul esi, 4  
    sub esi, 4 ;vecin stanga
    mov edx, [eax+esi]
    add esi, 8
    add edx, [eax+esi] ;vecin dreapta
    pop esi
    push esi ;[esp+16] acceseaza latimea din cauza acestui push
    sub esi, [esp+16] ;vecin sus
    add edx, [eax+4*esi]
    add esi, [esp+16]
    add esi, [esp+16] ;vecin jos
    add edx, [eax+4*esi]
    pop esi
    mov eax, [eax+4*esi]
    add eax, edx
    xor edx, edx
    mov edi, 5
    div edi
    PRINT_UDEC 4, eax ;se afiseaza noua valoare
    PRINT_STRING " "
    jmp next_pixel
pixel_neblurat:
    mov eax, [img]
    mov eax, [eax+4*esi]
    PRINT_UDEC 4, eax
    PRINT_STRING " "
next_pixel:
    inc ebx ;cresc coloana
    inc esi ;trec la urmatorul int
    cmp ebx, [esp+12] ;vad daca se opreste linia
    jne check_blur
    NEWLINE
    xor ebx, ebx ;trec la o linie noua
    inc ecx ;trec la urmatoarea line
    cmp ecx, [esp+8] ;vad daca se termina matricea
    jne check_blur
    leave
    ret

main:
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:
    push dword [img_width]
    push dword [img_height]
    push dword [img]
    call brute_force
    add esp, 12 ;eliberez stiva de parametri
afisare_mesaj:    
    mov eax, [img]
    mov eax, [eax+4*esi]
    xor eax, edx ;aplic cheia
    cmp eax, 0
    je opreste_afisare
    PRINT_CHAR eax ;afisez mesajul
    inc ebx
    inc esi
    cmp ebx, [img_width]
    jne afisare_mesaj
opreste_afisare:
    NEWLINE
    PRINT_UDEC 4, edx ;afisez cheia
    NEWLINE
    PRINT_UDEC 4, ecx ;afisez linia
    jmp done
    
solve_task2:
    push dword [img_width]
    push dword [img_height]
    push dword [img]
    call brute_force
    add esp, 12
    push dword [img_width]
    push dword [img_height]
    push dword [img]
    call inserare_mesaj
    add esp, 12
    jmp done
    
solve_task3:
    mov eax, [ebp+12] ;vectorul de argumente
    mov ebx, [eax+12] ;mesajul
    mov edx, [eax+16] ;indicele octetului
    push edx
    call atoi
    add esp, 4
    push eax
    push ebx
    push dword [img_width]
    push dword [img_height]
    push dword [img]
    call criptare_morse
    add esp, 20
    jmp done
    
solve_task4:
    mov eax, [ebp+12] ;vectorul de argumente
    mov edi, [eax+12] ;mesajul
    mov ecx, [eax+16] ;indicele octetului
    push ecx
    call atoi
    add esp, 4
    dec eax
    push eax
    push edi
    push dword [img_width]
    push dword [img_height]
    push dword [img]
    call codificare_lsb
    add esp, 20
    jmp done
    
solve_task5:
    mov eax, [ebp+12] ;vectorul de argumente
    mov edi, [eax+12] ;indicele
    push edi
    call atoi
    add esp, 4
    dec eax 
    push eax
    push dword [img]
    call decriptare_lsb
    add esp, 8
    jmp done
    
solve_task6:
    push dword [img_width]
    push dword [img_height]
    call print_image ;afisez header-ul imaginii
    add esp, 8
    push dword [img_width]
    push dword [img_height]
    push dword [img]
    call blur
    add esp, 12
    jmp done

    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret
    
