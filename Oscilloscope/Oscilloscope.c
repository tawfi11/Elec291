// Oscilloscope.c:  Shows how to use the ADC in autoscan mode to implement a
// simple oscilloscope.
//
// (c) 2019-2020, Jesus Calvino-Fraga
//

#include <stdio.h>
#include <stdlib.h>
#include <EFM8LB1.h>

// ~C51~  

#define SYSCLK 72000000L
#define SARCLK 18000000L
#define BAUDRATE 115200L
#define PAGES 16

#define DSFR(x) printf(#x"=0x%02x\r\n", x);

xdata unsigned int adc_scan[0x40*PAGES];
volatile bit capture_complete;
volatile char capture_rate;

char toupper (unsigned char c)
{
	if((c>='a') && (c<='z'))
	{
		return (c-'a'+'A');
	}
	else
	return c;
}

void putchar (char c)
{
	while (!TI);
	TI=0;
	SBUF=c;
}

char getchar (void)
{
	char c;
	while (!RI);
	RI=0;
	c=SBUF;
	return c;
}

void CMP1_ISR (void) interrupt INTERRUPT_CMP1
{
	P0_0=1;
	SFRPAGE = 0x00;
	EIE1&=~(1<<6); // ECP1. Comparator 1 (CP1) Interrupt disable.

	SFRPAGE=0x30;
	
	// Clear both rising and falling interrupt flags
	CMP1CN0&=0b_1100_1111;
	
	// Setup a new capture
	ADC0ASA=((unsigned int)adc_scan)|0x0001;
	ADC0ASCT=0b00111111;
	
	ADC0MX = QFP32_MUX_P2_1; // First channel to scan
	ADC0ASCF=(0x0<<6)| // Autoscan Single Trigger Enable
	         (0x1<<0); // Number of Autoscan Channels (0x0: 1 channel, 0x1: 2 channels, 0x2: 3 channels, 0x3: 4 channels)
	
	ADC0ASCF|=(1<<7); // Autoscan Enable.
	
	ADC0ASA+=0x80;// Configure the address for the second scan
	
	SFRPAGE=0x00;
	
	ADINT = 0;
	TR2=1;
}

void ADC0_ISR (void) interrupt INTERRUPT_ADC0EOC
{
	SFRPAGE=0x30;
	
	ADINT=0;
	if((ADC0ASCF&(1<<7))==0) // Last scan?
	{
		capture_complete=1;
		P0_0=0;
	}
	else
	{
		if(ADC0ASA < ( (0x40*2) * (PAGES-1) ) )
		{
			ADC0ASA+=(0x40*2); // bytes not words
		}
		else // One more capture and we are done
		{
			ADC0ASCF&=~(1<<7); // Disable autoscan
		}
	}
}

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
	
	P0MDOUT |= 0x13; // Enable UART0 TX as push-pull output  WARNING: P0.0, P0.1 set as outputs
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

	P0_0=0;
  	
	return 0;
}

