@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto e0d17c9c0a4e4e00b5019d7e01fe44f1 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T03_LoopTb_behav xil_defaultlib.T03_LoopTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
