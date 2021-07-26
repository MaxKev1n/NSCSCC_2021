-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Mon Jul 26 09:03:10 2021
-- Host        : DESKTOP-3JI9O6L running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/NSCSCC/NSCSCC_2021/project_1/project_1.srcs/sources_1/ip/unsigned_multiplier/unsigned_multiplier_stub.vhdl
-- Design      : unsigned_multiplier
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a200tfbg676-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unsigned_multiplier is
  Port ( 
    CLK : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR ( 32 downto 0 );
    B : in STD_LOGIC_VECTOR ( 32 downto 0 );
    P : out STD_LOGIC_VECTOR ( 65 downto 0 )
  );

end unsigned_multiplier;

architecture stub of unsigned_multiplier is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "CLK,A[32:0],B[32:0],P[65:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "mult_gen_v12_0_16,Vivado 2019.2";
begin
end;
