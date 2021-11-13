//  square.c: Uses timer 2 interrupt to generate a square wave in pin
//  P2.0 and a 75% duty cycle wave in pin P2.1
//  Copyright (c) 2010-2018 Jesus Calvino-Fraga
//  ~C51~

#include <stdio.h>
#include <stdlib.h>
#include <EFM8LB1.h>

// ~C51~  

#define SYSCLK 72000000L
#define BAUDRATE 115200L

#define OUT0 P1_5
#define OUT1 P1_6
#define VDD 3.3035 // The measured value of VDD in volts


volatile unsigned char pwm_count=0;
volatile int in1, in2;

char _c51_external_startup (void)
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
  
	VDM0CN=0x80;       // enable VDD monitor
	RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD

	#if (SYSCLK == 48000000L)	
		SFRPAGE = 0x10;
		PFE0CN  = 0x10; // SYSCLK < 50 MHz.
		SFRPAGE = 0x00;
	#elif (SYSCLK == 72000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x20; // SYSCLK < 75 MHz.
		SFRPAGE = 0x00;
	#endif
	
	#if (SYSCLK == 12250000L)
		CLKSEL = 0x10;
		CLKSEL = 0x10;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 24500000L)
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 48000000L)	
		// Before setting clock to 48 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x07;
		CLKSEL = 0x07;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 72000000L)
		// Before setting clock to 72 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x03;
		CLKSEL = 0x03;
		while ((CLKSEL & 0x80) == 0);
	#else
		#error SYSCLK must be either 12250000L, 24500000L, 48000000L, or 72000000L
	#endif
	
	P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	XBR1     = 0X00;
	XBR2     = 0x40; // Enable crossbar and weak pull-ups

	// Configure Uart 0
	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	SCON0 = 0x10;
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready

	// Initialize timer 2 for periodic interrupts
	TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	CKCON0|=0b_0001_0000; // Timer 2 uses the system clock
	TMR2RL=(0x10000L-(SYSCLK/10000L)); // Initialize reload value
	TMR2=0xffff;   // Set to reload immediately
	ET2=1;         // Enable Timer2 interrupts
	TR2=1;         // Start Timer2 (TMR2CN is bit addressable)

	EA=1; // Enable interrupts

  	
	return 0;
}

int getsn(char* buff, int len)
{
	int j;
	char c;

	for (j = 0; j < (len - 1); j++)
	{
		c = getchar();
		if ((c == '\n') || (c == '\r'))
		{
			buff[j] = 0;
			return j;
		}
		else
		{
			buff[j] = c;
		}
	}
	buff[j] = 0;
	return len;
}
void InitPinADC (unsigned char portno, unsigned char pinno)
 {
	unsigned char mask;
	
	mask=1<<pinno;

 	SFRPAGE = 0x20;
 	switch (portno)
 	{
 		case 0:
 			P0MDIN &= (~mask); // Set pin as analog input
 			P0SKIP |= mask; // Skip Crossbar decoding for this pin
 			break;
 			case 1:
 			P1MDIN &= (~mask); // Set pin as analog input
 			P1SKIP |= mask; // Skip Crossbar decoding for this pin
 			break;
 			case 2:
 			P2MDIN &= (~mask); // Set pin as analog input
 			P2SKIP |= mask; // Skip Crossbar decoding for this pin
 			break;
 			default:
 			break;
 		}
 		SFRPAGE = 0x00;
 	}

 unsigned int ADC_at_Pin(unsigned char pin)
 	{
 	ADC0MX = pin;   // Select input from pin
 	ADBUSY=1;       // Dummy conversion first to select new pin
 	while (ADBUSY); // Wait for dummy conversion to finish
 	ADBUSY = 1;     // Convert voltage at the pin
 	while (ADBUSY); // Wait for conversion to complete
 	return (ADC0);
 }

 float Volts_at_Pin(unsigned char pin)
 {
 	return ((ADC_at_Pin(pin)*VDD)/0b_0011_1111_1111_1111);
 }
void Timer2_ISR (void) interrupt 5
{
	TF2H = 0; // Clear Timer2 interrupt flag
	
	pwm_count++;
	if(pwm_count>100) pwm_count=0;
	
	OUT0=pwm_count>in1?0:1;
	OUT1=pwm_count>in2?0:1;
}

void main (void)
{
	char buffer[17];
	int len = 17;
	in1, in2 = 0;
	InitPinADC(1, 0); // Configure P2.5 as analog input
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	printf("Square wave generator for the EFM8LB1.\r\n"
	       "Check pins P2.0 and P2.1 with the oscilloscope.\r\n");

	while(1)
	{
		getsn(buffer, len);
		sscanf(buffer,"%d %d", &in1, &in2);
		printf("%f\n", Volts_at_Pin(QFP32_MUX_P1_0));

	}
}
