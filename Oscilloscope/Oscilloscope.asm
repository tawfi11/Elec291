;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Fri Apr 03 20:32:52 2020
;--------------------------------------------------------
$name Oscilloscope
$optc51 --model-small
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
	public _Init_Comparator1_PARM_3
	public _Init_Comparator1_PARM_2
	public _main
	public _Capture_Auto
	public _Capture_Normal
	public _Init_Timer2
	public _ADC_at_Pin
	public _InitPinADC
	public _waitms
	public _Timer3us
	public _Init_Comparator1
	public _InitADC
	public __c51_external_startup
	public _ADC0_ISR
	public _CMP1_ISR
	public _toupper
	public _adc_scan
	public _capture_complete
	public _capture_rate
	public _putchar
	public _getchar
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
_capture_rate:
	ds 1
_main_j_1_83:
	ds 2
_main_prev_trigger_channel_1_83:
	ds 1
_main_prev_trigger_slope_1_83:
	ds 1
_main_prev_trigger_level_1_83:
	ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
_Init_Comparator1_PARM_2:
	ds 1
_Init_Comparator1_PARM_3:
	ds 1
	rseg	R_OSEG
	rseg	R_OSEG
_InitPinADC_PARM_2:
	ds 1
	rseg	R_OSEG
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
_capture_complete:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
_adc_scan:
	ds 2048
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
	CSEG at 0x0053
	ljmp	_ADC0_ISR
	CSEG at 0x006b
	ljmp	_CMP1_ISR
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
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'toupper'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:24: char toupper (unsigned char c)
;	-----------------------------------------
;	 function toupper
;	-----------------------------------------
_toupper:
	using	0
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:26: if((c>='a') && (c<='z'))
	cjne	r2,#0x61,L002009?
L002009?:
	jc	L002002?
	mov	a,r2
	add	a,#0xff - 0x7A
	jc	L002002?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:28: return (c-'a'+'A');
	mov	a,#0xE0
	add	a,r2
	mov	dpl,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:31: return c;
	ret
L002002?:
	mov	dpl,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'putchar'
;------------------------------------------------------------
;c                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:34: void putchar (char c)
;	-----------------------------------------
;	 function putchar
;	-----------------------------------------
_putchar:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:36: while (!TI);
L003001?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:37: TI=0;
	jbc	_TI,L003008?
	sjmp	L003001?
L003008?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:38: SBUF=c;
	mov	_SBUF,r2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getchar'
;------------------------------------------------------------
;c                         Allocated to registers 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:41: char getchar (void)
;	-----------------------------------------
;	 function getchar
;	-----------------------------------------
_getchar:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:44: while (!RI);
L004001?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:45: RI=0;
	jbc	_RI,L004008?
	sjmp	L004001?
L004008?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:46: c=SBUF;
	mov	dpl,_SBUF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:47: return c;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'CMP1_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:50: void CMP1_ISR (void) interrupt INTERRUPT_CMP1
;	-----------------------------------------
;	 function CMP1_ISR
;	-----------------------------------------
_CMP1_ISR:
	push	acc
	push	ar2
	push	ar3
	push	psw
	mov	psw,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:52: P0_0=1;
	setb	_P0_0
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:53: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:54: EIE1&=~(1<<6); // ECP1. Comparator 1 (CP1) Interrupt disable.
	anl	_EIE1,#0xBF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:56: SFRPAGE=0x30;
	mov	_SFRPAGE,#0x30
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:59: CMP1CN0&=0b_1100_1111;
	anl	_CMP1CN0,#0xCF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:62: ADC0ASA=((unsigned int)adc_scan)|0x0001;
	mov	r2,#_adc_scan
	mov	r3,#(_adc_scan >> 8)
	mov	a,#0x01
	orl	a,r2
	mov	_ADC0ASA,a
	mov	(_ADC0ASA >> 8),r3
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:63: ADC0ASCT=0b00111111;
	mov	_ADC0ASCT,#0x3F
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:65: ADC0MX = QFP32_MUX_P2_1; // First channel to scan
	mov	_ADC0MX,#0x0E
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:67: (0x1<<0); // Number of Autoscan Channels (0x0: 1 channel, 0x1: 2 channels, 0x2: 3 channels, 0x3: 4 channels)
	mov	_ADC0ASCF,#0x01
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:69: ADC0ASCF|=(1<<7); // Autoscan Enable.
	orl	_ADC0ASCF,#0x80
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:71: ADC0ASA+=0x80;// Configure the address for the second scan
	mov	a,#0x80
	add	a,_ADC0ASA
	mov	_ADC0ASA,a
	clr	a
	addc	a,(_ADC0ASA >> 8)
	mov	(_ADC0ASA >> 8),a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:73: SFRPAGE=0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:75: ADINT = 0;
	clr	_ADINT
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:76: TR2=1;
	setb	_TR2
	pop	psw
	pop	ar3
	pop	ar2
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC0_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:79: void ADC0_ISR (void) interrupt INTERRUPT_ADC0EOC
;	-----------------------------------------
;	 function ADC0_ISR
;	-----------------------------------------
_ADC0_ISR:
	push	acc
	push	psw
	mov	psw,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:81: SFRPAGE=0x30;
	mov	_SFRPAGE,#0x30
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:83: ADINT=0;
	clr	_ADINT
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:84: if((ADC0ASCF&(1<<7))==0) // Last scan?
	mov	a,_ADC0ASCF
	jb	acc.7,L006005?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:86: capture_complete=1;
	setb	_capture_complete
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:87: P0_0=0;
	clr	_P0_0
	sjmp	L006007?
