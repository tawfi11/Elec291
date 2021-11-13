SHELL=cmd
CC=c51
COMPORT = $(shell type COMPORT.inc)
OBJS=Oscilloscope.obj

Oscilloscope.hex: $(OBJS)
	$(CC) $(OBJS)
	@echo Done!
	
Oscilloscope.obj: Oscilloscope.c
	$(CC) -c Oscilloscope.c

clean:
	@del $(OBJS) *.asm *.lkr *.lst *.map *.hex *.map 2> nul

LoadFlash:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500
	EFM8_prog.exe -ft230 -r Oscilloscope.hex

putty:
	@Taskkill /IM putty.exe /F 2>NUL | wait 500
	cmd /c start c:\PUTTY\putty -serial $(COMPORT) -sercfg 115200,8,n,1,N -v

Dummy: Oscilloscope.hex Oscilloscope.Map
	@echo Nothing to see here!
	
explorer:
	cmd /c start explorer .
		