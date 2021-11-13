#!/usr/bin/python
#
# Oscilloscope GUI: This script uses reads the data captured by an
# EFM8LB1 microcontroller and displays is using a plot like oscilloscopes do.
#
# V1.0 (c) Jesus Calvino-Fraga 2020
# jesusc@ece.ubc.ca
#
import time, serial, serial.tools.list_ports
import matplotlib
import matplotlib.pyplot as plt
import tkinter as Tkinter
from tkinter import *
from tkinter import messagebox as tkMessageBox
import numpy as np
matplotlib.use('TkAgg')

import matplotlib.backends.backend_tkagg as tkagg
try:
    from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2TkAgg # NavigationToolbar2TkAgg is deprecated in newer versions of matplotlib
except:
    from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2Tk
    
# implement the default mpl key bindings
from matplotlib.backend_bases import key_press_handler
from matplotlib.figure import Figure
from os import path, access, R_OK, W_OK

#------------------------------------------------------------------------------------------   
def Just_Exit():
    if tkMessageBox.askyesno("Exit", "Do you want to exit the program?"):
        top.quit()
        top.destroy()
        try:
            ser.close()
        except:
            dummy=0

#------------------------------------------------------------------------------------------   
def Run_Stop_Callback():
    global Run_Stop_Var, Run_Stop_Button
    
    if Run_Stop_Var.get()=='Run':
        Run_Stop_Button.configure(bg = "red")
        Run_Stop_Var.set('Stop')
    else:
        Run_Stop_Button.configure(bg = "green")
        Run_Stop_Var.set('Run')
    
#------------------------------------------------------------------------------------------   
def crc16_ccitt(crc, data):
    msb = crc >> 8
    lsb = crc & 255
    for c in data:
        x = c ^ msb
        x ^= (x >> 4)
        msb = (lsb ^ (x >> 3) ^ (x << 4)) & 255
        lsb = (x ^ (x << 5)) & 255
    return (msb << 8) + lsb


#------------------------------------------------------------------------------------------   
def onclick(event):
    global V_Trigger, line_trigger
    global sampling_frequency
    global Click_var
    global cursor1_x, cursor1_y, line_cursor1_x, line_cursor1_y
    global cursor2_x, cursor2_y, line_cursor2_x, line_cursor2_y
    global Label1_val, Label2_val, Label3_val, Label5_val

    try:
        #print('%s click: button=%d, x=%d, y=%d, xdata=%f, ydata=%f' %
        #      ('double' if event.dblclick else 'single', event.button,
        #       event.x, event.y, event.xdata, event.ydata)) # for testing
        if Click_var.get()=='V trigg':
            V_Trigger=event.ydata
            line_trigger.set_data([0, Top_X/sampling_frequency], [V_Trigger, V_Trigger])           
        elif Click_var.get()=='Cursor 1':
            cursor1_x=event.xdata
            cursor1_y=event.ydata
            line_cursor1_x.set_data([event.xdata, event.xdata], [-0.2, 3.5])
            line_cursor1_y.set_data([0.0, Top_X/sampling_frequency], [event.ydata, event.ydata])
            Label1_val.set('dV=' + str(round(cursor2_y - cursor1_y, 2)) + 'V')
            Label2_val.set('dt=' + str(round(cursor2_x - cursor1_x, 2)) + 'ms')
            if abs(cursor2_x - cursor1_x)>0:
                Label3_val.set('f=' + str(round(1.0e3/abs(cursor2_x - cursor1_x), 2)) + 'Hz')
            else:
                Label3_val.set('f=???')
        elif Click_var.get()=='Cursor 2':
            cursor2_x=event.xdata
            cursor2_y=event.ydata
            line_cursor2_x.set_data([event.xdata, event.xdata], [-0.2, 3.5])
            line_cursor2_y.set_data([0.0, Top_X/sampling_frequency], [event.ydata, event.ydata])
            Label1_val.set('dV=' + str(round(cursor2_y - cursor1_y, 2)) + 'V')
            Label2_val.set('dt=' + str(round(cursor2_x - cursor1_x, 2)) + 'ms')
            if abs(cursor2_x - cursor1_x)>0:
                Label3_val.set('f=' + str(round(1.0e3/abs(cursor2_x - cursor1_x), 2)) + 'Hz')
            else:
                Label3_val.set('f=???')
    except:
        #Label5_val.set('onclick() exception')
        #print('onclick() exception')
        return