L006005?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:91: if(ADC0ASA < ( (0x40*2) * (PAGES-1) ) )
	clr	c
	mov	a,_ADC0ASA
	subb	a,#0x80
	mov	a,(_ADC0ASA >> 8)
	subb	a,#0x07
	jnc	L006002?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:93: ADC0ASA+=(0x40*2); // bytes not words
	mov	a,#0x80
	add	a,_ADC0ASA
	mov	_ADC0ASA,a
	clr	a
	addc	a,(_ADC0ASA >> 8)
	mov	(_ADC0ASA >> 8),a
	sjmp	L006007?
L006002?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:97: ADC0ASCF&=~(1<<7); // Disable autoscan
	anl	_ADC0ASCF,#0x7F
L006007?:
	pop	psw
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:102: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:105: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:106: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:107: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:109: VDM0CN=0x80;       // enable VDD monitor
	mov	_VDM0CN,#0x80
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:110: RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:117: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:118: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:119: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:140: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:141: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:142: while ((CLKSEL & 0x80) == 0);
L007001?:
	mov	a,_CLKSEL
	jnb	acc.7,L007001?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:143: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:144: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:145: while ((CLKSEL & 0x80) == 0);
L007004?:
	mov	a,_CLKSEL
	jnb	acc.7,L007004?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:150: P0MDOUT |= 0x13; // Enable UART0 TX as push-pull output  WARNING: P0.0, P0.1 set as outputs
	orl	_P0MDOUT,#0x13
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:151: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)                     
	mov	_XBR0,#0x01
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:152: XBR1     = 0X00;
	mov	_XBR1,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:153: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:159: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:160: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:161: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:162: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:163: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:164: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:165: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:167: P0_0=0;
	clr	_P0_0
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:169: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:172: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:174: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:175: ADEN=0; // Disable ADC
	clr	_ADEN
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:180: (0x0 << 0) ; // Accumulate n conversions: 0x0: 1, 0x1:4, 0x2:8, 0x3:16, 0x4:32
	mov	_ADC0CN1,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:184: (0x0 << 2); // 0: ADCCLK = SYSCLK. 1: ADCCLK = HFOSC0.
	mov	_ADC0CF0,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:188: (0x01 << 0); // Conversion Tracking Time. Tadtk = ADTK / (Fsarclk)
	mov	_ADC0CF1,#0x01
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:197: (0x0 << 0) ; // TEMPE. 0: Disable the Temperature Sensor. 1: Enable the Temperature Sensor.
	mov	_ADC0CN0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:202: (0x1F << 0); // ADPWR. Power Up Delay Time. Tpwrtime = ((4 * (ADPWR + 1)) + 2) / (Fadcclk)
	mov	_ADC0CF2,#0x3F
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:206: (0x2 << 0) ; // ADCM. 0x0: ADBUSY, 0x1: TIMER0, 0x2: TIMER2, 0x3: TIMER3, 0x4: CNVSTR, 0x5: CEX5, 0x6: TIMER4, 0x7: TIMER5, 0x8: CLU0, 0x9: CLU1, 0xA: CLU2, 0xB: CLU3
	mov	_ADC0CN2,#0x02
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:208: ADEN=1; // Enable ADC
	setb	_ADEN
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:210: EIE1|=(1<<3); // ADC0 Conversion Complete Interrupt Enable
	orl	_EIE1,#0x08
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Init_Comparator1'
;------------------------------------------------------------
;edge                      Allocated with name '_Init_Comparator1_PARM_2'
;level                     Allocated with name '_Init_Comparator1_PARM_3'
;channel                   Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:213: void Init_Comparator1 (char channel, char edge, unsigned char level)
;	-----------------------------------------
;	 function Init_Comparator1
;	-----------------------------------------
_Init_Comparator1:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:215: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:216: EIE1&=~(1<<6); // ECP1. Comparator 1 (CP1) Interrupt disable.
	anl	_EIE1,#0xBF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:218: SFRPAGE = 0x30;
	mov	_SFRPAGE,#0x30
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:220: CMP1CN0=0x00; // Disable Comparator 1
	mov	_CMP1CN0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:225: (((edge=='R')?0x1:0x0)<<5) | // CPRIE. 0x0: rising edge interrupt disabled. 0x1: rising edge interrupt enabled.
	mov	a,#0x52
	cjne	a,_Init_Comparator1_PARM_2,L009003?
	mov	r3,#0x01
	sjmp	L009004?
