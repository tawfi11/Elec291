; LCD_test_4bit.asm: Initializes and uses an LCD in 4-bit mode
; using the most common procedure found on the internet.
$NOLIST
$MODLP51
$LIST

org 0000H
    ljmp myprogram

; These 'equ' must match the hardware wiring
LCD_RS equ P1.1
LCD_RW equ P1.2 ; Not used in this code
LCD_E  equ P1.3
LCD_D4 equ P3.2
LCD_D5 equ P3.3
LCD_D6 equ P3.4
LCD_D7 equ P3.5

; When using a 22.1184MHz crystal in fast mode
; one cycle takes 1.0/22.1184MHz = 45.21123 ns

;---------------------------------;
; Wait 40 microseconds            ;
;---------------------------------;
Wait40uSec:
    push AR0
    mov R0, #177
    
;WaitHalfSec:
;	mov R2, #89
;L4: mov R1, #250
;L5: mov R0, #166
;L6: djnz R0, L6
;	djnz R1, L5
;	djnz R2, L4
;	ret
L0:
    nop
    nop
    djnz R0, L0 ; 1+1+3 cycles->5*45.21123ns*177=40us
    pop AR0
    ret

;---------------------------------;
; Wait 'R2' milliseconds          ;
;---------------------------------;
WaitmilliSec:
    push AR0
    push AR1
L3: mov R1, #45
L2: mov R0, #166
L1: djnz R0, L1 ; 3 cycles->3*45.21123ns*166=22.51519us
    djnz R1, L2 ; 22.51519us*45=1.013ms
    djnz R2, L3 ; number of millisecons to wait passed in R2
    pop AR1
    pop AR0
    ret

;---------------------------------;
; Toggles the LCD's 'E' pin       ;
;---------------------------------;
LCD_pulse:
    setb LCD_E
    lcall Wait40uSec
    clr LCD_E
    ret

;---------------------------------;
; Writes data to LCD              ;
;---------------------------------;
WriteData:
    setb LCD_RS
    ljmp LCD_byte

;---------------------------------;
; Writes command to LCD           ;
;---------------------------------;
WriteCommand:
    clr LCD_RS
    ljmp LCD_byte

;---------------------------------;
; Writes acc to LCD in 4-bit mode ;
;---------------------------------;
LCD_byte:
    ; Write high 4 bits first
    mov c, ACC.7
    mov LCD_D7, c
    mov c, ACC.6
    mov LCD_D6, c
    mov c, ACC.5
    mov LCD_D5, c
    mov c, ACC.4
    mov LCD_D4, c
    lcall LCD_pulse

    ; Write low 4 bits next
    mov c, ACC.3
    mov LCD_D7, c
    mov c, ACC.2
    mov LCD_D6, c
    mov c, ACC.1
    mov LCD_D5, c
    mov c, ACC.0
    mov LCD_D4, c
    lcall LCD_pulse
    ret

;---------------------------------;
; Configure LCD in 4-bit mode     ;
;---------------------------------;
LCD_4BIT:
    clr LCD_E   ; Resting state of LCD's enable is zero
    clr LCD_RW  ; We are only writing to the LCD in this program

    ; After power on, wait for the LCD start up time before initializing
    ; NOTE: the preprogrammed power-on delay of 16 ms on the AT89LP51RC2
    ; seems to be enough.  That is why these two lines are commented out.
    ; Also, commenting these two lines improves simulation time in Multisim.
    ; mov R2, #40
    ; lcall WaitmilliSec

    ; First make sure the LCD is in 8-bit mode and then change to 4-bit mode
    mov a, #0x33
    lcall WriteCommand
    mov a, #0x33
    lcall WriteCommand
    mov a, #0x32 ; change to 4-bit mode
    lcall WriteCommand

    ; Configure the LCD
    mov a, #0x28
    lcall WriteCommand
    mov a, #0x0c
    lcall WriteCommand
    mov a, #0x01 ;  Clear screen command (takes some time)
    lcall WriteCommand

    ;Wait for clear screen command to finish. Usually takes 1.52ms.
    mov R2, #2
    lcall WaitmilliSec
    ret

