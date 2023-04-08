@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto dc235ca55da845ee826876db233fd721 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T10_StdLogicTb_behav xil_defaultlib.T10_StdLogicTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