L009003?:
	mov	r3,#0x00
L009004?:
	mov	a,r3
	swap	a
	rl	a
	anl	a,#0xe0
	mov	r3,a
	orl	ar3,#0x0C
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:226: (((edge=='F')?0x1:0x0)<<4) | // CPFIE. 0x0: falling edge interrupt disabled. 0x1: falling edge interrupt enabled.
	mov	a,#0x46
	cjne	a,_Init_Comparator1_PARM_2,L009005?
	mov	r4,#0x01
	sjmp	L009006?
L009005?:
	mov	r4,#0x00
L009006?:
	mov	a,r4
	swap	a
	anl	a,#0xf0
	mov	r4,a
	orl	a,r3
	mov	_CMP1MD,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:232: (((channel=='2')?0x4:0x3)<<0) ; // CMXP. 0x0:P0.7. 0x1:P1.0. 0x2:P2.0. 0x3:P2.1. 0x4:P2.2: 0x5:P2.3. 0x6:P2.4. 0x7:P2.5. 0x8:P2.6. 0xa:1.8. 0xb: VDD.
	cjne	r2,#0x32,L009007?
	mov	r2,#0x04
	sjmp	L009008?
L009007?:
	mov	r2,#0x03
L009008?:
	mov	a,#0xB0
	orl	a,r2
	mov	_CMP1MX,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:236: ((level & 0x3f)<<0) ; // DACLVL. DAC output = CMPREF * (DACLVL / 64)  
	mov	a,#0x3F
	anl	a,_Init_Comparator1_PARM_3
	mov	r2,a
	mov	_CMP1CN1,r2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:239: (0x1<<7); // Enable Comparator 1
	mov	_CMP1CN0,#0x80
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:241: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:245: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:250: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:252: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:253: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:255: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:256: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L010004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L010007?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:258: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L010001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L010001?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:259: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:256: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L010004?
L010007?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:261: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;k                         Allocated to registers r6 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:264: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:268: for(j=0; j<ms; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L011005?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L011009?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:269: for (k=0; k<4; k++) Timer3us(250);
	mov	r6,#0x00
L011001?:
	cjne	r6,#0x04,L011018?
L011018?:
	jnc	L011007?
	mov	dpl,#0xFA
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_Timer3us
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r6
	sjmp	L011001?
L011007?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:268: for(j=0; j<ms; j++)
	inc	r4
	cjne	r4,#0x00,L011005?
	inc	r5
	sjmp	L011005?
L011009?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitPinADC'
;------------------------------------------------------------
;pin_num                   Allocated with name '_InitPinADC_PARM_2'
;portno                    Allocated to registers r2 
;mask                      Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:272: void InitPinADC (unsigned char portno, unsigned char pin_num)
;	-----------------------------------------
;	 function InitPinADC
;	-----------------------------------------
_InitPinADC:
	mov	r2,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:276: mask=1<<pin_num;
	mov	b,_InitPinADC_PARM_2
	inc	b
	mov	a,#0x01
	sjmp	L012013?
L012011?:
	add	a,acc
L012013?:
	djnz	b,L012011?
	mov	r3,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:278: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:279: switch (portno)
	cjne	r2,#0x00,L012014?
	sjmp	L012001?
L012014?:
	cjne	r2,#0x01,L012015?
	sjmp	L012002?
L012015?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:281: case 0:
	cjne	r2,#0x02,L012005?
	sjmp	L012003?
L012001?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:282: P0MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P0MDIN,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:283: P0SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P0SKIP,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:284: break;
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:285: case 1:
	sjmp	L012005?
L012002?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:286: P1MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P1MDIN,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:287: P1SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P1SKIP,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:288: break;
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:289: case 2:
	sjmp	L012005?
L012003?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:290: P2MDIN &= (~mask); // Set pin as analog input
	mov	a,r3
	cpl	a
	mov	r2,a
	anl	_P2MDIN,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:291: P2SKIP |= mask; // Skip Crossbar decoding for this pin
	mov	a,r3
	orl	_P2SKIP,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:295: }
L012005?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:296: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:299: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:302: ADINT = 0;
	clr	_ADINT
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:303: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:304: while (!ADINT); // Wait for conversion to complete
L013001?:
	jnb	_ADINT,L013001?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:305: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Init_Timer2'
