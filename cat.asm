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
    mov r13, rax

    FSTAT r13, stat_struct
    mov r12, [stat_struct + ST_SIZE_OFFS]

    MMAP 0, r12, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0
    cmp rax, 0
    jg read_file
    mov r12, mmap_fail_error_msg
    mov r13, mmap_fail_error_msg_len
    jmp exit_error

read_file:
    mov [contents], rax
    READ r13, [contents], r12

    WRITE STDOUT, [contents], r12

    MUNMAP contents, r12

    CLOSE r13

    jmp main_loop

exit_success:
    EXIT EXIT_SUCCESS

exit_error:
    WRITE STDERR, r12, r13
    EXIT EXIT_FAIL

section .data
    file_not_found_error_msg db "ERROR: File not found", 10
    file_not_found_error_msg_len equ $-file_not_found_error_msg

    no_args_error_msg db "ERROR: No arguments were provided", 10
    no_args_error_msg_len equ $-no_args_error_msg

    mmap_fail_error_msg db "ERROR: Could not allocate memory", 10
    mmap_fail_error_msg_len equ $-mmap_fail_error_msg

    newline db 10
    newline_len equ $-newline

section .bss
    contents: resq 1
    stat_struct: resb 144
    input_counter: resb 1

