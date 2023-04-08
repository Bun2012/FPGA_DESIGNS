@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 3d523dc381214072b8022c4e9c743d0d -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T04_ForLoopTb_behav xil_defaultlib.T04_ForLoopTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