;------------------------------------------------------------
;rate                      Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:308: void Init_Timer2 (unsigned long rate)
;	-----------------------------------------
;	 function Init_Timer2
;	-----------------------------------------
_Init_Timer2:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:310: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:311: TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	mov	_TMR2CN0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:312: CKCON0|=0b_0001_0000; // Timer 2 uses the system clock
	orl	_CKCON0,#0x10
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:313: TMR2RL=(0x10000L-(SYSCLK/rate)); // Initialize reload value
	mov	__divulong_PARM_2,r2
	mov	(__divulong_PARM_2 + 1),r3
	mov	(__divulong_PARM_2 + 2),r4
	mov	(__divulong_PARM_2 + 3),r5
	mov	dptr,#0xA200
	mov	b,#0x4A
	mov	a,#0x04
	lcall	__divulong
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	clr	a
	clr	c
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
	mov	a,#0x01
	subb	a,r4
	clr	a
	subb	a,r5
	mov	_TMR2RL,r2
	mov	(_TMR2RL >> 8),r3
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:314: TMR2=0xffff;   // Set to reload immediately
	mov	_TMR2,#0xFF
	mov	(_TMR2 >> 8),#0xFF
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Capture_Normal'
;------------------------------------------------------------
;uscount                   Allocated to registers r6 r7 r0 r1 
;timeout                   Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:318: void Capture_Normal (void)
;	-----------------------------------------
;	 function Capture_Normal
;	-----------------------------------------
_Capture_Normal:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:323: switch(capture_rate)
	mov	r2,_capture_rate
	clr	c
	mov	a,r2
	xrl	a,#0x80
	subb	a,#0xb0
	jnc	L015029?
	ljmp	L015011?
L015029?:
	clr	c
	mov	a,#(0x39 ^ 0x80)
	mov	b,r2
	xrl	b,#0x80
	subb	a,b
	jnc	L015030?
	ljmp	L015011?
L015030?:
	mov	a,r2
	add	a,#0xd0
	mov	r2,a
	add	a,acc
	add	a,r2
	mov	dptr,#L015031?
	jmp	@a+dptr
L015031?:
	ljmp	L015001?
	ljmp	L015002?
	ljmp	L015003?
	ljmp	L015004?
	ljmp	L015005?
	ljmp	L015006?
	ljmp	L015007?
	ljmp	L015008?
	ljmp	L015009?
	ljmp	L015010?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:325: case '0': timeout=10000L*1L;   break;
L015001?:
	mov	r2,#0x10
	mov	r3,#0x27
	mov	r4,#0x00
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:326: case '1': timeout=10000L*2L;   break;
	sjmp	L015012?
L015002?:
	mov	r2,#0x20
	mov	r3,#0x4E
	mov	r4,#0x00
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:327: case '2': timeout=10000L*4L;   break;
	sjmp	L015012?
L015003?:
	mov	r2,#0x40
	mov	r3,#0x9C
	mov	r4,#0x00
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:328: case '3': timeout=10000L*8L;   break;
	sjmp	L015012?
L015004?:
	mov	r2,#0x80
	mov	r3,#0x38
	mov	r4,#0x01
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:329: case '4': timeout=10000L*16L;  break;
	sjmp	L015012?
L015005?:
	mov	r2,#0x00
	mov	r3,#0x71
	mov	r4,#0x02
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:330: case '5': timeout=10000L*32L;  break;
	sjmp	L015012?
L015006?:
	mov	r2,#0x00
	mov	r3,#0xE2
	mov	r4,#0x04
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:331: case '6': timeout=10000L*64L;  break;
	sjmp	L015012?
L015007?:
	mov	r2,#0x00
	mov	r3,#0xC4
	mov	r4,#0x09
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:332: case '7': timeout=10000L*128L; break;
	sjmp	L015012?
L015008?:
	mov	r2,#0x00
	mov	r3,#0x88
	mov	r4,#0x13
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:333: case '8': timeout=10000L*256L; break;
	sjmp	L015012?
L015009?:
	mov	r2,#0x00
	mov	r3,#0x10
	mov	r4,#0x27
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:334: case '9': timeout=10000L*512L; break;
	sjmp	L015012?
L015010?:
	mov	r2,#0x00
	mov	r3,#0x20
	mov	r4,#0x4E
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:335: default:  timeout=10000L*1L;   break;
	sjmp	L015012?
L015011?:
	mov	r2,#0x10
	mov	r3,#0x27
	mov	r4,#0x00
	mov	r5,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:336: }
L015012?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:338: capture_complete=0;
	clr	_capture_complete
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:339: SFRPAGE=0x30;
	mov	_SFRPAGE,#0x30
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:340: CMP1CN0&=0b_1100_1111; // Clear any pending comparator interrupts
	anl	_CMP1CN0,#0xCF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:341: SFRPAGE=0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:342: EIE1|=(1<<6); // ECP1. Comparator 1 (CP1) Interrupt Enable.
	orl	_EIE1,#0x40
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:344: CKCON0|=0b_0100_0000;// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0.
	orl	_CKCON0,#0x40
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:345: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:346: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:347: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:349: while (!capture_complete) // Wait for conversion to complete
	mov	r6,#0x00
	mov	r7,#0x00
	mov	r0,#0x00
	mov	r1,#0x00
