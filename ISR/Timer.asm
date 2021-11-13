; ISR_example.asm: a) Increments/decrements a BCD variable every half second using
; an ISR for timer 2; b) Generates a 2kHz square wave at pin P3.7 using
; an ISR for timer 0; and c) in the 'main' loop it displays the variable
; incremented/decremented using the ISR for timer 2 on the LCD.  Also resets it to 
; zero if the 'BOOT' pushbutton connected to P4.5 is pressed.
$NOLIST
$MODLP51
$LIST

; There is a couple of typos in MODLP51 in the definition of the timer 0/1 reload
; special function registers (SFRs), so:

TIMER0_RELOAD_L DATA 0xf2
TIMER1_RELOAD_L DATA 0xf3
TIMER0_RELOAD_H DATA 0xf4
TIMER1_RELOAD_H DATA 0xf5

CLK           EQU 22118400 ; Microcontroller system crystal frequency in Hz
TIMER0_RATE   EQU 4096     ; 2048Hz squarewave (peak amplitude of CEM-1203 speaker)
TIMER0_RELOAD EQU ((65536-(CLK/TIMER0_RATE)))
TIMER2_RATE   EQU 1000     ; 1000Hz, for a timer tick of 1ms
TIMER2_RELOAD EQU ((65536-(CLK/TIMER2_RATE)))

BOOT_BUTTON   equ P4.5
SOUND_OUT     equ P3.7
UPDOWN        equ P0.0
MIN_LOAD	  equ P0.2
HR_LOAD		  equ P0.3

; Reset vector
org 0x0000
    ljmp main

; External interrupt 0 vector (not used in this code)
org 0x0003
	reti

; Timer/Counter 0 overflow interrupt vector
org 0x000B
	ljmp Timer0_ISR

; External interrupt 1 vector (not used in this code)
org 0x0013
	reti

; Timer/Counter 1 overflow interrupt vector (not used in this code)
org 0x001B
	reti

; Serial port receive/transmit interrupt vector (not used in this code)
org 0x0023 
	reti
	
; Timer/Counter 2 overflow interrupt vector
org 0x002B
	ljmp Timer2_ISR

; In the 8051 we can define direct access variables starting at location 0x30 up to location 0x7F
dseg at 0x30
Count1ms:     ds 2 ; Used to determine when half second has passed
BCD_counter:  ds 1 ; The BCD counter incrememted in the ISR and displayed in the main loop
MIN_counter:  ds 1
HR_counter:   ds 1
MHR_counter:  ds 1
MHR_alarm:    ds 1
MIN_alarm:    ds 1

; In the 8051 we have variables that are 1-bit in size.  We can use the setb, clr, jb, and jnb
; instructions with these variables.  This is how you define a 1-bit variable:
bseg
half_seconds_flag: dbit 1 ; Set to one in the ISR every time 500 ms had passed

cseg
; These 'equ' must match the wiring between the microcontroller and the LCD!
LCD_RS equ P1.1
LCD_RW equ P1.2
LCD_E  equ P1.3
LCD_D4 equ P3.2
LCD_D5 equ P3.3
LCD_D6 equ P3.4
LCD_D7 equ P3.5
$NOLIST
$include(LCD_4bit.inc) ; A library of LCD related functions and utility macros
$LIST

;                     1234567890123456    <- This helps determine the location of the counter
Initial_Message:  db '00:00:00', 0
AM:  db 'AM', 0
PM:  db 'PM', 0
ALARM: db 'Alarm:', 0
CLOCK: db 'Clock:', 0
MHR: db '24HR:'

;---------------------------------;
; Routine to initialize the ISR   ;
; for timer 0                     ;
;---------------------------------;
Timer0_Init:
	mov a, TMOD
	anl a, #0xf0 ; Clear the bits for timer 0
	orl a, #0x01 ; Configure timer 0 as 16-timer
	mov TMOD, a
	mov TH0, #high(TIMER0_RELOAD)
	mov TL0, #low(TIMER0_RELOAD)
	; Set autoreload value
	mov TIMER0_RELOAD_H, #high(TIMER0_RELOAD)
	mov TIMER0_RELOAD_L, #low(TIMER0_RELOAD)
	; Enable the timer and interrupts
    setb ET0  ; Enable timer 0 interrupt
    setb TR0  ; Start timer 0
	ret

