LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.MATH_REAL.ALL;
USE work.constants.ALL;
PACKAGE real2bit IS
	SUBTYPE double IS signed(2 * nbits - 1 DOWNTO 0);
	FUNCTION truncate (a : real;
		numdec : NATURAL := ndec) RETURN
		signed;
		FUNCTION extract (a : double;
			numdec : NATURAL := ndec) RETURN
			signed;
			FUNCTION initialize_table RETURN table;
				CONSTANT table_wave : table := initialize_table;
			END real2bit;
			PACKAGE BODY real2bit IS
				FUNCTION truncate (a : real;
					numdec : NATURAL := ndec) RETURN signed IS
					VARIABLE result : signed(nbits - 1 DOWNTO 0);
					VARIABLE tmp, comp : real := 0.0;
					VARIABLE comp_int, sign : INTEGER := 0;
				BEGIN
					-- numdec indicates the number of bits referred to decimals
					tmp := ABS(a * (2.0 ** numdec));
					IF a < 0.0 THEN
						sign := - 1;
					ELSE
						sign := 1;
					END IF;
					FOR I IN nbits - 2 DOWNTO 0 LOOP
						comp := comp + 2.0 ** I;
						comp_int := comp_int + 2 ** I;
						IF tmp < comp THEN
							comp := comp - 2.0 ** I;
							comp_int := comp_int - 2 ** I;
						END IF;
					END LOOP;
					result := conv_signed(comp_int * sign, nbits); RETURN result;
				END truncate;
				FUNCTION extract (a : double;
					numdec : NATURAL := ndec) RETURN
					signed IS
					VARIABLE result : signed(nbits - 1 DOWNTO 0);
					BEGIN
						result := signed(a(numdec + nbits - 1 DOWNTO numdec)); RETURN result;
					END FUNCTION extract;
					FUNCTION initialize_table RETURN table IS
						VARIABLE result : table;
						BEGIN
							FOR I IN 0 TO M - 1 LOOP
								result (I) := truncate(2.0 * sin(delta_phi * real(I)));
							END LOOP; RETURN result;
						END FUNCTION initialize_table;
END real2bit;