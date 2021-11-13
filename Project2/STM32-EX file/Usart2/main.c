#include "stm32f05xxx.h"
#include <stdio.h>
#include <stdlib.h>
#include "serial2.h"

#define SYSCLK 48000000L

int main(void)
{
	unsigned char buff[100];
	
    printf("USART 2 test.\r\n");
    printf("By Jesus Calvino-Fraga (c) 2018.\r\n");
    printf("Check PA2 and PA3 (pin 8 & 9) with the oscilloscope.\r\n");
    
    // To see the USART2 working, you'll need a second USB to serial adapter (like the BO230XS)
    // Connect STM32_TXD2 (pin 8) to BO230XS RXD
    // Connect STM32_RXD2 (pin 9) to BO230XS TXD
    // The GND of the STM32 must be connected to the GND of the BO230XS
	initUART2(9600);
    send_string2("Hello, world! From USART2.\r\n");
	while (1)
	{
	    send_string2("Type something: ");
	    get_string2(buff, sizeof(buff)-1);
	    send_string2("\r\nYou typed: ");
	    send_string2(buff);
	    send_string2("\r\n");
	}
}
