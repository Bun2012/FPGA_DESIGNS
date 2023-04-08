@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 0442663b72e34ec3935022e92e845d7a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T05_WhileLoopTb_behav xil_defaultlib.T05_WhileLoopTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
