@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\nusai\Desktop\ELEC 291\Oscilloscope\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.c"
if not exist hex2mif.exe goto done
if exist Oscilloscope.ihx hex2mif Oscilloscope.ihx
if exist Oscilloscope.hex hex2mif Oscilloscope.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\nusai\Desktop\ELEC 291\Oscilloscope\Oscilloscope.hex