#------------------------------------------------------------------------------------------   
def Init_GUI():
    global top, sec, line_ch1, line_ch2, line_trigger, canvas
    global ax, screen_msg
    global Mode_var, Channel_var, Edge_var, Rate_var, Click_var
    global V_Trigger
    global ch1, ch2
    global cursor1_x, cursor1_y, line_cursor1_x, line_cursor1_y
    global cursor2_x, cursor2_y, line_cursor2_x, line_cursor2_y
    global Label1_val, Label2_val, Label3_val, Label4_val, Label5_val
    global sampling_frequency, Num_Samples, Top_X, Ref_Voltage
    global Run_Stop_Var
    global CH1_on, CH2_on, Cursor1_on, Cursor2_on, Freq_on, Vtrig_on
    global Run_Stop_Button

    top = Tk()
    top.resizable(0,0)
    top.title("ELEC291/292 EFM8LB1 Oscilloscope by Jesus Calvino-Fraga")

    f = Figure(figsize=(6, 4), dpi=120)
    ax = f.add_subplot(111)

    line_ch1, = ax.plot([], [], 'y-', linewidth=2)
    line_ch2, = ax.plot([], [], 'b-', linewidth=2)
    line_trigger, = ax.plot([], [], 'c:', linewidth=1)
    ax.set_ylabel('volts')
    ax.set_xlabel('t (ms)')
   
    # Configure the cursors
    cursor1_x=0.25
    cursor1_y=1.3
    cursor2_x=0.35
    cursor2_y=2.3
    line_cursor1_x, =  ax.plot([cursor1_x, cursor1_x], [-0.2, 3.5], 'r--', linewidth=1)
    line_cursor1_y, =  ax.plot([0.0, Top_X/sampling_frequency], [cursor1_y, cursor1_y], 'r--', linewidth=1)
    line_cursor2_x, =  ax.plot([cursor2_x, cursor2_x], [-0.2, 3.5], 'g--', linewidth=1)
    line_cursor2_y, =  ax.plot([0.0, Top_X/sampling_frequency], [cursor2_y, cursor2_y], 'g--', linewidth=1)

    screen_msg=ax.text(50/sampling_frequency, Ref_Voltage+0.05, "???", fontsize=10)
    ax.set_xlim(0, Top_X/sampling_frequency)
    ax.set_ylim(-0.2, Ref_Voltage+0.2)
    x = np.arange(0, Num_Samples, 1)
    x = x / sampling_frequency
    ch1=x*0+0.5;
    ch2=x*0+1.0;
    line_ch1.set_data(x, ch1)
    line_ch2.set_data(x, ch2)
    V_Trigger=Ref_Voltage/2.0
    line_trigger.set_data([0, Top_X/sampling_frequency], [V_Trigger, V_Trigger])

    ax.grid()
    ax.set_xticks(np.arange(0, Top_X/sampling_frequency, 50/sampling_frequency))
    ax.set_yticks(np.arange(0, Ref_Voltage, 0.5))
    
    canvas = FigureCanvasTkAgg(f, master=top)
    cid = canvas.mpl_connect('button_press_event', onclick)
    canvas.draw()
    canvas.get_tk_widget().grid(row=2, column=0, columnspan=6, rowspan=9)

    # https://stackoverflow.com/questions/12913854/displaying-matplotlib-navigation-toolbar-in-tkinter-via-grid
    toolbarFrame = Frame(master=top)
    toolbarFrame.grid(row=0, column=0, columnspan=4, sticky=W)
    try:
        toolbar = NavigationToolbar2TkAgg(canvas, toolbarFrame) # deprecated in newer versions of matplotlib
    except:
        toolbar = NavigationToolbar2Tk(canvas, toolbarFrame)

    Label1_val = StringVar()
    Label1=Label(top, textvariable=Label1_val)
    Label1.grid(row = 1, column = 0)
    Label1_val.set('dV=' + str(round(cursor2_y - cursor1_y, 2)) + 'V')
   
    Label2_val = StringVar()
    Label2=Label(top, textvariable=Label2_val)
    Label2.grid(row = 1, column = 1)
    Label2_val.set('dt=' + str(round(cursor2_x - cursor1_x, 2)) + 'ms')

    Label3_val = StringVar()
    Label3=Label(top, textvariable=Label3_val)
    Label3.grid(row = 1, column = 2)
    if abs(cursor2_x - cursor1_x)>0:
        Label3_val.set('f=' + str(round(1.0e3/abs(cursor2_x - cursor1_x), 2)) + 'Hz')
    else:
        Label3_val.set('f=???')

    Label4_val = StringVar()
    Label4=Label(top, textvariable=Label4_val)
    Label4.grid(row = 1, column = 5)
    Label4_val.set('Using COM?')

    # This one is used for messages
    Label5_val = StringVar()
    Label5=Label(top, textvariable=Label5_val)
    Label5.grid(row = 1, column = 3, columnspan=2, sticky=W)
    Label5_val.set('')

    Mode_var = StringVar()
    Mode_var.set('Auto')
    popupMenu1 = OptionMenu(top, Mode_var, 'Auto', 'Normal')
    Label(top, text="Mode").grid(row = 15, column = 0)
    popupMenu1.config(width=7)
    popupMenu1.grid(row = 16, column=0)

    Channel_var = StringVar()
    Channel_var.set('CH1')
    popupMenu2 = OptionMenu(top, Channel_var, 'CH1', 'CH2')
    Label(top, text="Channel").grid(row = 15, column = 1)
    popupMenu2.config(width=7)
    popupMenu2.grid(row = 16, column=1)

    Edge_var = StringVar()
    Edge_var.set('Rising')
    popupMenu3 = OptionMenu(top, Edge_var, 'Rising', 'Falling')
    Label(top, text="Edge").grid(row = 15, column = 2)
    popupMenu3.config(width=7)
    popupMenu3.grid(row = 16, column=2)

    Rate_var = StringVar()
    Rate_var.set('500')
    popupMenu4 = OptionMenu(top, Rate_var, '500', '250', '125', '62.5', '31.25', '15.63', '7.81', '3.9')
    Label(top, text="Capture Rate (kHz)").grid(row = 15, column = 3)
    popupMenu4.config(width=7)
    popupMenu4.grid(row = 16, column=3)

    Click_var = StringVar()
    Click_var.set('Nothing!')
    popupMenu5 = OptionMenu(top, Click_var, 'V trigg', 'Cursor 1', 'Cursor 2', 'Nothing!')
    Label(top, text="Click on plot sets").grid(row = 15, column = 4)
    popupMenu5.config(width=7)
    popupMenu5.grid(row = 16, column=4)

    Run_Stop_Var= StringVar()
    Run_Stop_Var.set('Stop')
    Run_Stop_Button=Button(top, textvariable=Run_Stop_Var, width=7, bg='red',  command = Run_Stop_Callback)
    Run_Stop_Button.grid(row=0, column=5)
    
    CH1_on = BooleanVar()
    Checkbutton(top, text="CH1", variable=CH1_on).grid(row=3, column=6, sticky=W)
    CH1_on.set(True)
    
    CH2_on = BooleanVar()
    Checkbutton(top, text="CH2", variable=CH2_on).grid(row=4, column=6, sticky=W)
    CH2_on.set(True)
    
    Cursor1_on = BooleanVar()
    Checkbutton(top, text="Cursor 1", variable=Cursor1_on).grid(row=5, column=6, sticky=W)
    Cursor1_on.set(True)
    
    Cursor2_on = BooleanVar()
    Checkbutton(top, text="Cursor 2", variable=Cursor2_on).grid(row=6, column=6, sticky=W)
    Cursor2_on.set(True)
    
    Freq_on = BooleanVar()
    Checkbutton(top, text="Freq", variable=Freq_on).grid(row=7, column=6, sticky=W)
    Freq_on.set(True)
    
    Vtrig_on = BooleanVar()
    Checkbutton(top, text="V Trigg", variable=Vtrig_on).grid(row=8, column=6, sticky=W)
    Vtrig_on.set(True)

    Button(top, width=7, text = "Exit",  command = Just_Exit).grid(row=16, column=5, sticky=W)
    top.protocol('WM_DELETE_WINDOW', Just_Exit)

    top.update()

