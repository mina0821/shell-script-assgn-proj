%include "asm_io.inc"
global asm_main

section .data
msg2: db '[['

section .bss

section .text

display:
  enter 0,0
  pusha
  
  mov eax, msg2
  call print_string
  call print_nl
  mov al, '+'
  call print_char  

  popa
  leave
  ret


asm_main:
  enter 0, 0
  pusha
  
  mov ebx, dword [ebp+12]  ; address of argv[]

  mov eax, msg2
  call print_string
  mov eax, dword [ebx]     ; get argv[0] argument -- ptr to string
  call print_string        ; display argv[0] arg
  call print_nl

  mov eax, msg2
  call print_string
  mov eax, dword [ebx+4]
  call print_string
  call print_nl

  mov eax, msg2
  call print_string
  mov eax, dword [ebx+8]
  call print_string
  call print_nl

  popa
  leave
  ret
