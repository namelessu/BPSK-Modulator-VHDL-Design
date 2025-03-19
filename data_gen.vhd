----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:36:24 12/06/2023 
-- Design Name: 
-- Module Name:    data_gen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.constants.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_gen is
generic (Nreg : positive := N);
port (clk,reset : in STD_LOGIC;
data,sync : out STD_LOGIC);
end data_gen;
architecture Behavioral of data_gen is
component register_t is
port (clk,preset,D : in std_logic;
Q : out std_logic);
end component register_t;
signal sig_xor : std_logic;
signal Q_int : std_logic_vector(0 to Nreg-1);
begin
Data_generator: for I in 0 to Nreg-1 generate
 Reg00: if (I=0) generate
Reg0: register_t port map (clk,reset,sig_xor,Q_int(0));
 end generate;
 Regs: if I>0 generate
Reg: register_t port map (clk,reset,Q_int(I-1),Q_int(I));
 end generate;
end generate;
data <= Q_int(Nreg-1);
sig_xor <= Q_int(0) xor Q_int(Nreg-1);
sync <= and_vector(Q_int);
end Behavioral;

