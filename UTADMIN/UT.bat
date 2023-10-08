@echo off
CLS
Title User Tool UAC
echo User Tool must be run as Admin!
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
cd /d "%~dp0"
Title User Tool
: MAIN
color 07
CLS
echo ================================================================================
echo.
echo.
echo.
echo                               User Tool Started
echo.
echo.
echo.
echo ================================================================================
echo Users on this PC:
NET USER
echo ================================================================================
echo GROUPS:
NET LOCALGROUP
echo ================================================================================
echo Who am I?
echo.
whoami
echo.
echo ================================================================================
echo Select:
echo 1 Add/Del user
echo 2 Read User Info
echo 3 Change User Password[only for account that use PASSWORD,NOT PIN]
echo 4 Add/Del someone to/in a group
echo 5 Active/Inactive a User
echo 6 Add/Del a Group
echo 7 Exit User Tool
echo 8 GUI (lusrmgr.msc)
echo ================================================================================
set /p MAINSELECT=Enter numbers:
if %MAINSELECT%==1 goto ADUSR
if %MAINSELECT%==2 goto RDUSRINFO
if %MAINSELECT%==3 goto CUSRPWD
if %MAINSELECT%==4 goto ADUSRGRP
if %MAINSELECT%==5 goto IAUSR
if %MAINSELECT%==6 goto ADGRP
if %MAINSELECT%==7 goto EXITUT
if %MAINSELECT%==8 start lusrmgr.msc
if %MAINSELECT%==China goto CHINA
goto EXIT
: EXIT
echo Press any key(like space)to go to MAIN SELECT.
pause>nul
goto MAIN
: CHINA
CLS
color 46
echo Please see the followings.
start China.ttf
goto EXIT
: ADUSR
set /p ADSELECT=Enter your choice(1=ADD,2=DEL):
if %ADSELECT%==1 goto ADAUSRUN
if %ADSELECT%==2 goto ADDUSRUN
goto EXIT
: ADAUSRUN
set /p ADAUSRUN=Enter User Name(such as Admin):
NET USER "%ADAUSRUN%" /ADD
goto EXIT
: ADDUSRUN
set /p ADDUSRUN=Enter User Name(such as Admin):
NET USER "%ADDUSRUN%" /DEL
goto EXIT
: RDUSRINFO
set /p RDUSRINFOUN=Enter User Name(such as Admin):
NET USER "%RDUSRINFOUN%"
goto EXIT
: CUSRPWD
set /p CUSRPWDUN=Enter User Name(such as Admin):
set /p CUSRPWDPWD=Enter NEW User pwaaword(DO NOT ONLY PRESS ENTER) (such as 123456):
NET USER "%CUSRPWDUN%" "%CUSRPWDPWD%"
echo User: "%CUSRPWDUN%"
echo Password: "%CUSRPWDPWD%"
goto EXIT
: ADUSRGRP
set /p ADUSRGRPUN=Enter User Name(such as Admin):
set /p ADUSRGRPGN=Enter User Name(such as Administrators):
NET LOCALGROUP "%ADUSRGRPGN%" "%ADUSRGRPUN%" /ADD
goto EXIT
: IAUSR
set /p IAUSRUN=Enter User Name(such as Admin):
set /p IAUSRCHOICE=Active or inactive?(1 / 2):
if %IAUSRCHOICE%==1 goto IAAUSR
if %IAUSRCHOICE%==2 goto IAIUSR
goto EXIT
: IAAUSR
NET USER "%IAUSRUN%" /ACTIVE:YES
goto EXIT
: IAIUSR
NET USER "%IAUSRUN%" /ACTIVE:NO
goto EXIT
: ADGRP
set /p ADGRPGN=Enter Group Name(such as NewGroup1):
set /p ADGRPCHOICE=Add or Del?(1 / 2):
if %ADGRPCHOICE%==1 goto ADAGRP
if %ADGRPCHOICE%==2 goto ADDGRP
: ADDGRP
NET LOCALGROUP "%ADGRPGN%" /DEL
goto EXIT
: ADAGRP
NET LOCALGROUP "%ADGRPGN%" /ADD
goto EXIT
: EXITUT
set /p EXITUTCHOICE=Exit User Tool, are you sure?(1 / 2)
if %EXITUTCHOICE%==1 exit
if %EXITUTCHOICE%==2 goto MAIN
goto EXITUT