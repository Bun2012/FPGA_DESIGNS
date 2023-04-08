@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xsim T17_ClockedProcessTb_behav -key {Behavioral:sim_1:Functional:T17_ClockedProcessTb} -tclbatch T17_ClockedProcessTb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