L015018?:
	jb	_capture_complete,L015020?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:351: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L015013?:
	mov	a,_TMR3CN0
	jnb	acc.7,L015013?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:352: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:353: uscount++;
	inc	r6
	cjne	r6,#0x00,L015034?
	inc	r7
	cjne	r7,#0x00,L015034?
	inc	r0
	cjne	r0,#0x00,L015034?
	inc	r1
L015034?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:354: if(uscount==timeout) break;   // WARNING: This time must be considered carefully
	mov	a,r6
	cjne	a,ar2,L015018?
	mov	a,r7
	cjne	a,ar3,L015018?
	mov	a,r0
	cjne	a,ar4,L015018?
	mov	a,r1
	cjne	a,ar5,L015018?
L015020?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:356: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:357: TR2=0;	
	clr	_TR2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Capture_Auto'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:361: void Capture_Auto (void)
;	-----------------------------------------
;	 function Capture_Auto
;	-----------------------------------------
_Capture_Auto:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:363: Capture_Normal();
	lcall	_Capture_Normal
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:365: if(!capture_complete) // Timed out with no trigger, so in auto mode force a scan
	jb	_capture_complete,L016006?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:367: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:368: EIE1&=~(1<<6); // ECP1. Comparator 1 (CP1) Interrupt disable.
	anl	_EIE1,#0xBF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:370: SFRPAGE=0x30;
	mov	_SFRPAGE,#0x30
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:372: CMP1CN0&=0b_1100_1111;// Clear both rising and falling interrupt flags
	anl	_CMP1CN0,#0xCF
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:375: ADC0ASA=((unsigned int)adc_scan)|0x0001;
	mov	r2,#_adc_scan
	mov	r3,#(_adc_scan >> 8)
	mov	a,#0x01
	orl	a,r2
	mov	_ADC0ASA,a
	mov	(_ADC0ASA >> 8),r3
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:376: ADC0ASCT=0b00111111;
	mov	_ADC0ASCT,#0x3F
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:378: ADC0MX = QFP32_MUX_P2_1; // First channel to scan
	mov	_ADC0MX,#0x0E
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:380: (0x1<<0); // Number of Autoscan Channels (0x0: 1 channel, 0x1: 2 channels, 0x2: 3 channels, 0x3: 4 channels)
	mov	_ADC0ASCF,#0x01
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:382: ADC0ASCF|=(1<<7); // Autoscan Enable.
	orl	_ADC0ASCF,#0x80
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:384: ADC0ASA+=0x80;// Configure the address for the second scan
	mov	a,#0x80
	add	a,_ADC0ASA
	mov	_ADC0ASA,a
	clr	a
	addc	a,(_ADC0ASA >> 8)
	mov	(_ADC0ASA >> 8),a
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:386: SFRPAGE=0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:388: ADINT = 0;
	clr	_ADINT
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:389: TR2=1;
	setb	_TR2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:391: while (!capture_complete);
L016001?:
	jnb	_capture_complete,L016001?
L016006?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;j                         Allocated with name '_main_j_1_83'
;c                         Allocated to registers r5 
;trigger_channel           Allocated to registers r6 
;trigger_slope             Allocated to registers r7 
;trigger_level             Allocated to registers r0 
;prev_trigger_channel      Allocated with name '_main_prev_trigger_channel_1_83'
;prev_trigger_slope        Allocated with name '_main_prev_trigger_slope_1_83'
;prev_trigger_level        Allocated with name '_main_prev_trigger_level_1_83'
;d                         Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:395: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:402: InitPinADC(2, 1); // Configure P2.1 as analog input
	mov	_InitPinADC_PARM_2,#0x01
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:403: InitPinADC(2, 2); // Configure P2.2 as analog input
	mov	_InitPinADC_PARM_2,#0x02
	mov	dpl,#0x02
	lcall	_InitPinADC
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:404: InitADC();
	lcall	_InitADC
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:405: Init_Timer2(1000000L); // Sampling rate.  Fastest possible is 1us.
	mov	dptr,#0x4240
	mov	b,#0x0F
	clr	a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:406: capture_rate='0';
	mov	_capture_rate,#0x30
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:408: trigger_channel=prev_trigger_channel='1';
	mov	_main_prev_trigger_channel_1_83,#0x31
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:409: trigger_slope=prev_trigger_slope='F';
	mov	_main_prev_trigger_slope_1_83,#0x46
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:410: trigger_level=prev_trigger_level=0x3f/3;
	mov	_main_prev_trigger_level_1_83,#0x15
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:411: Init_Comparator1(trigger_channel, trigger_slope, trigger_level); // Trigger: Channel 1, falling edge, VDD/3
	mov	_Init_Comparator1_PARM_2,#0x46
	mov	_Init_Comparator1_PARM_3,#0x15
	mov	dpl,#0x31
	lcall	_Init_Comparator1
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:413: EA=1;
	setb	_EA
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:415: while(1)
L017038?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:417: c=toupper(getchar());
	lcall	_getchar
	lcall	_toupper
	mov	r5,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:418: if(c=='A') // Auto mode
	cjne	r5,#0x41,L017069?
	sjmp	L017070?
