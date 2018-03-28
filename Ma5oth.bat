@echo off
setlocal EnableDelayedExpansion 

CALL info.bat

SET ETH_WALLET_ADDRESS=%ETH%
SET ETC_WALLET_ADDRESS=%ETC%
SET ZEN_WALLET_ADDRESS=%ZEN%
SET VTC_WALLET_ADDRESS=%VTC%
SET KMD_WALLET_ADDRESS=%KMD%
SET XZC_WALLET_ADDRESS=%XZC%
SET BTG_WALLET_ADDRESS=%BTG%
SET ETP_WALLET_ADDRESS=%ETP%
SET RVN_WALLET_ADDRESS=%RVN%
SET BTCP_WALLET_ADDRESS=%BTCP%

SET MINER_WEBLOGIN=%MINER-WEBLOGIN%
SET WORKER_PASSWORD=%WORKER-PASSWORD%
SET MINER_NAME=%MINER-NAME%
SET EMAIL_ADDRESS=%EMAIL-ADDRESS%

setx GPU_FORCE_64BIT_PTR 0 >nul 2>&1
setx GPU_MAX_HEAP_SIZE 100 >nul 2>&1
setx GPU_USE_SYNC_OBJECTS 1 >nul 2>&1
setx GPU_MAX_ALLOC_PERCENT 100 >nul 2>&1
setx GPU_SINGLE_ALLOC_PERCENT 100 >nul 2>&1

SET miner=%1

IF NOT "%miner%"=="" (
    SET /A M=%miner%
    goto MinerSwitch
)

ECHO =================================================
ECHO 3.  ETHEREUM - CLAYMORE - Ethermine.org
ECHO 8.  ETHEREUM - CLAYMORE - Nanopool
ECHO.
::ECHO 12. ETHEREUM CLASSIC - CLAYMORE - Nanopool
::ECHO.
::ECHO 15. KOMODO - DSTM ZMiner - luckpool
::ECHO 16. KOMODO - EWBF ZMiner - luckpool
::ECHO.
::ECHO 40. BITCOIN GOLD - EWBF - BTGpool
::ECHO.
ECHO 50. VERTCOIN - CCMiner YIIMP - Rig03 local node
ECHO.
ECHO 55. ZCOIN (XZC) - CCMiner YIIMP - Miningpoolhub
ECHO 56. ZCOIN (XZC) - CCMiner YIIMP - MintPond
ECHO.
ECHO 58. ZEN - DSTM ZMiner - zhash.pro
::ECHO 59. ZEN - EWBF ZMiner - zhash.pro
ECHO 60. ZEN - EWBF ZMiner - luckpool.org
ECHO 61. ZEN - DSTM ZMiner - luckpool.org
::ECHO 62. ZEN - DSTM ZMiner - Miningspeed.com
::ECHO 63. ZEN - DSTM ZMiner - zenmine.pro
ECHO.
ECHO 70. METAVERSE - Claymore - dodopool.com
ECHO.
ECHO 80. Bitcoin Private - BTCP.pro
ECHO 81. Bitcoin Private - BTCP.org
ECHO.
ECHO 90. RavenCoin - CCMiner - YIIMP
::ECHO.
::ECHO 99 - EXIT
ECHO =================================================
ECHO.

:: Get input from user
SET /P M=Type the number then press ENTER:
if %ERRORLEVEL% NEQ 0 goto EOF

:: Is choice a number?
SET "var="&for /f "delims=0123456789" %%i in ("%M%") do set var=%%i
if defined var goto EOF

:MinerSwitch
IF %M%==3 GOTO ethereum3
IF %M%==8 GOTO ethereum8
IF %M%==12 GOTO ethereumc2
IF %M%==15 GOTO komodo1
IF %M%==16 GOTO komodo2
IF %M%==40 GOTO btg2
IF %M%==50 GOTO vtc1
IF %M%==55 GOTO xzc1
IF %M%==56 GOTO xzc2
IF %M%==58 GOTO zen1
IF %M%==59 GOTO zen2
IF %M%==60 GOTO zen3
IF %M%==61 GOTO zen4
IF %M%==62 GOTO zen5
IF %M%==63 GOTO zen6
IF %M%==70 GOTO etp
IF %M%==75 GOTO etn1
IF %M%==80 GOTO btcp1
IF %M%==81 GOTO btcp2
IF %M%==90 GOTO raven1
IF %M% GTR 63 GOTO EOF

::
:: Ethereum miners
::

:ethereum3
ECHO AMD and NVIDIA Claymore - Eth Only Ethermine.org
Miners\Claymore\EthDcrMiner64.exe -epool stratum+tcp://eu2.ethermine.org:4444 -ewal %ETH_WALLET_ADDRESS%.%MINER_NAME% -epsw %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:ethereum8
ECHO AMD and NVIDIA Claymore - Eth Nanopool Only
Miners\Claymore\EthDcrMiner64.exe -epool eth-eu1.nanopool.org:9999 -ewal %ETH_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -mode 1
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Ethereum Classic miners
::

