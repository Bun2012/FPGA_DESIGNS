@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xsim T13_ConcurrentProcsTb_behav -key {Behavioral:sim_1:Functional:T13_ConcurrentProcsTb} -tclbatch T13_ConcurrentProcsTb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