L017069?:
	ljmp	L017035?
L017070?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:420: trigger_channel=getchar();
	lcall	_getchar
	mov	r6,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:421: trigger_slope=toupper(getchar());
	push	ar6
	lcall	_getchar
	lcall	_toupper
	mov	r7,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:422: trigger_level=getchar();	
	push	ar7
	lcall	_getchar
	mov	r0,dpl
	pop	ar7
	pop	ar6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:424: if ( (trigger_channel!=prev_trigger_channel) || (trigger_slope!=prev_trigger_slope) || (trigger_level!=prev_trigger_level) )
	mov	a,r6
	cjne	a,_main_prev_trigger_channel_1_83,L017001?
	mov	a,r7
	cjne	a,_main_prev_trigger_slope_1_83,L017001?
	mov	a,r0
	cjne	a,_main_prev_trigger_level_1_83,L017075?
	sjmp	L017002?
L017075?:
L017001?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:426: Init_Comparator1(trigger_channel, trigger_slope, trigger_level);
	mov	_Init_Comparator1_PARM_2,r7
	mov	_Init_Comparator1_PARM_3,r0
	mov	dpl,r6
	push	ar6
	push	ar7
	push	ar0
	lcall	_Init_Comparator1
	pop	ar0
	pop	ar7
	pop	ar6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:427: prev_trigger_channel=trigger_channel;
	mov	_main_prev_trigger_channel_1_83,r6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:428: prev_trigger_slope=trigger_slope;
	mov	_main_prev_trigger_slope_1_83,r7
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:429: prev_trigger_level=trigger_level;
	mov	_main_prev_trigger_level_1_83,r0
L017002?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:431: Capture_Auto();
	lcall	_Capture_Auto
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:433: SFRPAGE=0x20;   // UART0, CRC, and SPI can work on this page
	mov	_SFRPAGE,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:434: CRC0CN0=0b_0000_1000; // Initialize hardware CRC result to zero;
	mov	_CRC0CN0,#0x08
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:435: for(j=0; j<(0x40*PAGES); j+=2)
	clr	a
	mov	_main_j_1_83,a
	mov	(_main_j_1_83 + 1),a
L017040?:
	mov	a,#0x100 - 0x04
	add	a,(_main_j_1_83 + 1)
	jc	L017043?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:437: d=adc_scan[j+0]>>2;
	mov	a,_main_j_1_83
	add	a,_main_j_1_83
	mov	r3,a
	mov	a,(_main_j_1_83 + 1)
	rlc	a
	mov	r2,a
	mov	a,r3
	add	a,#_adc_scan
	mov	dpl,a
	mov	a,r2
	addc	a,#(_adc_scan >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r2,a
	inc	dptr
	movx	a,@dptr
	clr	c
	rrc	a
	xch	a,r2
	rrc	a
	xch	a,r2
	clr	c
	rrc	a
	xch	a,r2
	rrc	a
	xch	a,r2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:438: putchar(d);
	mov	dpl,r2
	push	ar2
	lcall	_putchar
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:439: CRC0IN=d;// Feed new byte to hardware CRC calculator
	mov	_CRC0IN,r2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:440: d=adc_scan[j+1]>>2;
	mov	a,#0x01
	add	a,_main_j_1_83
	mov	r3,a
	clr	a
	addc	a,(_main_j_1_83 + 1)
	xch	a,r3
	add	a,acc
	xch	a,r3
	rlc	a
	mov	r4,a
	mov	a,r3
	add	a,#_adc_scan
	mov	dpl,a
	mov	a,r4
	addc	a,#(_adc_scan >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r3,a
	inc	dptr
	movx	a,@dptr
	clr	c
	rrc	a
	xch	a,r3
	rrc	a
	xch	a,r3
	clr	c
	rrc	a
	xch	a,r3
	rrc	a
	xch	a,r3
	mov	ar2,r3
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:441: putchar(d);
	mov	dpl,r2
	push	ar2
	lcall	_putchar
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:442: CRC0IN=d;// Feed new byte to hardware CRC calculator
	mov	_CRC0IN,r2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:435: for(j=0; j<(0x40*PAGES); j+=2)
	mov	a,#0x02
	add	a,_main_j_1_83
	mov	_main_j_1_83,a
	clr	a
	addc	a,(_main_j_1_83 + 1)
	mov	(_main_j_1_83 + 1),a
	sjmp	L017040?