:ethereumc2
ECHO AMD and NVIDIA Claymore - Etc (ethereum classic) to Nanopool
Miners\Claymore\EthDcrMiner64.exe -epool etc-eu2.nanopool.org:19999 -ewal %ETC_WALLET_ADDRESS%/%MINER_NAME%/%EMAIL_ADDRESS% -mode 1 -allpools 1 
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Komodo Miners
::

:komodo1
ECHO NVIDIA DSTM ZMiner - Komodo to luckpool
Miners\DSTM\zm.exe --dev --server luckpool.org --port 3857 --user %KMD_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:komodo2
ECHO NVIDIA EWBF ZMiner - Komodo to luckpool
Miners\EWBF\miner --server luckpool.org --port 3857 --user %KMD_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD% --pec
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Bitcoin Gold Miners
::

:btg2
ECHO NVIDIA EWBF's CUDA Miner - BTG to Minertopia NVIDIA Only
Miners\EWBF\miner --server eu.btgpool.pro --user %BTG_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD% --port 3857 --pec
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Zcoin Miners
::
:xzc1
ECHO CCMiner YIIMP - Nvidia Only - Zcoin to Miningpoolhub
Miners\ccminer-x64-2.2.2-cuda9\ccminer-x64.exe -a lyra2z --submit-stale -o stratum+tcp://europe.lyra2z-hub.miningpoolhub.com:20581 -u %MINER_WEBLOGIN%.%MINER_NAME% -p %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:xzc2
ECHO CCMiner YIIMP - Nvidia Only - Zcoin to MintPond
Miners\ccminer-x64-2.2.2-cuda9\ccminer-x64.exe -a lyra2z --submit-stale -o stratum+tcp://zcoin.mintpond.com:3001 -u %XZC_WALLET_ADDRESS%.%MINER_NAME% -p %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Vertcoin Miner
::
:vtc1
ECHO Vertcoin CCMiner YIIMP - Nvidia Only - Vertcoin to Rig 03
Miners\ccminer-x64-2.2.2-cuda9\ccminer-x64.exe -a Lyra2rev2 -i 20 -o stratum+tcp://192.168.8.102:9171 -u %VTC_WALLET_ADDRESS%.%MINER_NAME% -p ma5oth
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: ZENCoin Miners
::
:zen1
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCOIN to zhash.pro
Miners\DSTM\zm.exe --dev --server zhash.pro --port 3057 --user %ZEN_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zen2
ECHO NVIDIA EWBF ZMiner - nVidia Only - ZENCOIN to zhash.pro
Miners\EWBF\miner --server zhash.pro --port 3057 --user %ZEN_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD% --pec
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zen3
ECHO NVIDIA EWBF ZMiner - nVidia Only - ZENCOIN to luckpool.org
Miners\EWBF\miner --server luckpool.org --port 3057 --user %ZEN_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD% --pec
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zen4
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCOIN to luckpool.org
Miners\DSTM\zm.exe --dev --server luckpool.org --port 3057 --user %ZEN_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zen5
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCOIN to miningspeed.com
Miners\DSTM\zm.exe --dev --server mining.miningspeed.com --port 3062 --user %ZEN_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:zen6
ECHO NVIDIA DSTM ZMiner - nVidia Only - ZENCOIN to zenmine.pro
Miners\DSTM\zm.exe --dev --server asia.zenmine.pro --port 9009 --user %ZEN_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Metaverse (ETP)
::

:etp
ECHO NVIDIA Claymore - Metaverse
Miners\Claymore_Dual_Ethereum\EthDcrMiner64.exe -epool stratum+tcp://etp.dodopool.com:8008 -ewal %ETP_WALLET_ADDRESS% -epsw %WORKER_PASSWORD% -allpools 1 -allcoins exp -eworker %MINER_NAME%
if %ERRORLEVEL% NEQ 0 goto exit
pause


::
:: Ravencoin Miner
::

:raven1
ECHO RavenCoin CCMiner - YIIMP
Miners\ccminer-x64-2.2.5-rvn-cuda9\ccminer-x64.exe -a x16r --submit-stale -o stratum+tcp://yiimp.eu:3636 -u %RVN_WALLET_ADDRESS%.%MINER_NAME% -p c=RVN,d=8 %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

::
:: Bitcoin Private
::

:btcp1
ECHO Bitcoin Private - BTCP.pro
Miners\DSTM\zm.exe --dev --server eu.btcprivate.pro --port 2827 --user %BTCP_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:btcp2
ECHO Bitcoin Private - BTCP.org
Miners\DSTM\zm.exe --dev --server pool2.btcprivate.org --port 3032 --user %BTCP_WALLET_ADDRESS%.%MINER_NAME% --pass %WORKER_PASSWORD%
if %ERRORLEVEL% NEQ 0 goto exit
pause

:: =============================================

:exit
ECHO Error while running miner
pause

:EOF