# ------------------------------------------------------------------------------------------------------------
def Init_Globals():
    global sampling_frequency, Num_Samples, Top_X, Ref_Voltage
    sampling_frequency=1
    Num_Samples = int((64 * 16)/2)
    Top_X = Num_Samples - 1
    Ref_Voltage = 3.3
    
# ------------------------------------------------------------------------------------------------------------
def Init_Serial_Port():
    global ser, Label4_val, Label5_val
    
    try:
        ser.close()
    except:
        dummy=0

    portlist=list(serial.tools.list_ports.comports())
    #for item in reversed(portlist): # For USB ports may be faster to go in reverse order
    for item in portlist:
        Label5_val.set("Trying " + item[0])
        # print("Trying " + item[0])
        top.update()
        try:
            ser = serial.Serial(port=item[0], baudrate=115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_TWO, bytesize=serial.EIGHTBITS, timeout=0.5)
            ser.write(b'I') # ID command.  Response from the microcontroller should be 'S'
            instr = ser.read(1)
            pstring = instr.decode()
            if len(pstring) == 1:
                if pstring[0]=='S':
                    break
                else:
                    ser.close()
            else:
                ser.close()
        except:
            Label5_val.set(item[0] + "Not accesible")
            #print(item[0] + "Not accesible")

    try:
        #print("Connected to " + item[0])
        Label5_val.set("")
        Label4_val.set('Using ' + item[0])
        ser.isOpen()
        ser.reset_output_buffer()
        ser.reset_input_buffer()
    except:
        tkMessageBox.showwarning(
            "Connection",
            "Can not connect to EFM8LB1 board running \"oscilloscope\""
        )
        top.quit()
        top.destroy()