;---------------------------------;
; ISR for timer 0.  Set to execute;
; every 1/4096Hz to generate a    ;
; 2048 Hz square wave at pin P3.7 ;
;---------------------------------;
Timer0_ISR:
	;clr TF0  ; According to the data sheet this is done for us already.
	cpl SOUND_OUT ; Connect speaker to P3.7!
	reti

;---------------------------------;
; Routine to initialize the ISR   ;
; for timer 2                     ;
;---------------------------------;
Timer2_Init:
	mov r3, #0 ;r2 = seconds counter
	mov T2CON, #0 ; Stop timer/counter.  Autoreload mode.
	mov TH2, #high(TIMER2_RELOAD)
	mov TL2, #low(TIMER2_RELOAD)
	; Set the reload value
	mov RCAP2H, #high(TIMER2_RELOAD)
	mov RCAP2L, #low(TIMER2_RELOAD)
	; Init One millisecond interrupt counter.  It is a 16-bit variable made with two 8-bit parts
	clr a
	mov Count1ms+0, a
	mov Count1ms+1, a
	; Enable the timer and interrupts
    setb ET2  ; Enable timer 2 interrupt
    setb TR2  ; Enable timer 2
	ret

;---------------------------------;
; ISR for timer 2                 ;
;---------------------------------;
Timer2_ISR:
	clr TF2  ; Timer 2 doesn't clear TF2 automatically. Do it in ISR
	cpl P3.6 ; To check the interrupt rate with oscilloscope. It must be precisely a 1 ms pulse.
	
	; The two registers used in the ISR must be saved in the stack
	push acc
	push psw
	
	; Increment the 16-bit one mili second counter
	inc Count1ms+0    ; Increment the low 8-bits first
	mov a, Count1ms+0 ; If the low 8-bits overflow, then increment high 8-bits
	jnz Inc_Done
	inc Count1ms+1

Inc_Done:
	; Check if half second has passed
	mov a, Count1ms+0
	cjne a, #low(1000), Timer2_ISR_done ; Warning: this instruction changes the carry flag!
	mov a, Count1ms+1
	cjne a, #high(1000), Timer2_ISR_done ;it's counting 1000ms = 1s
	
	;inc r3
	; 500 milliseconds have passed.  Set a flag so the main program knows
	setb half_seconds_flag ; Let the main program know half second had passed
	cpl TR0 ; Enable/disable timer/counter 0. This line creates a beep-silence-beep-silence sound.
	; Reset to zero the milli-seconds counter, it is a 16-bit variable
	clr a
	mov Count1ms+0, a
	mov Count1ms+1, a
	; Increment the BCD counter
	mov a, BCD_counter
	jnb UPDOWN, Timer2_ISR_decrement
	add a, #0x01
	sjmp Timer2_ISR_da
Timer2_ISR_decrement:
	add a, #0x99 ; Adding the 10-complement of -1 is like subtracting 1.
Timer2_ISR_da:
	da a ; Decimal adjust instruction.  Check datasheet for more details!
	mov BCD_counter, a
	
Timer2_ISR_done:
	pop psw
	pop acc
	reti

