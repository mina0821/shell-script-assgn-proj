all: first loop3

loop3: loop3.o asm_io.o
	 gcc -m32 -o loop3 loop3.o driver.c asm_io.o
first: first.o asm_io.o driver.c
	 gcc -m32 -o first driver.c first.o asm_io.o
first.o: first.asm asm_io.inc
	nasm -f elf32 first.asm 
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
loop3.o: loop3.asm
	nasm -f elf32 -o loop3.o loop3.asm
clean:
	rm *.o first loop3
