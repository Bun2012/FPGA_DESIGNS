@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto aff7b92ff7ad4067a62d55ac0cf0bf44 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T19_ProcedureTb_behav xil_defaultlib.T19_ProcedureTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
