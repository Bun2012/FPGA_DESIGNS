@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 4d6079bf5b314b7389ad7979f3e05934 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T15_PortMapTb_behav xil_defaultlib.T15_PortMapTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
