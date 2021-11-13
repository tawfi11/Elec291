import time
import serial

import serial.tools.list_ports
import re

try:
    ser.close() # try to close the last opened port
except:
    print('')

portlist=list(serial.tools.list_ports.comports())
print ('Available serial ports (will try to open the last one):')
for item in portlist:
    print (item[0])

# configure the serial port
ser = serial.Serial(
    port='COM5',
    baudrate=115200,
    parity=serial.PARITY_NONE,
    stopbits=serial.STOPBITS_TWO,
    bytesize=serial.EIGHTBITS
)
ser.isOpen()

print ('To stop press Ctrl+C')
while 1:
    strin = ser.readline()
    strport = strin.decode()
    try:
        int(strport)
    except ValueError:
        try:    
            float(strport)
        except ValueError:
            continue
    print(strport)
        



    
