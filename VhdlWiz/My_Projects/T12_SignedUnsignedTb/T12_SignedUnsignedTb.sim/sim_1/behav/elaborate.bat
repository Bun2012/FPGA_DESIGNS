@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto 3be1b53aeaa244169c8504edc260be4d -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot T12_SignedUnsignedTb_behav xil_defaultlib.T12_SignedUnsignedTb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
