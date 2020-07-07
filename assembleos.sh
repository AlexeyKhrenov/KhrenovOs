sh run.sh
sh compile.sh
cat boot_sect.bin kernel.bin > os-image.bin
qemu-system-i386 -fda os-image.bin