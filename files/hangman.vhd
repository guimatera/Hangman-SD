----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:14:41 07/14/2022 
-- Design Name: 
-- Module Name:    hangman - Behavioral 
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

entity hangman is
	port (clk, reset: in std_logic;
			z : out std_logic);
end hangman;

architecture Behavioral of hangman is

type state is(s_0 , s_1, s_2, s_3, S_4, s_5);
signal x_current, x_next: state;

-- s_0 => input
-- s_1 => acerto
-- s_2 => perde vida
-- s_3 => igual
-- s_4 => vitória
-- s_5 => derrota

component lives is 
	port(remaining_lives: IN integer range 0 to 5 := 5;
		  led: OUT STD_Logic_Vector(3 downTo 0));
end component;

begin
Process (reset, clk)
	begin
		if (reset = '1') then
			x_current <= s_0;
		elsif (rising_edge(clk)) then
			x_current <= x_next;	
		end if;
	end process;
	
	Process (x_current)
	begin 
		z <= '0'; -- Saída iniciada como 'perdeu'
		case x_current is
			when s_0 => 
				if (true) then -- acertou número
					x_next <= s_1;
				elsif (false) then -- errou número
					x_next <= s_2;
				else 				-- digitou número já inserido
					x_next <= s_3; 
				end if;
				
			when s_1 => 
				if (true) then	-- acertou número final
					x_next <= s_4;
					z <= '1';	-- Saída alterada para indicar que 'ganhou'
				else 				-- acertou um número, sem vencer 
					x_next <= s_0;
				end if;
			
			when s_2 => 
				-- remaining_lives = remaining_lives - 1; -- Decremento na contagem de vidas
				if (true) then	-- errou, sem mais vidas
					x_next <= s_5;
				else 				-- errou, vidas sobrando
					x_next <= s_0;
				end if;
				
			when s_3 => 
				x_next <= s_0; -- Digitou número que já saiu
					
			when s_4 =>
				x_next <= x_current; -- Venceu o jogo e se mantém assim até resetar
				z <= '1';				-- Saída alterada para indicar que 'ganhou'
			
			when s_5 =>
				x_next <= x_current; -- Perdeu o jogo e se mantém assim até resetar
				
		end case;
	end process;

end Behavioral;

