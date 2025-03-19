----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:38 12/20/2023 
-- Design Name: 
-- Module Name:    system - Behavioral 
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
USE work.constants.ALL;
ENTITY system IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		dac_cs : OUT STD_LOGIC;
		spi_mosi : OUT STD_LOGIC;
		spi_sck : OUT STD_LOGIC;
		dac_clr : OUT STD_LOGIC;
		data : OUT STD_LOGIC);
END system;
ARCHITECTURE Behavioral OF system IS
	COMPONENT bpsk IS
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			serial_data : IN STD_LOGIC;
			clk_data : OUT STD_LOGIC;
			clk_spi : OUT STD_LOGIC;
			clk_bpsk : OUT STD_LOGIC;
			data : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
	END COMPONENT bpsk;
	COMPONENT data_gen IS
		GENERIC (Nreg : POSITIVE := N);
		PORT (
			clk, reset : IN STD_LOGIC;
			data, sync : OUT STD_LOGIC);
	END COMPONENT data_gen;
	COMPONENT com_dac IS
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			dac_cs : OUT STD_LOGIC;
			dac_clr : OUT STD_LOGIC;
			spi_mosi : OUT STD_LOGIC;
			spi_sck : OUT STD_LOGIC;
			data : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			count_out : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT com_dac;
	SIGNAL clk_data, clk_spi, serial_data : STD_LOGIC;
	SIGNAL data_int : STD_LOGIC_VECTOR (11 DOWNTO 0);
BEGIN
	Data_gen0 : data_gen PORT MAP(clk_data, reset, serial_data);
	Modulador : bpsk PORT MAP
	(
		clk, reset, serial_data, clk_data, clk_spi,
		data => data_int);
	DAC_interface : com_dac PORT MAP
		(clk_spi, reset, dac_cs, dac_clr, spi_mosi, spi_sck, data_int);
	data <= serial_data;
END Behavioral;