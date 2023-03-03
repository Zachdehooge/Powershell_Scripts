@echo off

set /p choice="Would you like to run as current user?[y/n]: "

if "%choice%"=="y" (goto :two) else (goto :one)


    :one
        @echo off
        set /p Computername="Enter Hostname:"
        set /p Administrator="UserID:"

        powershell -Command $pword = read-host "Enter password" -AsSecureString ; ^
        $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword) ; ^
            [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) > .tmp.txt 
        set /p password=<.tmp.txt & del .tmp.txt

echo:
    (
	echo Hostname: %Computername%

echo:

        wmic /user:%Administrator% /node:%Computername% /password:%password% bios get serialnumber
        @echo off
    ) > "C:\Users\Public\Computer Information\Hostname_Queries"\%Computername%.log
        pause
        exit
    
    
    :two

        set /p Computername="Enter Hostname:"
echo:
    (
    echo Hostname: %Computername%
echo:
        wmic /node:%Computername% bios get serialnumber

        @echo off
    ) > "C:\Users\Public\Computer Information\Hostname_Queries"\%Computername%.log
        
        pause
    