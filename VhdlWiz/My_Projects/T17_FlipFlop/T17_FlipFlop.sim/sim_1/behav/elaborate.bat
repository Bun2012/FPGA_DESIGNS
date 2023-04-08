@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto acbeb7681f694b519700df7ae657f6ae -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T17_ClockedProcessTb_behav xil_defaultlib.T17_ClockedProcessTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
