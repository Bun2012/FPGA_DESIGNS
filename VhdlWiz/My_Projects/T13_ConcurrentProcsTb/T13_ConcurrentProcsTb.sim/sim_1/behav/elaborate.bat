@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 1c63740b03f449a59dd4361412717ef7 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T13_ConcurrentProcsTb_behav xil_defaultlib.T13_ConcurrentProcsTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