;---------------------------------;
; Main program. Includes hardware ;
; initialization and 'forever'    ;
; loop.                           ;
;---------------------------------;
main:
	; Initialization
    mov SP, #0x7F
    lcall Timer0_Init
    lcall Timer2_Init
    ; In case you decide to use the pins of P0, configure the port in bidirectional mode:
    mov P0M0, #0
    mov P0M1, #0
    setb EA   ; Enable Global interrupts
    lcall LCD_4BIT
    ; For convenience a few handy macros are included in 'LCD_4bit.inc':
	Set_Cursor(1, 8);for initial message
    Send_Constant_String(#Initial_Message)
    Set_Cursor(2,14)
    Send_Constant_string(#AM)
    Set_Cursor(1,1)
    Send_Constant_string(#clock)
    
    setb half_seconds_flag
	mov BCD_counter, #0x00
	mov MIN_counter, #0x00
	mov HR_counter, #0x00
	mov MHR_counter, #0x00
	
	; After initialization the program stays in this 'forever' loop
loop_c:
	mov a, BCD_counter
    cjne a, #0x60, loop
 
    ;initialize minutes
    mov a, MIN_counter
    inc a
    da a
    mov MIN_counter, a
    ;Set_Cursor(1,11)
	;Display_BCD(MIN_counter)
	cjne a, #0x60, rst
	
    
    ;initialize hrs
    mov MIN_counter, #0x00
    ;Set_Cursor(1,11)
	;Display_BCD(MIN_counter)
    mov a, HR_counter
    inc a
    da a
    mov HR_counter, a
    Set_Cursor(1,8)
	Display_BCD(HR_counter)
	mov a, MHR_counter
	add a, #0x01
	da a
	mov MHR_counter, a
	mov a, HR_counter
	;switching btwn AM and PM
	cjne a, #0x12, rst
    mov a, MHR_counter
    ;switch to PM 
    cjne a, #0x24, setPM
    ljmp setAM
        
loop:
	jb BOOT_BUTTON, loop_a  ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb BOOT_BUTTON, loop_a  ; if the 'BOOT' button is not pressed skip
	jnb BOOT_BUTTON, $		; Wait for button release.  The '$' means: jump to same instruction.
	ljmp boot
	; A valid press of the 'BOOT' button has been detected, reset the BCD counter.
	; But first stop timer 2 and reset the milli-seconds counter, to resync everything.
rst:
	clr TR2                 ; Stop timer 2
	clr a
	mov Count1ms+0, a
	mov Count1ms+1, a
	; Now clear the BCD counter
	mov BCD_counter, a
	setb TR2                ; Start timer 2
	sjmp loop_b             ; Display the new value
loop_a:
	jnb half_seconds_flag,loop_c
loop_b:
    clr half_seconds_flag ; We clear this flag in the main loop, but it is set in the ISR for timer 2
	Set_Cursor(1, 14)     ; the place in the LCD where we want the BCD counter value
	Display_BCD(BCD_counter) ; This macro is also in 'LCD_4bit.inc'
	Set_Cursor(1,11)
	Display_BCD(MIN_counter)
	;Set_Cursor(1,8)
	;Display_BCD(HR_counter)
	Set_Cursor(2,8)
	Display_BCD(MHR_counter)
	ljmp loop_c


setPM:
	Set_Cursor(2,14)
    Send_Constant_string(#PM)
    mov HR_counter, #0x12
    Set_Cursor(1,8)
	Display_BCD(HR_counter)
	mov HR_counter, #0x00
	mov MHR_counter, #0x12
	ljmp rst
setAM:
	Set_Cursor(2,14)
	Send_Constant_string(#AM)
    mov HR_counter, #0x00
    Set_Cursor(1,8)
	Display_BCD(HR_counter)
	mov MHR_counter, #0x00
	mov HR_counter, #0x00 
	ljmp rst
rst1:
	ljmp rst

boot:
	;mov HR_counter, #0x00
	;mov MIN_counter, #0x00
	mov BCD_counter, #0x00
	;mov MHR_counter, #0x00
	Set_Cursor(1,14)
	Display_BCD(BCD_counter)
	;Set_Cursor(1,11)
	;Display_BCD(MIN_counter)
	;Set_Cursor(1,8)
	;Display_BCD(HR_counter)
	;Set_Cursor(2,8)
	;Display_BCD(MHR_counter)
;checkboot:
;	jb BOOT_BUTTON, boot1
;	Wait_Milli_Seconds(#50)
;	jb BOOT_BUTTON, boot1
;	ljmp setalarm
	
boot1:
	jb HR_load , boot2  ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb HR_load, boot2  ; if the 'BOOT' button is not pressed skip
	jnb HR_load, $		; Wait for button release.  The '$' means: jump to same instruction.
	mov  a, HR_counter
	add a, #0x01
	da a
	mov HR_counter, a
	Set_Cursor(1,8)
	Display_BCD(HR_counter)
	
	mov a, MHR_counter
	add a, #0x01
	da a
	mov MHR_counter, a
	Set_Cursor(2,8)
	Display_BCD(MHR_counter)
	
	mov a, HR_counter
	;switching btwn AM and PM
	cjne a, #0x12, bootHR
    mov a, MHR_counter
    ;switch to PM 
    cjne a, #0x24, setPMBOOT
    ljmp setAMBOOT

bootHR:
	jb BOOT_BUTTON, boot1  ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb BOOT_BUTTON, boot1
	jnb BOOT_BUTTON, $
	ljmp rst
;jmpcheckboot:
;	ljmp checkboot

boot2:
	jb MIN_load, boot1  ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb MIN_load, boot1  ; if the 'BOOT' button is not pressed skip
	jnb MIN_load, $		; Wait for button release.  The '$' means: jump to same instruction.
	mov  a, MIN_counter
	add a, #0x01
	da a
	mov MIN_counter, a
	Set_Cursor(1,11)
	Display_BCD(MIN_counter)
	cjne a, #0x60, bootMIN
	clr a
	mov MIN_counter, a
	Set_Cursor(1,11)
	Display_BCD(MIN_counter)
	
bootMIN:
	jb BOOT_BUTTON, boot2  ; if the 'BOOT' button is not pressed skip
	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
	jb BOOT_BUTTON, boot2
	jnb BOOT_BUTTON, $
	ljmp rst

setPMBOOT:
	Set_Cursor(2,14)
    Send_Constant_string(#PM)
    mov HR_counter, #0x12
    Set_Cursor(1,8)
	Display_BCD(HR_counter)
	mov HR_counter, #0x00
	mov MHR_counter, #0x12
	ljmp bootHR
	
setAMBOOT:
	Set_Cursor(2,14)
	Send_Constant_string(#AM)
    mov HR_counter, #0x00
    Set_Cursor(1,8)
	Display_BCD(HR_counter)
	mov MHR_counter, #0x00
	mov HR_counter, #0x00 
	ljmp bootHR
	
;setalarm:
;	mov MHR_alarm, #0x00
;	mov MIN_alarm, #0x00
;	Set_Cursor(1,8)
;	Display_BCD(MHR_alarm)
;	Set_Cursor(1,11)
;	Display_BCD(MIN_alarm)
;	Set_Cursor(1,1)
;	Send_Constant_string(#alarm)

;alarm_hr:
;	jb HR_load , alarm_min  ; if the 'BOOT' button is not pressed skip
;	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
;	jb HR_load, alarm_min  ; if the 'BOOT' button is not pressed skip
;	jnb HR_load, $		; Wait for button release.  The '$' means: jump to same instruction.
;	mov  a, MHR_alarm
;	add a, #0x01
;	da a
;	mov MHR_alarm, a
;	Set_Cursor(1,8)
;	Display_BCD(MHR_alarm)
;	jb BOOT_BUTTON, alarm_hr
;	Wait_Milli_Seconds(#50)
;	jb BOOT_BUTTON, alarm_hr
;	Set_Cursor(1,1)
;	Send_Constant_string(#clock)
;	ljmp rst

;alarm_min:
;	jb MIN_load, alarm_hr  ; if the 'BOOT' button is not pressed skip
;	Wait_Milli_Seconds(#50)	; Debounce delay.  This macro is also in 'LCD_4bit.inc'
;	jb MIN_load, alarm_hr  ; if the 'BOOT' button is not pressed skip
;	jnb MIN_load, $		; Wait for button release.  The '$' means: jump to same instruction.
;	mov  a, MIN_alarm
;	add a, #0x01
;;	da a
;	mov MIN_alarm, a
;	Set_Cursor(1,11)
;	Display_BCD(MIN_alarm)
;	jb BOOT_BUTTON, alarm_min
;	Wait_Milli_Seconds(#50)
;	jb BOOT_BUTTON, alarm_min
;	Set_Cursor(1,1)
;	Send_Constant_string(#clock)
;	ljmp rst
	
END