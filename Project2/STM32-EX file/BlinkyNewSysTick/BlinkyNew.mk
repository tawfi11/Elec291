# Since we are compiling in windows, select 'cmd' as the default shell.  This
# is important because make will search the path for a linux/unix like shell
# and if it finds it will use it instead.  This is the case when cygwin is
# installed.  That results in commands like 'del' and echo that don't work.
SHELL=cmd
CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
LD=arm-none-eabi-ld

CCFLAGS=-mcpu=cortex-m0 -mthumb -g 

# Search for the path of the right libraries.  Works only on Windows.
GCCPATH=$(subst \bin\arm-none-eabi-gcc.exe,\,$(shell where $(CC)))
LIBPATH1=$(subst \libgcc.a,,$(shell dir /s /b "$(GCCPATH)*libgcc.a" | find "v6-m"))
LIBPATH2=$(subst \libc_nano.a,,$(shell dir /s /b "$(GCCPATH)*libc_nano.a" | find "v6-m"))
LIBSPEC=-L"$(LIBPATH1)" -L"$(LIBPATH2)"

OBJS=main.o serial.o startup.o newlib_stubs.o

main.elf : $(OBJS)
	$(LD) $(OBJS) $(LIBSPEC) -T stm32f05xxx.ld --cref -Map main.map -nostartfiles -o main.elf
	arm-none-eabi-objcopy -O ihex main.elf main.hex
	@echo Success!

main.o: main.c
	$(CC) -c $(CCFLAGS) main.c -o main.o

serial.o: serial.c
	$(CC) -c $(CCFLAGS) serial.c -o serial.o

startup.o: startup.c stm32f05xxx.h serial.h
	$(CC) -c $(CCFLAGS) startup.c -o startup.o

newlib_stubs.o: newlib_stubs.c
	$(CC) -c $(CCFLAGS) newlib_stubs.c -o newlib_stubs.o

clean: 
	@del $(OBJS) 2>NUL
	@del main.elf main.hex main.map 2>NUL
	@del *.lst 2>NUL
	
Flash_Load:
	STMFlashLoader -ft230 -c -i STM32F0_5x_3x_64K -e --all -d --fn main.hex --v

dummy: stm32f05xxx.ld main.map
	@echo :-)
	
explorer:
	@explorer .
