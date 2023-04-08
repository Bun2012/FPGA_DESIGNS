@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto cff3dc0a2445467b8c41667a55ab3734 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T08_IfTb_behav xil_defaultlib.T08_IfTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
