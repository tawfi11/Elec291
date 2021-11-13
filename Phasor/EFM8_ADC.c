// ADC.c:  Shows how to use the 14-bit ADC.  This program
// measures the voltage from some pins of the EFM8LB1 using the ADC.
//
// (c) 2008-2018, Jesus Calvino-Fraga
//

#include <stdio.h>
#include <stdlib.h>
#include <EFM8LB1.h>
#include <math.h>

// ~C51~  

#define SYSCLK 72000000L
#define BAUDRATE 115200L

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
  	
	return 0;
}

void InitADC (void)
{
	SFRPAGE = 0x00;
	ADC0CN1 = 0b_10_000_000; //14-bit,  Right justified no shifting applied, perform and Accumulate 1 conversion.
	ADC0CF0 = 0b_11111_0_00; // SYSCLK/32
	ADC0CF1 = 0b_0_0_011110; // Same as default for now
	ADC0CN0 = 0b_0_0_0_0_0_00_0; // Same as default for now
	ADC0CF2 = 0b_0_01_11111 ; // GND pin, Vref=VDD
	ADC0CN2 = 0b_0_000_0000;  // Same as default for now. ADC0 conversion initiated on write of 1 to ADBUSY.
	ADEN=1; // Enable ADC
}

// Uses Timer3 to delay <us> micro-seconds. 
void Timer3us(unsigned char us)
{
	unsigned char i;               // usec counter
	
	// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0:
	CKCON0|=0b_0100_0000;
	
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	
	TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	for (i = 0; i < us; i++)       // Count <us> overflows
	{
		while (!(TMR3CN0 & 0x80));  // Wait for overflow
		TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
}

void waitms (unsigned int ms)
{
	unsigned int j;
	unsigned char k;
	for(j=0; j<ms; j++)
		for (k=0; k<4; k++) Timer3us(250);
}

#define VDD 3.3035 // The measured value of VDD in volts

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

void TIMER0_Init(void)
{
	TMOD &= 0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	TMOD |= 0b_0000_0001; // Timer/Counter 0 used as a 16-bit timer
	TR0 = 0; // Stop Timer/Counter 0
	//printf("TMOD = %d\n", TMOD);
}
void sendPython(void) {
	waitms(500); // Give PuTTy a chance to start before sending
	InitPinADC(1, 4); // Configure P2.2 as analog input
	InitPinADC(1, 5); // Configure P2.3 as analog input
	InitPinADC(1, 6); // Configure P2.4 as analog input
	InitPinADC(1, 7); // Configure P2.5 as analog input
	InitADC();
	while (1) {
		printf("%f\n", Volts_at_Pin(QFP32_MUX_P1_5));
	}
}
void main (void)
{
	float periodtest;
	int overflow_count = 0;
	float peak;
	float phasetime;
	float phase;
	float index;
	
	//sendPython();

	TIMER0_Init();

    waitms(500); // Give PuTTy a chance to start before sending
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	
	printf ("ADC test program\n"
	        "File: %s\n"
	        "Compiled: %s, %s\n\n",
	        __FILE__, __DATE__, __TIME__);
	
	InitPinADC(1, 4); // Configure P2.2 as analog input
	InitPinADC(1, 5); // Configure P2.3 as analog input
	InitPinADC(1, 6); // Configure P2.4 as analog input
	InitPinADC(1, 7); // Configure P2.5 as analog input
	//InitPinADC(1,1);
	InitADC();
	printf("Timer initialization done. TMOD = %d, TR0 = %d\n", TMOD, TR0);
	//printf("P1MDIN = %d, P1MDOUT = %d\n", P1MDIN, P1MDOUT);

	//while (1) {
	/*while (1)
	{
		// Read 14-bit value from the pins configured as analog inputs
		v[0] = Volts_at_Pin(QFP32_MUX_P1_4);
		v[1] = Volts_at_Pin(QFP32_MUX_P1_5);
		v[2] = Volts_at_Pin(QFP32_MUX_P1_6);
		v[3] = Volts_at_Pin(QFP32_MUX_P1_7);
		printf("V@P1.4=%7.5fV, V@P1.5=%7.5fV, V@P1.6=%7.5fV, V@P1.7=%7.5fV\r", v[0], v[1], v[2], v[3]);
		waitms(500);
	}*/
		TH0 = 0;
		TL0 = 0;
		TF0 = 0;
		overflow_count = 0;

		while (P1_1 == 1);
		while (P1_1 == 0);
		TR0 = 1;
		while (P1_1 == 1) {
			if (TF0 == 1) {
				TF0 = 0;
				overflow_count++;
			}
		}
		while (P1_1 == 0) {
			if (TF0 == 1) {
				TF0 = 0;
				overflow_count++;
			}
		}
		TR0 = 0;
		periodtest = (overflow_count * 65536.0 + TH0 * 256.0 + TL0) * (12.0 / SYSCLK);
		printf("T= %fms, TH0 = %d, TL0 = %d, overflow_count = %d\n", periodtest * 1000, TH0, TL0, overflow_count);
		
		TH0 = 0;
		TL0 = 0;
		TF0 = 0;
		overflow_count = 0;
		
		printf("Measuring peak");
		while (P1_1 == 1);
		while (P1_1 == 0);
		peak = 0;
		for (index = 0.000; index < periodtest * 1000; index = index + 0.01) {
			if (peak < Volts_at_Pin(QFP32_MUX_P1_5)) {
				peak = Volts_at_Pin(QFP32_MUX_P1_5);
			}
		}
		printf("peak is = %7.5f\n", peak);
		
		printf("peak voltage (RMS) = %7.5f\n", peak*0.707);
		printf("Measuring phase difference\n");
		TH0 = 0;
		TL0 = 0;
		TF0 = 0;
		overflow_count = 0;
		while (P1_0 == 1);
		while (P1_0 == 0);
		TR0 = 1;
		while (P1_1 == 1) {
			if (TF0 == 1) {
				TF0 = 0;
				overflow_count++;
			}
		}
		while (P1_1 == 0) {
			if (TF0 == 1) {
				TF0 = 0;
				overflow_count++;
			}
		}
		TR0 = 0;
		phasetime = (overflow_count * 65536.0 + TH0 * 256.0 + TL0) * (12.0 / SYSCLK);
		phase = phasetime * 360 / periodtest - 5;
		printf("Phase is = %f\n", phase);
		while (1) {
			printf("%f\n", Volts_at_Pin(QFP32_MUX_P1_5));
		}
}	