#------------------------------------------------------------------------------------------   
def Refresh_Plot():
    global sampling_frequency, Num_Samples
    global Run_Stop_Var
    global CH1_on, CH2_on, Cursor1_on, Cursor2_on, Freq_on, Vtrig_on

    try:
        ser.reset_input_buffer()
    except:
        return

    line_ch1.set_visible(CH1_on.get())
    line_ch2.set_visible(CH2_on.get())
    line_trigger.set_visible(Vtrig_on.get())
    line_cursor1_x.set_visible(Cursor1_on.get())
    line_cursor1_y.set_visible(Cursor1_on.get())
    line_cursor2_x.set_visible(Cursor2_on.get())
    line_cursor2_y.set_visible(Cursor2_on.get())
    screen_msg.set_visible(Freq_on.get())

    if Run_Stop_Var.get()=='Run':
        canvas.draw()
        top.after(100, Refresh_Plot)
        return
    
    Str_Rate=Rate_var.get()
    if(sampling_frequency!=float(Str_Rate)):
        sampling_frequency=float(Str_Rate)
        if Str_Rate=='500':
            ser.write('R0'.encode('UTF8'))
            ser.timeout=0.2   
        elif Str_Rate=='250':
            ser.write('R1'.encode('UTF8'))
            ser.timeout=0.2*2
        elif Str_Rate=='125':
            ser.write('R2'.encode('UTF8'))
            ser.timeout=0.2*4
        elif Str_Rate=='62.5':
            ser.write('R3'.encode('UTF8'))
            ser.timeout=0.2*8
        elif Str_Rate=='31.25':
            ser.write('R4'.encode('UTF8'))
            ser.timeout=0.2*16
        elif Str_Rate=='15.63':
            ser.write('R5'.encode('UTF8'))
            ser.timeout=0.2*32
        elif Str_Rate=='7.81':
            ser.write('R6'.encode('UTF8'))
            ser.timeout=0.2*64
        elif Str_Rate=='3.9':
            ser.write('R7'.encode('UTF8'))
            ser.timeout=0.2*128

        ax.set_xlim(0, Top_X/sampling_frequency)
        ax.set_xticks(np.arange(0, Top_X/sampling_frequency, 50/sampling_frequency))
        screen_msg.set_position([(50/sampling_frequency), Ref_Voltage+0.05])
        x = np.arange(0, Num_Samples, 1)
        x = x / sampling_frequency
        line_ch1.set_xdata(x)
        line_ch2.set_xdata(x)
        line_trigger.set_data([0, Top_X/sampling_frequency], [V_Trigger, V_Trigger])           
    
    str1=Mode_var.get()
    str2=Channel_var.get()
    str3=Edge_var.get()

    try:
        s="%c%c%c%c" % (str1[0], str2[2], str3[0], int(V_Trigger*(0x3f/Ref_Voltage)))
    
        #ser.write('N1R\x15'.encode('UTF8')) # for testing
        ser.write(s.encode('UTF8'))
        strin = ser.read(int(Num_Samples*2)+2)

        if(len(strin)==(int(Num_Samples*2)+2)):
            for x in range(0, int(Num_Samples*2), 2):
                ch1[int(x/2)]=int(strin[int(x)])*Ref_Voltage/255;
                ch2[int(x/2)]=int(strin[int(x)+1])*Ref_Voltage/255;

            freq=0;
            if str2[2]=='1':
                for x in range(6, int(Num_Samples)-5, 1):
                    if str3[0]=='R':
                        if (ch1[0]>=ch1[int(x)]) and (ch1[0]<=ch1[int(x)+5]):
                            freq=(float(Str_Rate)*1e3/(x+5))
                            break
                    else:
                        if (ch1[0]<=ch1[int(x)]) and (ch1[0]>=ch1[int(x)+5]):
                            freq=(float(Str_Rate)*1e3/(x+5))
                            break

            if str2[2]=='2':
                for x in range(6, int(Num_Samples)-5, 1):
                    if str3[0]=='R':
                        if (ch2[0]>=ch2[int(x)]) and (ch2[0]<=ch2[int(x)+5]):
                            freq=(float(Str_Rate)*1e3/(x+5))
                            break
                    else:
                        if (ch2[0]<=ch2[int(x)]) and (ch2[0]>=ch2[int(x)+5]):
                            freq=(float(Str_Rate)*1e3/(x+5))
                            break

            crc=crc16_ccitt(0, strin)
            if (crc!=0):
                screen_msg.set_text("No Trigger")
            else:
                if (freq!=0):
                    screen_msg.set_text("freq=%.2fHz" % freq)
                else:
                    screen_msg.set_text("freq=???")
                line_ch1.set_ydata(ch1)
                line_ch2.set_ydata(ch2)
            canvas.draw()
        else:
            Label5_val.set("Wrong data size in Refresh_Plot()")
    except:
        Label5_val.set("Exception in Refresh_Plot()")
    top.after(100, Refresh_Plot)
    
#------------------------------------------------------------------------------------------   
def main():
    Init_Globals()
    Init_GUI()
    Init_Serial_Port()
    top.after(100, Refresh_Plot)
    top.mainloop()

#------------------------------------------------------------------------------------------   
if __name__ == "__main__":
    main()        


