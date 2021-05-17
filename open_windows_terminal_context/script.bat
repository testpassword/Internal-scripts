(
    Echo Windows Registry Editor Version 5.00
    Echo ""
    Echo [HKEY_CLASSES_ROOT\Directory\Background\shell\wt]
    Echo @="Open Windows Terminal here"
    Echo "Icon"="C:\\Users\\%username%\\AppData\\Local\\WTerminal\\terminal.ico"
    Echo ""
    Echo [HKEY_CLASSES_ROOT\Directory\Background\shell\wt\command]
    Echo @="C:\\Users\\%username%\\AppData\\Local\\Microsoft\\WindowsApps\\wt.exe"
) > "tmp.reg"

tmp.reg
mkdir %username%/AppData/Local/WTerminal
copy terminal.ico %username%/AppData/Local/WTerminal/
del tmp.reg