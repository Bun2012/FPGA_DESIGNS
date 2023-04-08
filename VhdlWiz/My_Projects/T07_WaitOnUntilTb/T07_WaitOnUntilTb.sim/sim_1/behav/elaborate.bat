@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 00fb21d7f10f4ace9cdadfb38fc2c185 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T07_WaitOnUntilTb_behav xil_defaultlib.T07_WaitOnUntilTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
