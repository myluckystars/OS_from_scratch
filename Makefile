# Automatically generate lists of sources using wildcards.
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.c)

# TODO: Make sources dep on all header files.

# Convert the *.c filenames to *.o to give a list of object files to build
OBJ = ${C_SOURCES:.c=.o}

# Default build target
all: os-image

# Run qemu to simulate booting of our code
run: all
	qemu-system-i386 os-image

# This is the actual disk image that the computer loads
# which is the combination of our compiled bootsector and kernel
os-image: boot/boot_sect.bin kernel.bin
	cat $^ > $@

# This builds the binary of our kernel from two object files:
# - the kernel_entry, which jumps to main() in our kernel
# - the compiled C kernel
kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

# Generic rule for compiling C code to an object file.
# For simplicity, the C files depend on all header files.
%.o: %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

# Assemble the kernel_entry
%.o: %.asm
	nasm -f elf $< -o $@

%.bin: %.asm
	nasm -f bin -I 'boot/'  $< -o $@

clean:
	rm -rf *.bin *.dis *.o os-image
	rm -rf boot/*.bin kernel/*.o drivers/*.o


# Disassemble our kernel, might be useful for debugging.
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
