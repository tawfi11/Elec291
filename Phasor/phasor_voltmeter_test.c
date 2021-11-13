
#include <EFM8LB1.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define SYSCLK      72000000L  // SYSCLK frequency in Hz
#define BAUDRATE      115200L  // Baud rate of UART in bps

#define LCD_RS P2_6
// #define LCD_RW Px_x // Not used in this code.  Connect to GND
#define LCD_E  P2_5
#define LCD_D4 P2_4
#define LCD_D5 P2_3
#define LCD_D6 P2_2
#define LCD_D7 P2_1
#define CHARS_PER_LINE 16

#define VDD 3.3035 // The measured value of VDD in volts

unsigned char overflow_count;


char _c51_external_startup (void)
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
  
	VDM0CN |= 0x80;
	RSTSRC = 0x02;

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
	XBR1     = 0X10; // Enable T0 on P0.0
	XBR2     = 0x40; // Enable crossbar and weak pull-ups

	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	// Configure Uart 0
	SCON0 = 0x10;
	CKCON0 |= 0b_0000_0000 ; // Timer 1 uses the system clock divided by 12.
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
		if (TF0)
		{
		   TF0=0;
		   overflow_count++;
		}
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
}

void waitms (unsigned int ms)
{
	unsigned int j;
	for(j=ms; j!=0; j--)
	{
		Timer3us(249);
		Timer3us(249);
		Timer3us(249);
		Timer3us(250);
	}
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


void LCD_pulse (void)
{
	LCD_E=1;
	Timer3us(40);
	LCD_E=0;
}

void LCD_byte (unsigned char x)
{
	// The accumulator in the C8051Fxxx is bit addressable!
	ACC=x; //Send high nible
	LCD_D7=ACC_7;
	LCD_D6=ACC_6;
	LCD_D5=ACC_5;
	LCD_D4=ACC_4;
	LCD_pulse();
	Timer3us(40);
	ACC=x; //Send low nible
	LCD_D7=ACC_3;
	LCD_D6=ACC_2;
	LCD_D5=ACC_1;
	LCD_D4=ACC_0;
	LCD_pulse();
}

void WriteData (unsigned char x)
{
	LCD_RS=1;
	LCD_byte(x);
	waitms(2);
}

void WriteCommand (unsigned char x)
{
	LCD_RS=0;
	LCD_byte(x);
	waitms(5);
}

void LCD_4BIT (void)
{
	LCD_E=0; // Resting state of LCD's enable is zero
	// LCD_RW=0; // We are only writing to the LCD in this program
	waitms(20);
	// First make sure the LCD is in 8-bit mode and then change to 4-bit mode
	WriteCommand(0x33);
	WriteCommand(0x33);
	WriteCommand(0x32); // Change to 4-bit mode

	// Configure the LCD
	WriteCommand(0x28);
	WriteCommand(0x0c);
	WriteCommand(0x01); // Clear screen command (takes some time)
	waitms(20); // Wait for clear screen command to finsih.
}

void LCDprint(char * string, unsigned char line, bit clear)
{
	int j;

	WriteCommand(line==2?0xc0:0x80);
	waitms(5);
	for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
}

int getsn (char * buff, int len)
{
	int j;
	char c;
	
	for(j=0; j<(len-1); j++)
	{
		c=getchar();
		if ( (c=='\n') || (c=='\r') )
		{
			buff[j]=0;
			return j;
		}
		else
		{
			buff[j]=c;
		}
	}
	buff[j]=0;
	return len;
}

void TIMER0_Init(void)
{
	TMOD&=0b_1111_0000; // Set the bits of Timer/Counter 0 to zero
	TMOD|=0b_0000_0101; // Timer/Counter 0 used as a 16-bit counter
	TR0=0; // Stop Timer/Counter 0
}

void main (void) 
{

	float period=0;
	unsigned long freq;
	float half_period;
	float peak_time;

	// float ref_peak = 0;
	// float ref_peakRMS = 0;

	// float test_peak = 0;
	// float test_peakRMS;

	// float pulse_width;
	// float phase_diff;
	// float ref_peakRMS;
	// float test_peakRMS;

	//float v[4];


	// char buff[17];

	//TIMER0_Init();


	waitms(500); // Give PuTTY a chance to start.
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.

	// InitPinADC(1, 4); // Configure P2.2 as analog input
	// InitPinADC(1, 5); // Configure P2.3 as analog input
	// InitPinADC(1, 6); // Configure P2.4 as analog input
	// InitPinADC(1, 7); // Configure P2.5 as analog input
 //    InitADC();

	// Configure the LCD
	//LCD_4BIT();

	//TIMER0_Init();		//reset timers, set TH0=0; TL0=0;

	printf ("EFM8 Period measurement at pin P1.1 using Timer 0.\n"
	        "File: %s\n"
	        "Compiled: %s, %s\n\n",
	        __FILE__, __DATE__, __TIME__);



TR0=0;
TMOD|=0b_0000_0001;
TH0=0; TL0=0;

	while(1) {
		// Reset the counter
		// TL0=0; 
		// TH0=0;
		// overflow_count=0;
		// TF0=0;
		// TR0=1;


		/********* FREQUENCY **********/
		//waitms(1000);
		//TR0=0; // Stop Timer/Counter 0
		//freq=overflow_count*0x10000L+TH0*0x100L+TL0;
		//period= (float) 1000/freq;


		// /******* PERIOD *********/
		// while(P1_1!=0); // Wait for the signal to be zero
		// while(P1_1!=1); // Wait for the signal to be one
		// TR0=1; // Start the timer
		// while(P1_1!=0) // Wait for the signal to be zero
		// {
		// 	if(TF0==1) // Did the 16-bit timer overflow?
		// 	{
		// 		TF0=0;
		// 		overflow_count++;
		// 	}
		// }
		// while(P1_1!=1) // Wait for the signal to be one
		// {
		// 	if(TF0==1) // Did the 16-bit timer overflow?
		// 	{
		// 		TF0=0;
		// 		overflow_count++;
		// 	}
		// }
		// TR0=0;

		/******* HALF PERIOD ********/
		TR0=0;
		TMOD|=0B_0000_0001;
		TH0=0; TL0=0;
		while(P1_1==1);
		while (P1_1==0);
		TR0=1;
		while (P1_1==1);
		TR0=0;
		period=(TH0*0x100+TL0)*2;

		//printf("OVF %d, TH0 %d, TL0 %d\r", overflow_count, TH0, TL0);
		//period = (float) (overflow_count*65536.0+TH0*256.0+TL0)*(12.0/SYSCLK);
	 	//period = (float)(TH0*0x100+TL0)*2;
		// half_period = (float) period/2; 		//Assume period is unsigned int
		// peak_time = (float) half_period/2;

		// v[0] = Volts_at_Pin(QFP32_MUX_P1_4);	//ref sqr wave
		// v[1] = Volts_at_Pin(QFP32_MUX_P1_5);	//ref sin wav
		// v[2] = Volts_at_Pin(QFP32_MUX_P1_6);	//test sqr wave
		// v[3] = Volts_at_Pin(QFP32_MUX_P1_7);	//test sin wave

		// /******** REFERENCE WAVE ********/
		// if (P1_1==1) {				// wait for zero cross
		// 	waitms(peak_time);		// wait for period/4 (peak)
		// 	//Timer3us(peak_time*1000);
		// 	ref_peak = v[1];		//measure reference peak V at P1.5
		// 	//test_peakRMS = ref_peak/sqrt(2);
		// }

		// /******** TEST WAVE ********/
		// if (P1_0==1) {				// wait for zero cross
		// 	waitms(peak_time);		// wait for period/4 (peak)
		// 	//Timer3us(peak_time*1000);
		// 	test_peak = v[3];		//measure reference peak V at P1.7
		// 	//test_peakRMS = test_peak/sqrt(2);
		// }

		//phase_diff = pulse_width*(360/period);


		printf( "\rPeriod = %f ms", period);
		//printf( "\rPeriod/2 = %d ms, Peak = %d ms, Ref Peak = %7.5f, Test Peak = %7.5f", half_period, peak_time, ref_peak, test_peak);
		//printf RMS values
		//printf time difference b/w zero cross signals
	}
}
