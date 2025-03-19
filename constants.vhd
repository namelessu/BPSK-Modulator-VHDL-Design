--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.MATH_REAL.ALL;
PACKAGE constants IS
	CONSTANT N : POSITIVE := 4;
	CONSTANT M : POSITIVE := 32;
	CONSTANT nbits : POSITIVE := 12;
	CONSTANT ndec : POSITIVE := 10;
	SUBTYPE word IS signed(nbits - 1 DOWNTO 0);
	TYPE table IS ARRAY (M - 1 DOWNTO 0) OF word;
	CONSTANT Pi : real := 3.1415927;
	CONSTANT delta_phi : real := 2.0 * Pi/real(M);
	FUNCTION and_vector (vector : IN std_logic_vector(0 TO N - 1)) RETURN std_logic;
END constants;
PACKAGE BODY constants IS
	FUNCTION and_vector (vector : IN std_logic_vector(0 TO N - 1)) RETURN std_logic IS
	VARIABLE result : std_logic;
	BEGIN
		result := vector(0);
		FOR I IN 1 TO N - 1 LOOP
			result := vector(I) AND result;
		END LOOP; RETURN result;
	END and_vector;
END constants;