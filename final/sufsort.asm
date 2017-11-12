
%include "asm_io.inc"
global asm_main

section .data
;instruction
ins: db "sorted suffixes:",10,0

; Error 
err1: db "incorrect number of comman line arguments",10,0
err2: db "the length of input string must between 1 and 30",10,0
err3: db "only char 0,1,2 is allowed in input string",10,0 

section .bss

X: resb 30
Y: resb 30
N: resd 1

;temp
i: resd 1
r: resd 1
j: resd 1
o: resd 1
n: resd 1
m: resd 1
section .text

asm_main:
  enter 0, 0
  pusha
  
  mov eax, dword [ebp+8] ;argc
  cmp  eax, dword 2 ;check if argc is 2
  jne ERR1

  ;check the length and char 0,1,2
  mov ebx, dword [ebp+12] ;address of argv[]
  mov ecx, dword [ebx+4] ;agrv[1]
  mov edx, 0 ;char counter
  
  error_loop:
    mov bl, byte [ecx] ;first byte
    cmp bl, byte 0 ;check if reach end of string
    je error_end

    try0: cmp bl, '0'         ;check for 0
    jne try1                  ;if not, check for 1
    jmp continue_error_loop   ;if it is, check next

    try1: cmp bl, '1'
    jne try2
    jmp continue_error_loop

    try2: cmp bl, '2'
    jne ERR3
    
  continue_error_loop:
    add edx, 1 ;char counter+1
    add ecx, 1 ;go to next char
    jmp error_loop    

  error_end:
    cmp edx, 30
    jg ERR2
 
  
  ;part6 - copy into program's memory
  ;terminated with 0
  ;array X, length N
 
  mov [N], dword edx ;length is store in N
  
  mov ecx, X
  mov eax, dword [ebp+12] ;address of argv[]
  mov ebx, dword [eax+4] ;argv[1]
  mov [i], dword 0

  part6loop:
    cmp [i], edx   ;check if reaches end
    jge part6end;  ;if it is, jump
    mov al, byte [ebx]
    mov [ecx], al
    
    ;goto next
    add ecx, dword 1
    add ebx, dword 1
    add [i], dword 1
    jmp part6loop
 
  part6end:
    mov eax, dword 0
    mov [ecx], eax
    mov eax, X
    call print_string
    call print_nl
    
    ;sample call for sufcmp
    ;sufcmp(X,2,1)
    ;result is store in variable [r]

    ;push dword 1
    ;push dword 2
    ;push X
    ;call sufcmp
    ;add esp, 12
    ;mov eax, dword [r]
    ;call print_int

  ;this loop generates array Y
  ;Y contains int 0 .. N-1
  mov ecx, Y         ;ecx = base address of Y 
  mov edx, dword [N] ;edx = # of char in string
  mov [i], dword 0

  y_loop:
    cmp [i], edx    ;check if reaches end
    jge y_end
    mov eax, dword [i]
    mov [ecx], eax
    add ecx, dword 1
    add [i], dword 1
    jmp y_loop

  y_end:
    mov eax, dword [N]
    mov [i], eax        ;i = N, outer loop counter
    mov [j], dword 1    ;inner loop counter
  
  ;now wo are running bubble sort
  ;outer loop generates i from N,...,1
  ;inner loop generates j from 1,...,i-1

  outer_loop:
    cmp [i], dword 0
    jle outer_end
 
    inner_loop:
      mov eax, dword [i]  ;eax = i
      cmp [j], eax
      jge inner_end

      ;r=sufcmp(Z,y[j-1],y[j])
      mov ebx, Y     ;load address of Y
      mov ecx, Y     ;load address of Y
      add ebx, dword [j] ;ebx = adress of Y[j]
      add ecx, dword [j]
      sub ecx, dword 1   ;ecx = adress of Y[j-1]
      mov eax, [ebx]     ;eax = Y[j]
      mov edx, [ecx]     ;edx = Y[j-1]
      push eax
      push edx
      push X
      call sufcmp
      add esp, 12
      mov eax, dword [r]
      cmp eax, dword 0
      jg swap
      swap:
        mov [ebx], edx
        mov [ecx], eax

      ;goto next
      add [j], dword 1

    inner_end:
      sub [i], dword 1
      jmp outer_loop      

  outer_end:
    ;display final result
    mov eax, ins
    call print_string

    mov ecx, Y
    mov edx, dword [N]
    mov [i], dword 0

  dis_loop:
    cmp [i], edx
    jge dis_end
    
    call read_char
    mov eax, X
    call print_string
    call print_nl
    ;goto next
    add ecx, dword 1
    add [i], dword 1
    jmp dis_loop    

  dis_end:
    jmp asm_main_end
  
  ERR1:
    mov eax, err1
    call print_string
    jmp asm_main_end
  
  ERR2:
    mov eax, err2
    call print_string
    jmp asm_main_end

  ERR3:
    mov eax, err3
    call print_string
    jmp asm_main_end  

  asm_main_end:
    popa
    leave
    ret
  
;subroutine sufcmp(Z,i,j)
;three arguments
;address of a string Z, two indeces i and j
sufcmp:
  enter 0,0
  pusha

  mov ecx, dword[ebp+8]   ;ecx = Z
  mov ebx, dword[ebp+12]  ;ebx = i
  mov eax, dword[ebp+16]  ;eax = j
  mov [i], dword ebx      ;save i
  mov [j], dword eax      ;save j
  ;variable N store length(Z)
  
  mov edx, dword [N]
  sub edx, ebx
  mov ebx, edx            ;ebx = len(Z) - i 
  mov [n], ebx            ;store in n

  mov edx, dword [N]
  sub edx, eax
  mov eax, edx            ;eax = len(Z) - j
  mov [m], eax            ;store in m

  cmp eax, ebx
  jge min
  mov edx, eax
  sub edx, dword 1
  mov [o], dword edx
  mov edx, dword 0
  mov eax, edx
  jmp sufcmp_loop

  min: mov edx, ebx
   sub edx, dword 1     ;o = min(eax,ebx)-1
   mov [o], dword edx
   mov edx, dword 0     ;edx - loop counter
   mov eax, edx

  sufcmp_loop:
    mov eax, dword [o]
    cmp edx, eax
    jg all_same

    ;find the char at correspoding position
    mov eax, dword [ebp+8]   ;load address
    mov ebx, dword [ebp+8]   ;load address
    add ebx, edx  
    add ebx, dword [i]    ;ebx = Z[i+o]
    add eax, edx
    add eax, dword [j]    ;eax = Z[j+o]
    mov al, byte [eax]
    cmp al, byte[ebx]
    jl r1
    jg r0
    
    add edx, dword 1   ;adding counter by one
    jmp sufcmp_loop
  
  r0:
    mov [r], dword -1
    jmp sufcmp_end

  r1:
    mov [r], dword 1
    jmp sufcmp_end

  all_same:
    mov eax, dword [n]
    mov ebx, dword [m]
    cmp eax, ebx
    jl r0
    jmp r1
    
  sufcmp_end:
    popa
    leave
    ret
