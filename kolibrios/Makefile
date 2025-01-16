# Makefile for building the example program

# Program name
PROGRAM = main

# Compiler and assembler settings
ASM_COMPILER_FLAGS = -g -f elf32 -F dwarf
GCC_COMPILER_FLAGS = -Wall -Wextra -g -c -m32 -ffunction-sections -fdata-sections
LDFLAGS = -n -T include/static.lds -m elf_i386 --no-ld-generated-unwind-info -z noexecstack -z relro -z now --gc-sections --entry=main

# Tools
GCC = gcc
NASM = nasm $(ASM_COMPILER_FLAGS)
OBJCOPY = objcopy

# Object files
OBJS = include/syscalls.o $(PROGRAM).gcc.o

# Phony targets
.PHONY: all clean link

# Default target
all: $(OBJS) link

# Clean target
clean:
	rm -f $(OBJS) $(PROGRAM).kex

# Link target
link:
	ld $(LDFLAGS) -o $(PROGRAM).kex $(OBJS)
	strip $(PROGRAM).kex
	$(OBJCOPY) $(PROGRAM).kex -O binary

# Rules for compiling .c and .asm files
%.gcc.o: %.c
	$(GCC) $(GCC_COMPILER_FLAGS) $< -o $@

%.o: %.asm
	$(NASM) $< -o $@
