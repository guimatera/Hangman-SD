----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:22:15 07/07/2022 
-- Design Name: 
-- Module Name:    lives - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lives is
	PORT(remaining_lives: IN integer range 0 to 5 := 5;
		  led: OUT STD_Logic_Vector(3 downTo 0));
end lives;

architecture Behavioral of lives is
begin
	process(remaining_lives)
	begin
		case remaining_lives is
			when 5 => led <= "1111";
			when 4 => led <= "0111";
			when 3 => led <= "0011";
			when 2 => led <= "0001";
			when 1 => led <= "0000";
			when others => led <= "0000";
		end case;
	end process;
end Behavioral;

