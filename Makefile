.PHONY: run

cat: cat.o
	ld -g -o cat cat.o

cat.o: cat.asm
	nasm -g -f elf64 cat.asm

run: cat
	./cat

