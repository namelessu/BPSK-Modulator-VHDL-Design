----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:02:12 12/20/2023 
-- Design Name: 
-- Module Name:    com_dac - Behavioral 
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY com_dac IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		dac_cs : OUT STD_LOGIC;
		dac_clr : OUT STD_LOGIC;
		spi_mosi : OUT STD_LOGIC;
		spi_sck : OUT STD_LOGIC;
		data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		count_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END com_dac;
ARCHITECTURE Behavioral OF com_dac IS
	SIGNAL memory_dac : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
	PROCESS (clk, reset)
		VARIABLE count : NATURAL RANGE 0 TO 100 := 0;
	BEGIN
		IF reset = '1' THEN
			-- Sets the command by default
			memory_dac(23 DOWNTO 20) <= "0011";
			-- The address points out to DAC A by default
			memory_dac(19 DOWNTO 16) <= "0000";
			count := 0;
			dac_cs <= '1';
		ELSIF clk'event AND clk = '1' THEN
			count := count + 1;
			CASE count IS
				WHEN 1 => dac_cs <= '0';
					memory_dac(15 DOWNTO 4) <= data; -- Load the data
					-- Points out to DAC A
					memory_dac(19 DOWNTO 16) <= "0000";
					spi_mosi <= memory_dac(31);
				WHEN 33 => dac_cs <= '1';
				WHEN 64 => count := 0;
				WHEN OTHERS =>
					spi_mosi <= memory_dac(31 - ((count - 1) MOD 32));
			END CASE;
		END IF;
		count_out <= STD_LOGIC_VECTOR(conv_unsigned(count, 7));
	END PROCESS;
	spi_sck <= NOT(clk);
	dac_clr <= NOT(reset);
END Behavioral;