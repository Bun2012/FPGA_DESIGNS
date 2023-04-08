@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto a3b570e4a5d441ad817236a3973040cb -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T11_StdLogicVectorTb_behav xil_defaultlib.T11_StdLogicVectorTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
