@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\nusai\Desktop\ELEC 291\Metal Detector\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\nusai\Desktop\ELEC 291\Metal Detector\Freq.c"
if not exist hex2mif.exe goto done
if exist Freq.ihx hex2mif Freq.ihx
if exist Freq.hex hex2mif Freq.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\nusai\Desktop\ELEC 291\Metal Detector\Freq.hex
