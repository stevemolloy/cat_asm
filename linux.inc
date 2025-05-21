%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_FSTAT 5
%define SYS_MMAP 9
%define SYS_MUNMAP 11
%define SYS_EXIT 60

%define STDIN 0
%define STDOUT 1
%define STDERR 2

%define PROT_READ     1
%define PROT_WRITE    2
%define MAP_PRIVATE   2
%define MAP_ANONYMOUS 32

%define O_RDONLY 0

%define ST_SIZE_OFFS 48

%define EXIT_SUCCESS 0
%define EXIT_FAIL 1

%macro EXIT 1
    syscall1 SYS_EXIT, %1
%endmacro

%macro CLOSE 1
    syscall1 SYS_CLOSE, %1
%endmacro

%macro WRITE 3
    syscall3 SYS_WRITE, %1, %2, %3
%endmacro

%macro READ 3
    syscall3 SYS_READ, %1, %2, %3
%endmacro

%macro OPEN 3
    syscall3 SYS_OPEN, %1, %2, %3
%endmacro

%macro FSTAT 2
    syscall2 SYS_FSTAT, %1, %2
%endmacro

%macro MMAP 6
    syscall6 SYS_MMAP, %1, %2, %3, %4, %5, %6
%endmacro

%macro MUNMAP 2
    syscall2 SYS_MUNMAP, %1, %2
%endmacro

%macro syscall1 2
    mov rax, %1
    mov rdi, %2
    syscall
%endmacro

%macro syscall2 3
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    syscall
%endmacro

%macro syscall3 4
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    syscall
%endmacro

%macro syscall6 7
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    mov r10, %5
    mov r8,  %6
    mov r9,  %7
    syscall
%endmacro