L017043?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:444: CRC0CN0=0x01; // Set bit to read hardware CRC high byte
	mov	_CRC0CN0,#0x01
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:445: putchar(CRC0DAT);
	mov	dpl,_CRC0DAT
	lcall	_putchar
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:446: CRC0CN0=0x00; // Clear bit to read hardware CRC low byte
	mov	_CRC0CN0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:447: putchar(CRC0DAT);
	mov	dpl,_CRC0DAT
	lcall	_putchar
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:448: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ljmp	L017038?
L017035?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:450: else if (c=='N') // Normal mode
	cjne	r5,#0x4E,L017077?
	sjmp	L017078?
L017077?:
	ljmp	L017032?
L017078?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:452: trigger_channel=getchar();
	lcall	_getchar
	mov	r6,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:453: trigger_slope=toupper(getchar());
	push	ar6
	lcall	_getchar
	lcall	_toupper
	mov	r7,dpl
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:454: trigger_level=getchar();	
	push	ar7
	lcall	_getchar
	mov	r0,dpl
	pop	ar7
	pop	ar6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:456: if ( (trigger_channel!=prev_trigger_channel) || (trigger_slope!=prev_trigger_slope) || (trigger_level!=prev_trigger_level) )
	mov	a,r6
	cjne	a,_main_prev_trigger_channel_1_83,L017005?
	mov	a,r7
	cjne	a,_main_prev_trigger_slope_1_83,L017005?
	mov	a,r0
	cjne	a,_main_prev_trigger_level_1_83,L017083?
	sjmp	L017006?
L017083?:
L017005?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:458: Init_Comparator1(trigger_channel, trigger_slope, trigger_level);
	mov	_Init_Comparator1_PARM_2,r7
	mov	_Init_Comparator1_PARM_3,r0
	mov	dpl,r6
	push	ar6
	push	ar7
	push	ar0
	lcall	_Init_Comparator1
	pop	ar0
	pop	ar7
	pop	ar6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:459: prev_trigger_channel=trigger_channel;
	mov	_main_prev_trigger_channel_1_83,r6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:460: prev_trigger_slope=trigger_slope;
	mov	_main_prev_trigger_slope_1_83,r7
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:461: prev_trigger_level=trigger_level;
	mov	_main_prev_trigger_level_1_83,r0
L017006?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:463: Capture_Normal();
	lcall	_Capture_Normal
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:465: SFRPAGE=0x20;   // UART0, CRC, and SPI can work on this page
	mov	_SFRPAGE,#0x20
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:466: CRC0CN0=0b_0000_1000; // Initialize hardware CRC result to zero;
	mov	_CRC0CN0,#0x08
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:467: for(j=0; j<(0x40*PAGES); j+=2)
	mov	r3,#0x00
	mov	r4,#0x00
L017044?:
	mov	a,#0x100 - 0x04
	add	a,r4
	jc	L017047?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:469: d=adc_scan[j+0]>>2;
	mov	ar6,r3
	mov	a,r4
	xch	a,r6
	add	a,acc
	xch	a,r6
	rlc	a
	mov	r7,a
	mov	a,r6
	add	a,#_adc_scan
	mov	dpl,a
	mov	a,r7
	addc	a,#(_adc_scan >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	clr	c
	rrc	a
	xch	a,r6
	rrc	a
	xch	a,r6
	clr	c
	rrc	a
	xch	a,r6
	rrc	a
	xch	a,r6
	mov	ar2,r6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:470: putchar(d);
	mov	dpl,r2
	push	ar2
	push	ar3
	push	ar4
	lcall	_putchar
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:471: CRC0IN=d;// Feed new byte to hardware CRC calculator
	mov	_CRC0IN,r2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:472: d=adc_scan[j+1]>>2;
	mov	a,#0x01
	add	a,r3
	mov	r6,a
	clr	a
	addc	a,r4
	xch	a,r6
	add	a,acc
	xch	a,r6
	rlc	a
	mov	r7,a
	mov	a,r6
	add	a,#_adc_scan
	mov	dpl,a
	mov	a,r7
	addc	a,#(_adc_scan >> 8)
	mov	dph,a
	movx	a,@dptr
	mov	r6,a
	inc	dptr
	movx	a,@dptr
	clr	c
	rrc	a
	xch	a,r6
	rrc	a
	xch	a,r6
	clr	c
	rrc	a
	xch	a,r6
	rrc	a
	xch	a,r6
	mov	ar2,r6
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:473: putchar(d);
	mov	dpl,r2
	push	ar2
	push	ar3
	push	ar4
	lcall	_putchar
	pop	ar4
	pop	ar3
	pop	ar2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:474: CRC0IN=d;// Feed new byte to hardware CRC calculator
	mov	_CRC0IN,r2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:467: for(j=0; j<(0x40*PAGES); j+=2)
	mov	a,#0x02
	add	a,r3
	mov	r3,a
	clr	a
	addc	a,r4
	mov	r4,a
	ljmp	L017044?
