@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 98a5b46842bc447abc92e3e1e1d04fbc -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T06_SignalTb_behav xil_defaultlib.T06_SignalTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
