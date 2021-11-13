;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Wed Mar 11 11:36:09 2020
;--------------------------------------------------------
$name pwm_EFM8
$optc51 --model-small
$printf_float
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _InitPinADC_PARM_2
	public _main
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitPinADC
	public _Timer2_ISR
	public _getsn
	public _LCDprint
	public _LCD_4BIT
	public _WriteCommand
	public _WriteData
	public _LCD_byte
	public _LCD_pulse
	public _waitms
	public _Timer3us
	public _InitADC
	public __c51_external_startup
	public _LCDprint_PARM_3
	public _getsn_PARM_2
	public _LCDprint_PARM_2
	public _in3
	public _in2
	public _in1
	public _in0
	public _pwm_count1
	public _pwm_count0
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_pwm_count0:
	ds 1
_pwm_count1:
	ds 1
_in0:
	ds 2
_in1:
	ds 2
_in2:
	ds 2
_in3:
	ds 2
_LCDprint_PARM_2:
	ds 1
_getsn_PARM_2:
	ds 2
_getsn_buff_1_64:
	ds 3
_getsn_sloc0_1_0:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_LCDprint_PARM_3:
	DBIT	1
_Timer2_ISR_sloc0_1_0:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x002b
	ljmp	_Timer2_ISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:40: volatile unsigned char pwm_count0=0;
	mov	_pwm_count0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:41: volatile unsigned char pwm_count1=0;
	mov	_pwm_count1,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:43: volatile unsigned int in0 = 50;
	mov	_in0,#0x32
	clr	a
	mov	(_in0 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:44: volatile unsigned int in1 = 50;
	mov	_in1,#0x32
	clr	a
	mov	(_in1 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:46: volatile unsigned int in2 = 50;
	mov	_in2,#0x32
	clr	a
	mov	(_in2 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:47: volatile unsigned int in3 = 50;
	mov	_in3,#0x32
	clr	a
	mov	(_in3 + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:49: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:52: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:53: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:54: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:56: VDM0CN=0x80;       // enable VDD monitor
	mov	_VDM0CN,#0x80
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:57: RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:64: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:65: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:66: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:87: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:88: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:89: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:90: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:91: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:92: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:97: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:98: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:99: XBR1     = 0X00;
	mov	_XBR1,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:100: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:106: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:107: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:108: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:109: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:110: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:111: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:112: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:115: TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	mov	_TMR2CN0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:116: CKCON0|=0b_0001_0000; // Timer 2 uses the system clock
	orl	_CKCON0,#0x10
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:117: TMR2RL=(0x10000L-(SYSCLK/10000L)); // Initialize reload value
	mov	_TMR2RL,#0xE0
	mov	(_TMR2RL >> 8),#0xE3
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:118: TMR2=0xffff;   // Set to reload immediately
	mov	_TMR2,#0xFF
	mov	(_TMR2 >> 8),#0xFF
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:119: ET2=1;         // Enable Timer2 interrupts
	setb	_ET2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:120: TR2=1;         // Start Timer2 (TMR2CN is bit addressable)
	setb	_TR2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:122: EA=1; // Enable interrupts
	setb	_EA
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:125: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:128: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:130: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:131: ADC0CN1 = 0b_10_000_000; //14-bit,  Right justified no shifting applied, perform and Accumulate 1 conversion.
	mov	_ADC0CN1,#0x80
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:132: ADC0CF0 = 0b_11111_0_00; // SYSCLK/32
	mov	_ADC0CF0,#0xF8
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:133: ADC0CF1 = 0b_0_0_011110; // Same as default for now
	mov	_ADC0CF1,#0x1E
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:134: ADC0CN0 = 0b_0_0_0_0_0_00_0; // Same as default for now
	mov	_ADC0CN0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:135: ADC0CF2 = 0b_0_01_11111 ; // GND pin, Vref=VDD
	mov	_ADC0CF2,#0x3F
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:136: ADC0CN2 = 0b_0_000_0000;  // Same as default for now. ADC0 conversion initiated on write of 1 to ADBUSY.
	mov	_ADC0CN2,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:137: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:141: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:146: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:148: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:149: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:151: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:152: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L004004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L004007?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:154: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L004001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L004001?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:155: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:152: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L004004?
L004007?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:157: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r2 r3 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:160: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:163: for(j=ms; j!=0; j--)
L005001?:
	cjne	r2,#0x00,L005010?
	cjne	r3,#0x00,L005010?
	ret
L005010?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:165: Timer3us(249);
	mov	dpl,#0xF9
	push	ar2
	push	ar3
	lcall	_Timer3us
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:166: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:167: Timer3us(249);
	mov	dpl,#0xF9
	lcall	_Timer3us
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:168: Timer3us(250);
	mov	dpl,#0xFA
	lcall	_Timer3us
	pop	ar3
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:163: for(j=ms; j!=0; j--)
	dec	r2
	cjne	r2,#0xff,L005011?
	dec	r3
L005011?:
	sjmp	L005001?
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_pulse'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:172: void LCD_pulse (void)
;	-----------------------------------------
;	 function LCD_pulse
;	-----------------------------------------
_LCD_pulse:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:174: LCD_E=1;
	setb	_P2_5
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:175: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:176: LCD_E=0;
	clr	_P2_5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_byte'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:179: void LCD_byte (unsigned char x)
;	-----------------------------------------
;	 function LCD_byte
;	-----------------------------------------
_LCD_byte:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:182: ACC=x; //Send high nible
	mov	_ACC,r2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:183: LCD_D7=ACC_7;
	mov	c,_ACC_7
	mov	_P2_1,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:184: LCD_D6=ACC_6;
	mov	c,_ACC_6
	mov	_P2_2,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:185: LCD_D5=ACC_5;
	mov	c,_ACC_5
	mov	_P2_3,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:186: LCD_D4=ACC_4;
	mov	c,_ACC_4
	mov	_P2_4,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:187: LCD_pulse();
	push	ar2
	lcall	_LCD_pulse
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:188: Timer3us(40);
	mov	dpl,#0x28
	lcall	_Timer3us
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:189: ACC=x; //Send low nible
	mov	_ACC,r2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:190: LCD_D7=ACC_3;
	mov	c,_ACC_3
	mov	_P2_1,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:191: LCD_D6=ACC_2;
	mov	c,_ACC_2
	mov	_P2_2,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:192: LCD_D5=ACC_1;
	mov	c,_ACC_1
	mov	_P2_3,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:193: LCD_D4=ACC_0;
	mov	c,_ACC_0
	mov	_P2_4,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:194: LCD_pulse();
	ljmp	_LCD_pulse
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteData'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:197: void WriteData (unsigned char x)
;	-----------------------------------------
;	 function WriteData
;	-----------------------------------------
_WriteData:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:199: LCD_RS=1;
	setb	_P2_6
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:200: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:201: waitms(2);
	mov	dptr,#0x0002
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'WriteCommand'
;------------------------------------------------------------
;x                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:204: void WriteCommand (unsigned char x)
;	-----------------------------------------
;	 function WriteCommand
;	-----------------------------------------
_WriteCommand:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:206: LCD_RS=0;
	clr	_P2_6
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:207: LCD_byte(x);
	mov	dpl,r2
	lcall	_LCD_byte
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:208: waitms(5);
	mov	dptr,#0x0005
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCD_4BIT'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:211: void LCD_4BIT (void)
;	-----------------------------------------
;	 function LCD_4BIT
;	-----------------------------------------
_LCD_4BIT:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:213: LCD_E=0; // Resting state of LCD's enable is zero
	clr	_P2_5
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:215: waitms(20);
	mov	dptr,#0x0014
	lcall	_waitms
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:217: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:218: WriteCommand(0x33);
	mov	dpl,#0x33
	lcall	_WriteCommand
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:219: WriteCommand(0x32); // Change to 4-bit mode
	mov	dpl,#0x32
	lcall	_WriteCommand
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:222: WriteCommand(0x28);
	mov	dpl,#0x28
	lcall	_WriteCommand
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:223: WriteCommand(0x0c);
	mov	dpl,#0x0C
	lcall	_WriteCommand
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:224: WriteCommand(0x01); // Clear screen command (takes some time)
	mov	dpl,#0x01
	lcall	_WriteCommand
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:225: waitms(20); // Wait for clear screen command to finsih.
	mov	dptr,#0x0014
	ljmp	_waitms
;------------------------------------------------------------
;Allocation info for local variables in function 'LCDprint'
;------------------------------------------------------------
;line                      Allocated with name '_LCDprint_PARM_2'
;string                    Allocated to registers r2 r3 r4 
;j                         Allocated to registers r5 r6 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:228: void LCDprint(char * string, unsigned char line, bit clear)
;	-----------------------------------------
;	 function LCDprint
;	-----------------------------------------
_LCDprint:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:232: WriteCommand(line==2?0xc0:0x80);
	mov	a,#0x02
	cjne	a,_LCDprint_PARM_2,L011013?
	mov	r5,#0xC0
	sjmp	L011014?
L011013?:
	mov	r5,#0x80
L011014?:
	mov	dpl,r5
	push	ar2
	push	ar3
	push	ar4
	lcall	_WriteCommand
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:233: waitms(5);
	mov	dptr,#0x0005
	lcall	_waitms
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:234: for(j=0; string[j]!=0; j++)	WriteData(string[j]);// Write the message
	mov	r5,#0x00
	mov	r6,#0x00
L011003?:
	mov	a,r5
	add	a,r2
	mov	r7,a
	mov	a,r6
	addc	a,r3
	mov	r0,a
	mov	ar1,r4
	mov	dpl,r7
	mov	dph,r0
	mov	b,r1
	lcall	__gptrget
	mov	r7,a
	jz	L011006?
	mov	dpl,r7
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_WriteData
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r5
	cjne	r5,#0x00,L011003?
	inc	r6
	sjmp	L011003?
L011006?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:235: if(clear) for(; j<CHARS_PER_LINE; j++) WriteData(' '); // Clear the rest of the line
	jnb	_LCDprint_PARM_3,L011011?
	mov	ar2,r5
	mov	ar3,r6
L011007?:
	clr	c
	mov	a,r2
	subb	a,#0x10
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L011011?
	mov	dpl,#0x20
	push	ar2
	push	ar3
	lcall	_WriteData
	pop	ar3
	pop	ar2
	inc	r2
	cjne	r2,#0x00,L011007?
	inc	r3
	sjmp	L011007?
L011011?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getsn'
;------------------------------------------------------------
;len                       Allocated with name '_getsn_PARM_2'
;buff                      Allocated with name '_getsn_buff_1_64'
;j                         Allocated with name '_getsn_sloc0_1_0'
;c                         Allocated to registers r3 
;sloc0                     Allocated with name '_getsn_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:238: int getsn (char * buff, int len)
;	-----------------------------------------
;	 function getsn
;	-----------------------------------------
_getsn:
	mov	_getsn_buff_1_64,dpl
	mov	(_getsn_buff_1_64 + 1),dph
	mov	(_getsn_buff_1_64 + 2),b
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:243: for(j=0; j<(len-1); j++)
	clr	a
	mov	_getsn_sloc0_1_0,a
	mov	(_getsn_sloc0_1_0 + 1),a
	mov	a,_getsn_PARM_2
	add	a,#0xff
	mov	r7,a
	mov	a,(_getsn_PARM_2 + 1)
	addc	a,#0xff
	mov	r0,a
	mov	r1,#0x00
	mov	r2,#0x00
L012005?:
	clr	c
	mov	a,r1
	subb	a,r7
	mov	a,r2
	xrl	a,#0x80
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jnc	L012008?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:245: c=getchar();
	push	ar2
	push	ar7
	push	ar0
	push	ar1
	lcall	_getchar
	mov	r3,dpl
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:246: if ( (c=='\n') || (c=='\r') )
	cjne	r3,#0x0A,L012015?
	sjmp	L012001?
L012015?:
	cjne	r3,#0x0D,L012002?
L012001?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:248: buff[j]=0;
	mov	a,_getsn_sloc0_1_0
	add	a,_getsn_buff_1_64
	mov	r4,a
	mov	a,(_getsn_sloc0_1_0 + 1)
	addc	a,(_getsn_buff_1_64 + 1)
	mov	r5,a
	mov	r6,(_getsn_buff_1_64 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	clr	a
	lcall	__gptrput
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:249: return j;
	mov	dpl,_getsn_sloc0_1_0
	mov	dph,(_getsn_sloc0_1_0 + 1)
	ret
L012002?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:253: buff[j]=c;
	mov	a,r1
	add	a,_getsn_buff_1_64
	mov	r4,a
	mov	a,r2
	addc	a,(_getsn_buff_1_64 + 1)
	mov	r5,a
	mov	r6,(_getsn_buff_1_64 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r3
	lcall	__gptrput
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:243: for(j=0; j<(len-1); j++)
	inc	r1
	cjne	r1,#0x00,L012018?
	inc	r2
L012018?:
	mov	_getsn_sloc0_1_0,r1
	mov	(_getsn_sloc0_1_0 + 1),r2
	sjmp	L012005?
L012008?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:256: buff[j]=0;
	mov	a,_getsn_sloc0_1_0
	add	a,_getsn_buff_1_64
	mov	r2,a
	mov	a,(_getsn_sloc0_1_0 + 1)
	addc	a,(_getsn_buff_1_64 + 1)
	mov	r3,a
	mov	r4,(_getsn_buff_1_64 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:257: return len;
	mov	dpl,_getsn_PARM_2
	mov	dph,(_getsn_PARM_2 + 1)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:260: void Timer2_ISR (void) interrupt 5
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
	push	acc
	push	ar2
	push	ar3
	push	psw
	mov	psw,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:262: TF2H = 0; // Clear Timer2 interrupt flag
	clr	_TF2H
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:264: pwm_count0++;
	inc	_pwm_count0
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:265: if(pwm_count0>100) pwm_count0=0;
	mov	a,_pwm_count0
	add	a,#0xff - 0x64
	jnc	L013002?
	mov	_pwm_count0,#0x00
L013002?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:267: OUT0=pwm_count0>in0?0:1;
	mov	r2,_pwm_count0
	mov	r3,#0x00
	clr	c
	mov	a,_in0
	subb	a,r2
	mov	a,(_in0 + 1)
	subb	a,r3
	mov  _Timer2_ISR_sloc0_1_0,c
	cpl	c
	mov	_P1_6,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:268: OUT1=pwm_count0>in1?0:1;
	mov	r2,_pwm_count0
	mov	r3,#0x00
	clr	c
	mov	a,_in1
	subb	a,r2
	mov	a,(_in1 + 1)
	subb	a,r3
	mov  _Timer2_ISR_sloc0_1_0,c
	cpl	c
	mov	_P1_5,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:270: pwm_count1++;
	inc	_pwm_count1
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:271: if(pwm_count1>100) pwm_count1=0;
	mov	a,_pwm_count1
	add	a,#0xff - 0x64
	jnc	L013004?
	mov	_pwm_count1,#0x00
L013004?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:273: OUT2=pwm_count1>in2?0:1;
	mov	r2,_pwm_count1
	mov	r3,#0x00
	clr	c
	mov	a,_in2
	subb	a,r2
	mov	a,(_in2 + 1)
	subb	a,r3
	mov  _Timer2_ISR_sloc0_1_0,c
	cpl	c
	mov	_P1_3,c
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:274: OUT3=pwm_count1>in3?0:1;
	mov	r2,_pwm_count1
	mov	r3,#0x00
	clr	c
	mov	a,_in3
	subb	a,r2
	mov	a,(_in3 + 1)
	subb	a,r3
	mov  _Timer2_ISR_sloc0_1_0,c
	cpl	c
	mov	_P1_1,c
	pop	psw
	pop	ar3
	pop	ar2
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pinno                     Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:278: void InitPinADC (unsigned char portno, unsigned char pinno)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:282: mask=1<<pinno;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L014013?
L014011?:
	add	a,acc
L014013?:
	djnz	b,L014011?
	mov	r3,a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:284: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:285: switch (portno)
	cjne	r2,#0x00,L014014?
	sjmp	L014001?
L014014?:
	cjne	r2,#0x01,L014015?
	sjmp	L014002?
L014015?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:287: case 0:
	cjne	r2,#0x02,L014005?
	sjmp	L014003?
L014001?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:288: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P0MDIN,a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:289: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:290: break;
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:291: case 1:
	sjmp	L014005?
L014002?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:292: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P1MDIN,a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:293: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:294: break;
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:295: case 2:
	sjmp	L014005?
L014003?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:296: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P2MDIN,a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:297: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:301: }
L014005?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:302: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:305: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:308: ADBUSY=1;       // Dummy conversion first to select new pin
	setb	_ADBUSY
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:309: while (ADBUSY); // Wait for dummy conversion to finish
L015001?:
	jb	_ADBUSY,L015001?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:310: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:311: while (ADBUSY); // Wait for conversion to complete
L015004?:
	jb	_ADBUSY,L015004?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:312: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:315: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:317: return ((ADC_at_Pin(pin)*VDD)/0b_0011_1111_1111_1111);
	lcall	_ADC_at_Pin
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x6C8B
	mov	b,#0x53
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xFC
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;buff                      Allocated to registers r4 r5 r6 
;state                     Allocated to registers r2 r3 
;previous_state            Allocated to registers 
;inrange                   Allocated to registers 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:326: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:329: int state = 0;
	mov	r2,#0x00
	mov	r3,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:333: InitPinADC(1, 0); // Configure P2.5 as analog input
	mov	_InitPinADC_PARM_2,#0x00
	mov	dpl,#0x01
	push	ar2
	push	ar3
	lcall	_InitPinADC
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:334: InitADC();
	lcall	_InitADC
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:335: LCD_4BIT();
	lcall	_LCD_4BIT
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:337: waitms(500); // Give PuTTY a chance to start.
	mov	dptr,#0x01F4
	lcall	_waitms
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:339: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:343: printf("\rEnter 4 spaced numbers (2 for right/left motors) between 0-100: ");
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:344: scanf("%d %d %d %d\n", &in0,&in1,&in2,&in3);
	mov	a,#_in3
	push	acc
	mov	a,#(_in3 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#_in2
	push	acc
	mov	a,#(_in2 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#_in1
	push	acc
	mov	a,#(_in1 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#_in0
	push	acc
	mov	a,#(_in0 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_scanf
	mov	a,sp
	add	a,#0xf1
	mov	sp,a
	pop	ar3
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:347: while(1)
L017062?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:356: if (in0<0 || in0>100 || in1<0 || in1>100 || in2<0 || in2>100 || in3<0 || in3>100) {
	clr	c
	mov	a,#0x64
	subb	a,_in0
	clr	a
	subb	a,(_in0 + 1)
	jc	L017001?
	mov	a,#0x64
	subb	a,_in1
	clr	a
	subb	a,(_in1 + 1)
	jc	L017001?
	mov	a,#0x64
	subb	a,_in2
	clr	a
	subb	a,(_in2 + 1)
	jc	L017001?
	mov	a,#0x64
	subb	a,_in3
	clr	a
	subb	a,(_in3 + 1)
	jnc	L017002?
L017001?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:357: in0 = 50;
	mov	_in0,#0x32
	clr	a
	mov	(_in0 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:358: in1 = 50;
	mov	_in1,#0x32
	clr	a
	mov	(_in1 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:359: in2 = 50;
	mov	_in2,#0x32
	clr	a
	mov	(_in2 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:360: in3 = 50;
	mov	_in3,#0x32
	clr	a
	mov	(_in3 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:362: break;
	ljmp	L017063?
L017002?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:365: if (STOP_BUTTON == 0) {
	jb	_P1_7,L017098?
	ljmp	L017063?
L017098?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:367: } else if (FWD_BUTTON == 0) {
	jb	_P0_5,L017019?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:368: in0 = 30;
	mov	_in0,#0x1E
	clr	a
	mov	(_in0 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:369: in1 = 70;
	mov	_in1,#0x46
	clr	a
	mov	(_in1 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:370: in2 = 30;
	mov	_in2,#0x1E
	clr	a
	mov	(_in2 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:371: in3 = 70;
	mov	_in3,#0x46
	clr	a
	mov	(_in3 + 1),a
	sjmp	L017023?
L017019?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:372: } else if (BCK_BUTTON == 0) {
	jb	_P0_7,L017016?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:373: in0 = 70;
	mov	_in0,#0x46
	clr	a
	mov	(_in0 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:374: in1 = 30;
	mov	_in1,#0x1E
	clr	a
	mov	(_in1 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:375: in2 = 70;
	mov	_in2,#0x46
	clr	a
	mov	(_in2 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:376: in3 = 30;
	mov	_in3,#0x1E
	clr	a
	mov	(_in3 + 1),a
	sjmp	L017023?
L017016?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:377: } else if (RGT_BUTTON == 0) {
	jb	_P1_2,L017013?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:378: in0 = 30;
	mov	_in0,#0x1E
	clr	a
	mov	(_in0 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:379: in1 = 70;
	mov	_in1,#0x46
	clr	a
	mov	(_in1 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:380: in2 = 50;
	mov	_in2,#0x32
	clr	a
	mov	(_in2 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:381: in3 = 50;
	mov	_in3,#0x32
	clr	a
	mov	(_in3 + 1),a
	sjmp	L017023?
L017013?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:382: } else if (LFT_BUTTON == 0) {
	jb	_P1_4,L017023?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:383: in0 = 50;
	mov	_in0,#0x32
	clr	a
	mov	(_in0 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:384: in1 = 50;
	mov	_in1,#0x32
	clr	a
	mov	(_in1 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:385: in2 = 30;
	mov	_in2,#0x1E
	clr	a
	mov	(_in2 + 1),a
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:386: in3 = 70;
	mov	_in3,#0x46
	clr	a
	mov	(_in3 + 1),a
L017023?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:390: if (MODE_BUTTON == 0) {
	jnb	_P0_3,L017103?
	ljmp	L017060?
L017103?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:391: if (state == 0) {			//display PWM signal inputs
	mov	a,r2
	orl	a,r3
	jz	L017104?
	ljmp	L017057?
L017104?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:392: LCDprint("               ",1,1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_3
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:393: LCDprint("               ",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_3
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:395: buff = malloc(17*sizeof(char));
	mov	dptr,#0x0011
	lcall	_malloc
	mov	r4,dpl
	mov	r5,dph
	mov	r6,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:396: sprintf(buff, "PWM1:%d,%d",in0,in1);
	push	ar4
	push	ar5
	push	ar6
	push	_in1
	push	(_in1 + 1)
	push	_in0
	push	(_in0 + 1)
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:397: LCDprint(buff,1,1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	push	ar4
	push	ar5
	push	ar6
	lcall	_LCDprint
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:398: free(buff);
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	_free
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:400: buff = malloc(17*sizeof(char));
	mov	dptr,#0x0011
	lcall	_malloc
	mov	r7,dpl
	mov	r0,dph
	mov	ar4,r7
	mov	ar5,r0
	mov	r6,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:401: sprintf(buff, "PWM2:%d,%d",in2,in3);
	push	ar4
	push	ar5
	push	ar6
	push	_in3
	push	(_in3 + 1)
	push	_in2
	push	(_in2 + 1)
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xf6
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:402: LCDprint(buff,2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	push	ar4
	push	ar5
	push	ar6
	lcall	_LCDprint
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:403: free(buff);
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	_free
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:405: state=1;
	mov	r2,#0x01
	mov	r3,#0x00
	ljmp	L017060?
L017057?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:407: } else if (state == 1) {
	cjne	r2,#0x01,L017105?
	cjne	r3,#0x00,L017105?
	sjmp	L017106?
L017105?:
	ljmp	L017060?
L017106?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:408: LCDprint("               ",1,1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_3
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:409: LCDprint("               ",2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dptr,#__str_3
	mov	b,#0x80
	lcall	_LCDprint
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:411: buff = malloc(17*sizeof(char));
	mov	dptr,#0x0011
	lcall	_malloc
	mov	r7,dpl
	mov	r0,dph
	mov	ar4,r7
	mov	ar5,r0
	mov	r6,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:412: sprintf(buff,"Direction:");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:413: LCDprint(buff,1,1);
	mov	_LCDprint_PARM_2,#0x01
	setb	_LCDprint_PARM_3
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	push	ar4
	push	ar5
	push	ar6
	lcall	_LCDprint
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:414: free(buff);
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	_free
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:416: buff = malloc(17*sizeof(char));
	mov	dptr,#0x0011
	lcall	_malloc
	mov	r7,dpl
	mov	r0,dph
	mov	ar4,r7
	mov	ar5,r0
	mov	r6,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:418: if (in0>in1 && in2==in0 && in3==in1){	//backward (try 70 30 70 30)
	clr	c
	mov	a,_in1
	subb	a,_in0
	mov	a,(_in1 + 1)
	subb	a,(_in0 + 1)
	jnc	L017050?
	mov	a,_in0
	cjne	a,_in2,L017050?
	mov	a,(_in0 + 1)
	cjne	a,(_in2 + 1),L017050?
	mov	a,_in1
	cjne	a,_in3,L017050?
	mov	a,(_in1 + 1)
	cjne	a,(_in3 + 1),L017050?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:419: sprintf(buff,"Backward");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	ljmp	L017051?
L017050?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:420: } else if (in0<in1 && in2==in0 && in3==in1) {	//forward (try 30 70 30 70)
	clr	c
	mov	a,_in0
	subb	a,_in1
	mov	a,(_in0 + 1)
	subb	a,(_in1 + 1)
	jnc	L017045?
	mov	a,_in0
	cjne	a,_in2,L017045?
	mov	a,(_in0 + 1)
	cjne	a,(_in2 + 1),L017045?
	mov	a,_in1
	cjne	a,_in3,L017045?
	mov	a,(_in1 + 1)
	cjne	a,(_in3 + 1),L017045?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:421: sprintf(buff,"Forward");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_8
	push	acc
	mov	a,#(__str_8 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	ljmp	L017051?
L017045?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:422: } else if (in0<in1 && in3<in1) {	//forward left (try 30 70 40 60)
	clr	c
	mov	a,_in0
	subb	a,_in1
	mov	a,(_in0 + 1)
	subb	a,(_in1 + 1)
	jnc	L017041?
	clr	c
	mov	a,_in3
	subb	a,_in1
	mov	a,(_in3 + 1)
	subb	a,(_in1 + 1)
	jnc	L017041?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:423: sprintf(buff,"Forward Left");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_9
	push	acc
	mov	a,#(__str_9 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	ljmp	L017051?
L017041?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:424: } else if (in2<in3 && in1<in3) {	//forward right (try 30 70 40 60)
	clr	c
	mov	a,_in2
	subb	a,_in3
	mov	a,(_in2 + 1)
	subb	a,(_in3 + 1)
	jnc	L017037?
	clr	c
	mov	a,_in1
	subb	a,_in3
	mov	a,(_in1 + 1)
	subb	a,(_in3 + 1)
	jnc	L017037?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:425: sprintf(buff,"Forward Right");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_10
	push	acc
	mov	a,#(__str_10 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	ljmp	L017051?
L017037?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:426: } else if (in0==in1 && in2==in3) {	//stop (try 30 70 30 70)
	mov	a,_in1
	cjne	a,_in0,L017033?
	mov	a,(_in1 + 1)
	cjne	a,(_in0 + 1),L017033?
	mov	a,_in3
	cjne	a,_in2,L017033?
	mov	a,(_in3 + 1)
	cjne	a,(_in2 + 1),L017033?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:427: sprintf(buff,"Stop");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_11
	push	acc
	mov	a,#(__str_11 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	ljmp	L017051?
L017033?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:428: } else if (in0==in1 && in2>in3) {	//back left (try 50 50 70 30)
	mov	a,_in1
	cjne	a,_in0,L017029?
	mov	a,(_in1 + 1)
	cjne	a,(_in0 + 1),L017029?
	clr	c
	mov	a,_in3
	subb	a,_in2
	mov	a,(_in3 + 1)
	subb	a,(_in2 + 1)
	jnc	L017029?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:429: sprintf(buff,"Back Left");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_12
	push	acc
	mov	a,#(__str_12 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	sjmp	L017051?
L017029?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:430: } else if (in0==in1 && in2<in3) {	//back right (try 70 30 50 50)
	mov	a,_in1
	cjne	a,_in0,L017025?
	mov	a,(_in1 + 1)
	cjne	a,(_in0 + 1),L017025?
	clr	c
	mov	a,_in2
	subb	a,_in3
	mov	a,(_in2 + 1)
	subb	a,(_in3 + 1)
	jnc	L017025?
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:431: sprintf(buff,"Back Righ");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_13
	push	acc
	mov	a,#(__str_13 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
	sjmp	L017051?
L017025?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:433: sprintf(buff,"Turning");
	push	ar4
	push	ar5
	push	ar6
	mov	a,#__str_14
	push	acc
	mov	a,#(__str_14 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	push	ar4
	push	ar5
	push	ar6
	lcall	_sprintf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
	pop	ar6
	pop	ar5
	pop	ar4
L017051?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:436: LCDprint(buff,2,1);
	mov	_LCDprint_PARM_2,#0x02
	setb	_LCDprint_PARM_3
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	push	ar4
	push	ar5
	push	ar6
	lcall	_LCDprint
	pop	ar6
	pop	ar5
	pop	ar4
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:437: free(buff);
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	lcall	_free
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:439: state=0;
	mov	r2,#0x00
	mov	r3,#0x00
L017060?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:442: printf("%f\n", Volts_at_Pin(QFP32_MUX_P1_0));
	mov	dpl,#0x06
	push	ar2
	push	ar3
	lcall	_Volts_at_Pin
	mov	r4,dpl
	mov	r5,dph
	mov	r6,b
	mov	r7,a
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	mov	a,#__str_15
	push	acc
	mov	a,#(__str_15 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf9
	mov	sp,a
	pop	ar3
	pop	ar2
	ljmp	L017062?
L017063?:
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:455: printf("\x1b[2J");
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\nusai\Desktop\ELEC 291\Motor\pwm_EFM8.c:456: printf("\rNumbers entered not within 0-100 range\n Program Ended");
	mov	a,#__str_16
	push	acc
	mov	a,#(__str_16 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	ret
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 0x1B
	db '[2J'
	db 0x00
__str_1:
	db 0x0D
	db 'Enter 4 spaced numbers (2 for right/left motors) between 0-'
	db '100: '
	db 0x00
__str_2:
	db '%d %d %d %d'
	db 0x0A
	db 0x00
__str_3:
	db '               '
	db 0x00
__str_4:
	db 'PWM1:%d,%d'
	db 0x00
__str_5:
	db 'PWM2:%d,%d'
	db 0x00
__str_6:
	db 'Direction:'
	db 0x00
__str_7:
	db 'Backward'
	db 0x00
__str_8:
	db 'Forward'
	db 0x00
__str_9:
	db 'Forward Left'
	db 0x00
__str_10:
	db 'Forward Right'
	db 0x00
__str_11:
	db 'Stop'
	db 0x00
__str_12:
	db 'Back Left'
	db 0x00
__str_13:
	db 'Back Righ'
	db 0x00
__str_14:
	db 'Turning'
	db 0x00
__str_15:
	db '%f'
	db 0x0A
	db 0x00
__str_16:
	db 0x0D
	db 'Numbers entered not within 0-100 range'
	db 0x0A
	db ' Program Ended'
	db 0x00

	CSEG

end