L017047?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:477: if(capture_complete)
	jnb	_capture_complete,L017010?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:479: CRC0CN0=0x01; // Set bit to read hardware CRC high byte
	mov	_CRC0CN0,#0x01
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:480: putchar(CRC0DAT);
	mov	dpl,_CRC0DAT
	lcall	_putchar
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:481: CRC0CN0=0x00; // Clear bit to read hardware CRC low byte
	mov	_CRC0CN0,#0x00
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:482: putchar(CRC0DAT);
	mov	dpl,_CRC0DAT
	lcall	_putchar
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:483: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
	ljmp	L017038?
L017010?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:487: putchar(0x00);
	mov	dpl,#0x00
	lcall	_putchar
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:488: putchar(0x00);
	mov	dpl,#0x00
	lcall	_putchar
	ljmp	L017038?
L017032?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:491: else if (c=='I') // Identify command
	cjne	r5,#0x49,L017029?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:493: putchar('S'); // That is it!
	mov	dpl,#0x53
	lcall	_putchar
	ljmp	L017038?
L017029?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:495: else if (c=='R') // Capture rate command
	cjne	r5,#0x52,L017088?
	sjmp	L017089?
L017088?:
	ljmp	L017038?
L017089?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:497: c=toupper(getchar());
	lcall	_getchar
	lcall	_toupper
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:498: if(c!=capture_rate)
	mov	a,dpl
	mov	r5,a
	cjne	a,_capture_rate,L017090?
	ljmp	L017038?
L017090?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:500: capture_rate=c;
	mov	_capture_rate,r5
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:501: switch(capture_rate)
	mov	r2,_capture_rate
	clr	c
	mov	a,r2
	xrl	a,#0x80
	subb	a,#0xb0
	jnc	L017091?
	ljmp	L017038?
L017091?:
	clr	c
	mov	a,#(0x39 ^ 0x80)
	mov	b,r2
	xrl	b,#0x80
	subb	a,b
	jnc	L017092?
	ljmp	L017038?
L017092?:
	mov	a,r2
	add	a,#0xd0
	mov	r2,a
	add	a,acc
	add	a,r2
	mov	dptr,#L017093?
	jmp	@a+dptr
L017093?:
	ljmp	L017012?
	ljmp	L017013?
	ljmp	L017014?
	ljmp	L017015?
	ljmp	L017016?
	ljmp	L017017?
	ljmp	L017018?
	ljmp	L017019?
	ljmp	L017020?
	ljmp	L017021?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:503: case '0':
L017012?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:504: Init_Timer2(1000000L); // Sampling rate.  Fastest possible is 1us.
	mov	dptr,#0x4240
	mov	b,#0x0F
	clr	a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:505: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:506: case '1':
L017013?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:507: Init_Timer2(1000000L/2L);
	mov	dptr,#0xA120
	mov	b,#0x07
	clr	a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:508: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:509: case '2':
L017014?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:510: Init_Timer2(1000000L/4L);
	mov	dptr,#0xD090
	mov	b,#0x03
	clr	a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:511: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:512: case '3':
L017015?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:513: Init_Timer2(1000000L/8L);
	mov	dptr,#0xE848
	mov	b,#0x01
	clr	a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:514: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:515: case '4':
L017016?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:516: Init_Timer2(1000000L/16L);
	mov	dptr,#0xF424
	clr	a
	mov	b,a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:517: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:518: case '5':
L017017?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:519: Init_Timer2(1000000L/32L);
	mov	dptr,#0x7A12
	clr	a
	mov	b,a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:520: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:521: case '6':
L017018?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:522: Init_Timer2(1000000L/64L);
	mov	dptr,#0x3D09
	clr	a
	mov	b,a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:523: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:524: case '7':
L017019?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:525: Init_Timer2(1000000L/128L);
	mov	dptr,#0x1E84
	clr	a
	mov	b,a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:526: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:527: case '8':
L017020?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:528: Init_Timer2(1000000L/256L);
	mov	dptr,#0x0F42
	clr	a
	mov	b,a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:529: break;
	ljmp	L017038?
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:530: case '9':
L017021?:
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:531: Init_Timer2(1000000L/512L);
	mov	dptr,#0x07A1
	clr	a
	mov	b,a
	lcall	_Init_Timer2
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:532: break;
;	C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c:535: }
	ljmp	L017038?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST

	CSEG

end
