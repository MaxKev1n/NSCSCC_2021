@echo off
REM ****************************************************************************
REM Vivado (TM) v2019.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Sun Jul 25 18:41:56 +0800 2021
REM SW Build 2708876 on Wed Nov  6 21:40:23 MST 2019
REM
REM Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto b9565a0f93d14152bbb8a3622a7850d7 --incr --debug typical --relax --mt 2 -L blk_mem_gen_v8_4_4 -L xil_defaultlib -L dist_mem_gen_v8_0_13 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_behav xil_defaultlib.tb xil_defaultlib.glbl -log elaborate.log"
call xelab  -wto b9565a0f93d14152bbb8a3622a7850d7 --incr --debug typical --relax --mt 2 -L blk_mem_gen_v8_4_4 -L xil_defaultlib -L dist_mem_gen_v8_0_13 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_behav xil_defaultlib.tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
