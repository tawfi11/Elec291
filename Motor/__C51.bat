@echo off
::This file was created automatically by CrossIDE to compile with C51.
C:
cd "\Users\nusai\Desktop\ELEC 291\Motor\"
"C:\CrossIDE\Call51\Bin\c51.exe" --use-stdout  "C:\Users\nusai\Desktop\ELEC 291\Motor\square(1).c"
if not exist hex2mif.exe goto done
if exist square(1).ihx hex2mif square(1).ihx
if exist square(1).hex hex2mif square(1).hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Users\nusai\Desktop\ELEC 291\Motor\square(1).hex
