set FROM=%1
set TO=%2
set EXCLUDE=%3
if not defined EXCLUDE set EXCLUDE=""
sudo robocopy "V:\" "Y:\" /copyall /e /r:1 /XD %EXCLUDE%