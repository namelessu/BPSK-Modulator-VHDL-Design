----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:54:45 12/20/2023 
-- Design Name: 
-- Module Name:    bpsk - Behavioral 
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
USE work.constants.ALL;
USE work.real2bit.ALL;
ENTITY bpsk IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		serial_data : IN STD_LOGIC;
		clk_data : OUT STD_LOGIC;
		clk_spi : OUT STD_LOGIC;
		clk_bpsk : OUT STD_LOGIC;
		data : OUT STD_LOGIC_VECTOR (11 DOWNTO 0)
	);
END bpsk;
ARCHITECTURE Behavioral OF bpsk IS
	SIGNAL pointer : NATURAL RANGE 0 TO (M - 1) := M - 1;
	SIGNAL value : word := (OTHERS => '0');
	SIGNAL clk_bpsk_s : std_logic := '0';
BEGIN
	PROCESS (reset, clk, clk_bpsk_s)
	VARIABLE count : NATURAL RANGE 0 TO (64 * M - 1) := 0;
	BEGIN
		IF reset = '1' THEN
			clk_bpsk_s <= '0';
			clk_data <= '0';
			count := 0;
		ELSIF clk'EVENT AND clk = '1' THEN
			IF count = 0 THEN
				clk_bpsk_s <= '1';
				clk_data <= '1';
			ELSIF count MOD 64 = 0 THEN
				clk_bpsk_s <= '1';
			ELSE
				clk_bpsk_s <= '0';
				clk_data <= '0';
			END IF;
			count := (count + 1) MOD (64 * M);
		END IF;
	END PROCESS;
	PROCESS (reset, clk_bpsk_s)
		BEGIN
			IF reset = '1' THEN
				pointer <= M - 1;
			ELSIF clk_bpsk_s'EVENT AND clk_bpsk_s = '1' THEN
				pointer <= (pointer + 1) MOD M;
			END IF;
		END PROCESS;
		clk_spi <= clk;
		value <= - table_wave(pointer) WHEN serial_data = '1' ELSE
		         table_wave(pointer);
		-- Use the next line for simulation
		data <= std_logic_vector(value);
		-- Use the next line for synthesis and comment the previous one
		--data <= value + conv_signed(2**(nbits-1),nbits);
		clk_bpsk <= clk_bpsk_s;
END Behavioral;