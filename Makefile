.PHONY: all loader.o kernel.o mono.bin qemu bootloader.vfd clean

all:
	cargo version

alternative: bin/loader.o bin/alternative-kernel.o bin/mono.bin bin/bootloader.vfd

bin/loader.o:
	@mkdir -p bin
	nasm -f elf32 -o bin/loader.o loader.asm

bin/alternative-kernel.o:
	@mkdir -p bin
	gcc -m32 -o bin/kernel.o -c alternative/main.c -nostdlib -nostartfiles -nodefaultlibs

bin/mono.bin:
	@mkdir -p bin
	ld -T linker.ld -m elf_i386 -o bin/mono.bin bin/loader.o bin/kernel.o

bin/bootloader.vfd:
	@mkdir -p bin
	head -c 1474560 /dev/zero > bin/bootloader.vfd
	dd status=noxfer conv=notrunc if=bin/mono.bin of=bin/bootloader.vfd

qemu:
	qemu-system-i386 -kernel bin/mono.bin

clean:
	rm -rf target
	rm -rf bin
