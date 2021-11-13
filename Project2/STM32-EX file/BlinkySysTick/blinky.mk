# Since we are compiling in windows, select 'cmd' as the default shell.  This
# is important because make will search the path for a linux/unix like shell
# and if it finds it will use it instead.  This is the case when cygwin is
# installed.  That results in commands like 'del' and echo that don't work.
SHELL=cmd
# Specify the compiler to use
CC=arm-none-eabi-gcc
# Specify the assembler to use
AS=arm-none-eabi-as
# Specify the linker to use
LD=arm-none-eabi-ld

# Flags for C compilation
CCFLAGS=-mcpu=cortex-m0 -mthumb -g
# Flags for assembly compilation
ASFLAGS=-mcpu=cortex-m0 -mthumb -g
# Flags for linking
LDFLAGS=-T linker_script.ld -cref -nostartfiles

# List the object files used in this project
OBJS= startup.o main.o 

# The default 'target' (output) is main.elf and 'depends' on
# the object files listed in the 'OBJS' assignment above.
# These object files are linked together to create main.elf.
# The linked file is converted to hex using program objcopy.
main.elf: $(OBJS)
	$(LD) $(OBJS) $(LDFLAGS) -Map main.map -o main.elf
	arm-none-eabi-objcopy -O ihex main.elf main.hex
	@echo Success!

# The object file main.o depends on main.c. main.c is compiled
# to create main.o.
main.o: main.c
	$(CC) -c $(CCFLAGS) main.c -o main.o

# The object file startup.o depends on startup.c.  startup.c is
# compiled to create startup.o
startup.o: startup.s
	$(AS) $(ASFLAGS) startup.s -asghl=startup.lst -o startup.o

# Target 'clean' is used to remove all object files and executables
# associated wit this project
clean:
	del $(OBJS) 
	del main.elf main.hex main.map
	del *.lst

# Target 'Flash_Load' is used to load the hex file to the microcontroller 
# using the flash loader.
Flash_Load:
	STMFlashLoader -ft230 -c -i STM32F0_5x_3x_64K -e --all -d --fn main.hex --v

# Phony targets can be added to show useful files in the file list of
# CrossIDE or execute arbitrary programs.
dummy: linker_script.ld main.hex
	@echo :-)
	
explorer:
	@explorer .

