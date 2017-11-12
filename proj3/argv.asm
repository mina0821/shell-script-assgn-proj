%include "asm_io.inc"
global asm_main

section .data
msg1: db 'argc=',0
msg2: db 'argv['

section .bss

section .text

asm_main:
  enter 0, 0
  pusha

  mov eax, msg1
  call print_string
  mov eax, dword [ebp+8]  ; argc
  call print_int          ; display argc
  call print_nl

  mov eax, msg2
  call print_string
  mov eax, dword 0
  call print_int
  mov al,']'
  call print_char
  mov al,'='
  call print_char
  mov ebx, dword [ebp+12]  ; address of argv[]
  mov eax, dword [ebx]     ; get argv[0] argument -- ptr to string
  call print_string        ; display argv[0] arg
  call print_nl
 
  mov eax, msg2
  call print_string
  mov eax, dword 1
  call print_int
  mov al,']'
  call print_char
  mov al,'='
  call print_char
  mov eax, dword [ebx+4]   ; get argv[1] argument -- ptr to string
  call print_string        ; display argv[1] arg
  call print_nl

  mov eax, msg2
  call print_string
  mov eax, dword 2
  call print_int
  mov al,']'
  call print_char
  mov al,'='
  call print_char
  mov eax, dword [ebx+8]   ; get argv[2] argument -- ptr to string
  call print_string        ; display argv[1] arg
  call print_nl

  popa
  leave
  ret
