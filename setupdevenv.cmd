:: Test and Run in windows 10 only, maybe affects on build version.
:: This script is used for initial develop environment
::   1. initial %devtools% system variable which is the root folder for all non-installation develop tools, will create it if not exists yet.
::   2. download develop related tools, and unpack to %devtools%, config tools if necessary.

@echo off

setlocal EnableDelayedExpansion

bcdedit > nul
if errorlevel 1 (
    :: reset errorlevel to 0
    set _dummy=0

    call :ExitwithMsg "Run as Administrator."
)

rem Variables

set True=1
set False=0

set TempFolder=.temp

rem Showtime
call :InitDevtoolsSysVar

:: check python and use python to get the job done
call :CheckAllNecessaryToolsFor python Pip

call :CreateTempFolder

:: config develop tools... maybe use python

call :CleanTempFolder

:: exit of program
exit /b 0

rem Util functions

rem Set system devtools variable to [C:|D:]\devtools, will create this folder if not exists.
rem Variables defined in this function are global, so NO setlocal/endlocal used.
:InitDevtoolsSysVar
:: setlocal - don't use
    set devdriver=D:
    set devdriverexists=False
    :: List all drivers[B]
    for /f "skip=1 delims=" %%x in ('wmic logicaldisk where Description^="Local Fixed Disk" get caption') do (
        set "driverletter=%%x"

        :: Find devdriver exists[B]
        if /i not "!driverletter!" == "!driverletter:%devdriver%=!" (
            echo Found develop driver:
            echo(!driverletter!
            set devdriverexists=True
        )
    )

    if %devdriverexists% == False (
        set devdriver=%SystemDrive%
    )

    :: double check disk exists
    dir /w %devdriver% > nul
    if errorlevel 1 (
        call :ExitwithMsg "No D: or C: volumn found."
    )

    :: create this folder is not exists yet
    if not exist "%devdriver%\devtools\" (
        mkdir "%devdriver%\devtools\"
    )

    echo devtools variable is setup to %devdriver%\devtools

    :: setup %devtools% as root of all non-installation develop tools in system variable
    set devtools > nul
    if errorlevel 1 (
        setx devtools "%devdriver%\devtools" /m
    )

    :: setup %devtools% used in current script project
    set "devtools=%devdriver%\devtools"

    exit /b 0
:: endlocal

:CheckAllNecessaryToolsFor
setlocal
    :: Iterate all arguments[B]
    set argCount=0
    for %%x in (%*) do (
        set /a argCount += 1
        set "argVec[!argCount!]=%%~x"
    )

    echo Checking exist for %argCount% tools...

    for /L %%i in (1, 1, %argCount%) do (
        echo %%i - !argVec[%%i]!
        call :CheckToolExistsFor "!argVec[%%i]!"
    )

    exit /b 0
endlocal

:: Check necessary tools exist, if not, terminate the program. For now only one tool is allowed at a time (param : string)
:CheckToolExistsFor
setlocal
    set tool=%~1
    where %tool% > nul 2>&1
    if errorlevel 1 (
        call :ExitwithMsg "No %tool% found. Setup first(install curl and add path to PATH)"
    )
    exit /b 0
endlocal

:CreateTempFolder
setlocal
    if not exist "%devtools%\%TempFolder%" (
        mkdir "%devtools%\%TempFolder%"
    )
    exit /b 0
endlocal

:CleanTempFolder
setlocal
    if exist "%devtools%\%TempFolder%" (
        rmdir "%devtools%\%TempFolder%" /s /q
    )
    exit /b 0
endlocal

:: Terminate the program (param : string)
:ExitwithMsg
setlocal
    echo %~1
    echo.Press any key to exit command window.
    echo.
    pause
    exit 1
endlocal

:: Bibliography
:: List all drivers - https://www.thewindowsclub.com/list-drives-using-command-prompt-powershell-windows
:: Find devdriver exists - https://stackoverflow.com/questions/43472550/comparing-strings-in-batch-inside-a-for-if-statement
:: Iterate all arguments - https://stackoverflow.com/questions/19835849/batch-script-iterate-through-arguments