@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto a6044b44f57248ff9eab940e07c8fd75 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T02_WaitForTb_behav xil_defaultlib.T02_WaitForTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
