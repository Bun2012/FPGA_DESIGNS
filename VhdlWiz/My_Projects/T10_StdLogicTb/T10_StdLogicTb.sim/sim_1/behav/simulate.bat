@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xsim T10_StdLogicTb_behav -key {Behavioral:sim_1:Functional:T10_StdLogicTb} -tclbatch T10_StdLogicTb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
