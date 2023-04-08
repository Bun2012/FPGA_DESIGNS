@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xsim T12_SignedUnsignedTb_behav -key {Behavioral:sim_1:Functional:T12_SignedUnsignedTb} -tclbatch T12_SignedUnsignedTb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
