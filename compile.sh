rm kernel.o
rm kernel.bin

gcc -ffreestanding -fno-asynchronous-unwind-tables -fno-pie -m32 -c kernel.c -o kernel.o
ld -o kernel.bin -m elf_i386 --oformat binary kernel.o
ndisasm -b 32 kernel.bin > kernel.dis