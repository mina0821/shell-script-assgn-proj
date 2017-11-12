all: argv 

argv: argv.o asm_io.o
	 gcc -m32 -o argv argv.o driver.c asm_io.o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
argv.o: argv.asm
	nasm -f elf32 -o argv.o argv.asm

prog1: prog1.o asm_io.o
	gcc -m32 -o prog1 prog1.o driver.c asm_io.o
prog1.o: prog1.asm
	nasm -f elf32 -o prog1.o prog1.asm

prog2: prog2.o asm_io.o
	gcc -m32 -o prog2 prog2.o driver.c asm_io.o
prog2.o: prog2.asm
	nasm -f elf32 -o prog2.o prog2.asm

prog3: prog3.o asm_io.o
	gcc -m32 -o prog3 prog3.o driver.c asm_io.o
prog3.o: prog3.asm
	nasm -f elf32 -o prog3.o prog3.asm

clean:
	rm *.o argv prog1 prog2 prog3
