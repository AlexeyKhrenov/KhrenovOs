rm kernel.o
rm kernel.bin
rm idt_routine.o

nasm kernel_entry.asm -f elf32 -o kernel_entry.o
nasm DescriptorTables/idt_routine.asm -f elf32 -o idt_routine.o

gcc -ffreestanding -fno-asynchronous-unwind-tables -fno-pie -m32 -c kernel.c -o kernel.o
ld -o kernel.bin -m elf_i386 -Ttext 0x1000 --oformat binary kernel_entry.o idt_routine.o kernel.o 
ndisasm -b 32 kernel.bin > kernel.dis