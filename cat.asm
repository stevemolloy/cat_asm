%include "linux.inc"

strlen:
    xor rax, rax
loop:
    cmp BYTE [rdi], 0
    je done
    inc rdi
    inc rax
    jmp loop
done:
    ret

section .text
    global _start

_start:
    ; int3
    pop rbx
    mov [input_counter], rbx
    pop rsi
    dec byte [input_counter]
    cmp byte [input_counter], 0
    jnz open_file

    mov r12, no_args_error_msg
    mov r13, no_args_error_msg_len
    jmp exit_error

main_loop:
    dec byte [input_counter]
    pop rsi
    cmp byte [input_counter], 0
    jz exit_success

open_file:
    OPEN [rsp], O_RDONLY, 0
    cmp rax, 0
    jg fstat_file
    mov r12, file_not_found_error_msg
    mov r13, file_not_found_error_msg_len
    jmp exit_error

fstat_file:
    mov [fd], rax

    FSTAT [fd], stat_struct
    mov r12, [stat_struct + ST_SIZE_OFFS]

    MMAP 0, r12, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0
    mov [contents], rax

    READ [fd], [contents], r12

    WRITE STDOUT, [contents], r12

    CLOSE [fd]

    jmp main_loop

exit_success:
    EXIT EXIT_SUCCESS

exit_error:
    WRITE STDERR, r12, r13
    EXIT EXIT_FAIL

section .data
    filename db "./cat.asm", 0

    file_not_found_error_msg db "ERROR: File not found", 10
    file_not_found_error_msg_len equ $-file_not_found_error_msg

    no_args_error_msg db "ERROR: No arguments were provided", 10
    no_args_error_msg_len equ $-no_args_error_msg

    newline db 10
    newline_len equ $-newline

section .bss
    fd: resq 1
    contents: resq 1
    stat_struct: resb 144
    input_counter: resb 1

