@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xsim T11_StdLogicVectorTb_behav -key {Behavioral:sim_1:Functional:T11_StdLogicVectorTb} -tclbatch T11_StdLogicVectorTb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