void InitADC (void)
{
	SFRPAGE = 0x00;
	ADEN=0; // Disable ADC
	
	ADC0CN1=
		(0x0 << 6) | // 0x0: 10-bit, 0x1: 12-bit, 0x2: 14-bit
        (0x0 << 3) | // 0x0: No shift. 0x1: Shift right 1 bit. 0x2: Shift right 2 bits. 0x3: Shift right 3 bits.		
		(0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	
	ADC0CF0=
	    ((SYSCLK/SARCLK) << 3) | // SAR Clock Divider. Max is 18MHz. Fsarclk = (Fadcclk) / (ADSC + 1)
		(0x0 << 2); // 0: ADCCLK = SYSCLK. 1: ADCCLK = HFOSC0.
	
	ADC0CF1=
		(0x0 << 7) | // 0: Disable low power mode. 1: Enable low power mode.
		(0x01 << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	
	ADC0CN0 =  // This SFR is bit addressable
		(0x0 << 7) | // ADEN. 0: Disable ADC0. 1: Enable ADC0.
		(0x0 << 6) | // IPOEN. 0: Keep ADC powered on when ADEN is 1. 1: Power down when ADC is idle.
		(0x0 << 5) | // ADINT. Set by hardware upon completion of a data conversion. Must be cleared by firmware.
		(0x0 << 4) | // ADBUSY. Writing 1 to this bit initiates an ADC conversion when ADCM = 000. This bit should not be polled to indicate when a conversion is complete. Instead, the ADINT bit should be used when polling for conversion completion.
		(0x0 << 3) | // ADWINT. Set by hardware when the contents of ADC0H:ADC0L fall within the window specified by ADC0GTH:ADC0GTL and ADC0LTH:ADC0LTL. Can trigger an interrupt. Must be cleared by firmware.
		(0x0 << 2) | // ADGN (Gain Control). 0x0: PGA gain=1. 0x1: PGA gain=0.75. 0x2: PGA gain=0.5. 0x3: PGA gain=0.25.
		(0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.

	ADC0CF2= 
		(0x0 << 7) | // GNDSL. 0: reference is the GND pin. 1: reference is the AGND pin.
		(0x1 << 5) | // REFSL. 0x0: VREF pin (external or on-chip). 0x1: VDD pin. 0x2: 1.8V. 0x3: internal voltage reference.
		(0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	
	ADC0CN2 =
		(0x0 << 7) | // PACEN. 0x0: The ADC accumulator is over-written.  0x1: The ADC accumulator adds to results.
		(0x2 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3

	ADEN=1; // Enable ADC
	
	EIE1|=(1<<3); // ADC0 Conversion Complete Interrupt Enable
}

void Init_Comparator1 (char channel, char edge, unsigned char level)
{
	SFRPAGE = 0x00;
	EIE1&=~(1<<6); // ECP1. Comparator 1 (CP1) Interrupt disable.
	
	SFRPAGE = 0x30;
	
	CMP1CN0=0x00; // Disable Comparator 1

    CMP1MD=
    	(0x0<<7) | // CPLOUT. 0x0: zero at PCA overflow.  0x1: One at PCA overflow.
    	(0x0<<6) | // CPINV. 0x0: not inverted.  0x1: inverted
    	(((edge=='R')?0x1:0x0)<<5) | // CPRIE. 0x0: rising edge interrupt disabled. 0x1: rising edge interrupt enabled.
    	(((edge=='F')?0x1:0x0)<<4) | // CPFIE. 0x0: falling edge interrupt disabled. 0x1: falling edge interrupt enabled.
    	(0x3<<2) | // INSL. 0x0: CMP+/CMP-. 0x1: CMP+/GND. 0x2: DAC_CMP+/CMP-. 0x3: CMP+/DAC_CMP-
    	(0x0<<0) ; // CPMD. 0x0: mode 0. 0x1: mode 1. 0x2: mode 2. 0x3: mode 3.
	
    CMP1MX=
    	(0xb<<4) | // CMXN. 0x0:P0.7. 0x1:P1.0. 0x2:P2.0. 0x3:P2.1. 0x4:P2.2: 0x5:P2.3. 0x6:P2.4. 0x7:P2.5. 0x8:P2.6. 0xa:1.8. 0xb: VDD.
    	(((channel=='2')?0x4:0x3)<<0) ; // CMXP. 0x0:P0.7. 0x1:P1.0. 0x2:P2.0. 0x3:P2.1. 0x4:P2.2: 0x5:P2.3. 0x6:P2.4. 0x7:P2.5. 0x8:P2.6. 0xa:1.8. 0xb: VDD.

	CMP1CN1=
		(0x0<<7)  | // CPINH. 0x0: disabled. 0x1: enabled.
		((level & 0x3f)<<0) ; // DACLVL. DAC output = CMPREF * (DACLVL / 64)  

    CMP1CN0=
    	(0x1<<7); // Enable Comparator 1
	
	SFRPAGE = 0x00;
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

void InitPinADC (unsigned char portno, unsigned char pin_num)
{
	unsigned char mask;
	
	mask=1<<pin_num;

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
	ADINT = 0;
	ADBUSY = 1;     // Convert voltage at the pin
	while (!ADINT); // Wait for conversion to complete
	return (ADC0);
}

void Init_Timer2 (unsigned long rate)
{
	SFRPAGE = 0x00;
	TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	CKCON0|=0b_0001_0000; // Timer 2 uses the system clock
	TMR2RL=(0x10000L-(SYSCLK/rate)); // Initialize reload value
	TMR2=0xffff;   // Set to reload immediately
	//TR2=1;         // Start Timer2 (TMR2CN is bit addressable)
}

void Capture_Normal (void)
{
	unsigned long int uscount=0;
	unsigned long int timeout=0;
	
	switch(capture_rate)
	{
		case '0': timeout=10000L*1L;   break;
		case '1': timeout=10000L*2L;   break;
		case '2': timeout=10000L*4L;   break;
		case '3': timeout=10000L*8L;   break;
		case '4': timeout=10000L*16L;  break;
		case '5': timeout=10000L*32L;  break;
		case '6': timeout=10000L*64L;  break;
		case '7': timeout=10000L*128L; break;
		case '8': timeout=10000L*256L; break;
		case '9': timeout=10000L*512L; break;
		default:  timeout=10000L*1L;   break;
	}
	
	capture_complete=0;
	SFRPAGE=0x30;
	CMP1CN0&=0b_1100_1111; // Clear any pending comparator interrupts
	SFRPAGE=0x00;
	EIE1|=(1<<6); // ECP1. Comparator 1 (CP1) Interrupt Enable.

	CKCON0|=0b_0100_0000;// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0.
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag

	while (!capture_complete) // Wait for conversion to complete
	{
		while (!(TMR3CN0 & 0x80));  // Wait for overflow
		TMR3CN0 &= ~(0x80);         // Clear overflow indicator
		uscount++;
		if(uscount==timeout) break;   // WARNING: This time must be considered carefully
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	TR2=0;	
}


void Capture_Auto (void)
{
	Capture_Normal();
	
	if(!capture_complete) // Timed out with no trigger, so in auto mode force a scan
	{
		SFRPAGE = 0x00;
		EIE1&=~(1<<6); // ECP1. Comparator 1 (CP1) Interrupt disable.
	
		SFRPAGE=0x30;
		
		CMP1CN0&=0b_1100_1111;// Clear both rising and falling interrupt flags
		
		// Setup a new capture
		ADC0ASA=((unsigned int)adc_scan)|0x0001;
		ADC0ASCT=0b00111111;
		
		ADC0MX = QFP32_MUX_P2_1; // First channel to scan
		ADC0ASCF=(0x0<<6)| // Autoscan Single Trigger Enable
		         (0x1<<0); // Number of Autoscan Channels (0x0: 1 channel, 0x1: 2 channels, 0x2: 3 channels, 0x3: 4 channels)
		
		ADC0ASCF|=(1<<7); // Autoscan Enable.
		
		ADC0ASA+=0x80;// Configure the address for the second scan
		
		SFRPAGE=0x00;
		
		ADINT = 0;
		TR2=1;
		
		while (!capture_complete);
	}
}

void main (void)
{
	unsigned int j;
	char c, trigger_channel, trigger_slope, trigger_level;
	char prev_trigger_channel, prev_trigger_slope, prev_trigger_level;
	unsigned char d;
	
	InitPinADC(2, 1); // Configure P2.1 as analog input
	InitPinADC(2, 2); // Configure P2.2 as analog input
    InitADC();
    Init_Timer2(1000000L); // Sampling rate.  Fastest possible is 1us.
    capture_rate='0';
    
    trigger_channel=prev_trigger_channel='1';
    trigger_slope=prev_trigger_slope='F';
    trigger_level=prev_trigger_level=0x3f/3;
    Init_Comparator1(trigger_channel, trigger_slope, trigger_level); // Trigger: Channel 1, falling edge, VDD/3

    EA=1;

	while(1)
	{	
		c=toupper(getchar());
		if(c=='A') // Auto mode
		{
			trigger_channel=getchar();
			trigger_slope=toupper(getchar());
			trigger_level=getchar();	
			// Minimize comparator1 initialization as it causes trigger glitches
			if ( (trigger_channel!=prev_trigger_channel) || (trigger_slope!=prev_trigger_slope) || (trigger_level!=prev_trigger_level) )
			{
				Init_Comparator1(trigger_channel, trigger_slope, trigger_level);
			    prev_trigger_channel=trigger_channel;
			    prev_trigger_slope=trigger_slope;
			    prev_trigger_level=trigger_level;
			}
			Capture_Auto();
			
			SFRPAGE=0x20;   // UART0, CRC, and SPI can work on this page
			CRC0CN0=0b_0000_1000; // Initialize hardware CRC result to zero;
			for(j=0; j<(0x40*PAGES); j+=2)
			{
				d=adc_scan[j+0]>>2;
				putchar(d);
				CRC0IN=d;// Feed new byte to hardware CRC calculator
				d=adc_scan[j+1]>>2;
				putchar(d);
				CRC0IN=d;// Feed new byte to hardware CRC calculator
			}
			CRC0CN0=0x01; // Set bit to read hardware CRC high byte
			putchar(CRC0DAT);
			CRC0CN0=0x00; // Clear bit to read hardware CRC low byte
			putchar(CRC0DAT);
			SFRPAGE = 0x00;
		}
		else if (c=='N') // Normal mode
		{
			trigger_channel=getchar();
			trigger_slope=toupper(getchar());
			trigger_level=getchar();	
			// Minimize comparator1 initialization as it causes trigger glitches
			if ( (trigger_channel!=prev_trigger_channel) || (trigger_slope!=prev_trigger_slope) || (trigger_level!=prev_trigger_level) )
			{
				Init_Comparator1(trigger_channel, trigger_slope, trigger_level);
			    prev_trigger_channel=trigger_channel;
			    prev_trigger_slope=trigger_slope;
			    prev_trigger_level=trigger_level;
			}
			Capture_Normal();
			
			SFRPAGE=0x20;   // UART0, CRC, and SPI can work on this page
			CRC0CN0=0b_0000_1000; // Initialize hardware CRC result to zero;
			for(j=0; j<(0x40*PAGES); j+=2)
			{
				d=adc_scan[j+0]>>2;
				putchar(d);
				CRC0IN=d;// Feed new byte to hardware CRC calculator
				d=adc_scan[j+1]>>2;
				putchar(d);
				CRC0IN=d;// Feed new byte to hardware CRC calculator
			}
			
			if(capture_complete)
			{
				CRC0CN0=0x01; // Set bit to read hardware CRC high byte
				putchar(CRC0DAT);
				CRC0CN0=0x00; // Clear bit to read hardware CRC low byte
				putchar(CRC0DAT);
				SFRPAGE = 0x00;
			}
			else // Send message with bad CRC so the wave is not displayed
			{
				putchar(0x00);
				putchar(0x00);
			}
		}
		else if (c=='I') // Identify command
		{
			putchar('S'); // That is it!
		}
		else if (c=='R') // Capture rate command
		{
			c=toupper(getchar());
			if(c!=capture_rate)
			{
				capture_rate=c;
				switch(capture_rate)
				{
					case '0':
	    				Init_Timer2(1000000L); // Sampling rate.  Fastest possible is 1us.
					break;
					case '1':
	    				Init_Timer2(1000000L/2L);
					break;
					case '2':
	    				Init_Timer2(1000000L/4L);
					break;
					case '3':
	    				Init_Timer2(1000000L/8L);
					break;
					case '4':
	    				Init_Timer2(1000000L/16L);
					break;
					case '5':
	    				Init_Timer2(1000000L/32L);
					break;
					case '6':
	    				Init_Timer2(1000000L/64L);
					break;
					case '7':
	    				Init_Timer2(1000000L/128L);
					break;
					case '8':
	    				Init_Timer2(1000000L/256L);
					break;
					case '9':
	    				Init_Timer2(1000000L/512L);
					break;
					default:
					break;
				}
			}
		}
	}  
}	