;---------------------------------;
; Main loop.  Initialize stack,   ;
; ports, LCD, and displays        ;
; letters on the LCD              ;
;---------------------------------;
myprogram:
	mov SP, #7FH
    lcall LCD_4BIT
	mov a, #0x81 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'B'
    lcall WriteData
    mov a, #0x82 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'E'
    lcall WriteData
    mov a, #0x83 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'N'
    lcall WriteData
    mov a, #0x84 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'G'
    lcall WriteData
    mov a, #0x85 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'A'
    lcall WriteData
    mov a, #0x86 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'L'
    lcall WriteData
    mov a, #0x87 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'I'
    lcall WriteData
    mov a, #0x89 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'P'
    lcall WriteData
    mov a, #0x8A ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'R'
    lcall WriteData
    mov a, #0x8B ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'I'
    lcall WriteData
    mov a, #0x8C ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'N'
    lcall WriteData
    mov a, #0x8D ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'C'
    lcall WriteData
    mov a, #0x8E ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'E'
    lcall WriteData
    
    mov a, #0xC4 ; Move cursor to line 2 column 3
    lcall WriteCommand
    mov a, #'3'
    lcall WriteData
    mov a, #0xC5 ; Move cursor to line 2 column 3
    lcall WriteCommand
    mov a, #'7'
    lcall WriteData
    mov a, #0xC6 ; Move cursor to line 2 column 3
    lcall WriteCommand
    mov a, #'3'
    lcall WriteData
    mov a, #0xC7 ; Move cursor to line 2 column 3
    lcall WriteCommand
    mov a, #'7'
    lcall WriteData
    mov a, #0xC8 ; Move cursor to line 2 column 3
    lcall WriteCommand
    mov a, #'3'
    lcall WriteData
    mov a, #0xC9 ; Move cursor to line 2 column 3
    lcall WriteCommand
    mov a, #'6'
    lcall WriteData
    mov a, #0xCA ; Move cursor to line 2 column 3
    lcall WriteCommand
    mov a, #'2'
    lcall WriteData
    mov a, #0xCB ; Move cursor to line 2 column 3
    lcall WriteCommand
    mov a, #'8'
    lcall WriteData
    
	lcall WaitHalfSec
	lcall WaitHalfSec
	lcall WaitHalfSec
	lcall WaitHalfSec
	lcall WaitHalfSec
	lcall WaitHalfSec
	
	;clear top characters
	
    mov a, #0x81 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x82 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x83 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x84 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x85 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x86 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x87 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x89 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x8A ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x8B ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x8C ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x8D ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
    mov a, #0x8E ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #' '
    lcall WriteData
	
	;clear numbers
	mov a, #0xC3 ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC4 ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC5 ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC6 ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC7 ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC8 ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC9 ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xCA ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xCB ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    mov a, #0xCC ; Move cursor to line 1 column 1
    lcall WriteCommand
    clr a
    ;lcall WaitHalfSec
    lcall WriteData
    
    lcall WaitHalfSec
    lcall WaitHalfSec
    lcall WaitHalfSec
    lcall WaitHalfSec
    
    ;write call me ;)
    mov a, #0x83 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'C'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0x84 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'A'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0x85 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'L'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0x86 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'L'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0x88 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'M'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0x89 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'E'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0x8B ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #';'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0x8C ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #')'
    lcall WaitHalfSec
    lcall WriteData
    
	;write phone number
	mov a, #0xC3 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'4'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC4 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'0'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC5 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'3'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC6 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'8'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC7 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'0'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC8 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'5'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xC9 ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'6'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xCA ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'6'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xCB ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'8'
    lcall WaitHalfSec
    lcall WriteData
    mov a, #0xCC ; Move cursor to line 1 column 1
    lcall WriteCommand
    mov a, #'9'
    lcall WaitHalfSec
    lcall WriteData
    
forever:
    sjmp forever
    
WaitHalfSec:
	mov R2, #89
L4: mov R1, #250
L5: mov R0, #166
L6: djnz R0, L6
	djnz R1, L5
	djnz R2, L4
	ret
END
