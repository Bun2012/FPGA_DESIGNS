@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 764d87bd965846f1a588eac33f11c075 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T16_GenericMuxTb_behav xil_defaultlib.T16_GenericMuxTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
