@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 01861e39609a4933a712dc7e79478a1a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T18_TimerTb_behav xil_defaultlib.T18_TimerTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
