@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 2589d403e00d4a67987199a992c71ba3 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T20_FiniteStateMachineTb_behav xil_defaultlib.T20_FiniteStateMachineTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
