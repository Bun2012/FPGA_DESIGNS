@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto ef7ee7ede666475994adaf12c91873e0 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T01_HelloWorldTb_behav xil_defaultlib.T01_HelloWorldTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
