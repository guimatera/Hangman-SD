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
-- Dep	encies: 
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
	port (CLOCK_50: in std_logic; -- sinal de clock  (E12)
			enable:	in std_logic; -- switch de habilitação para leitura de palpites (T9)
			c : in std_logic_vector(2 downto 0); -- switches de palpites do usuário em binário (U8, U10, V8)
			vida: out std_logic_vector(1 downto 0) := "11"; -- leds contadores de vidas restantes em binário	(W21, Y22)
			senha: out std_logic_vector(5 downto 0)  := "000000"); -- gabarito da forca no leds (V20, V19, U19, U20, T19, R20)
end hangman;

architecture Behavioral of hangman is

type state is(s_0 , s_1, s_2, s_3, S_4);
-- s_0 => input
-- s_1 => acerto
-- s_2 => perde vida
-- s_3 => vitória
-- s_4 => derrota

signal x_current, x_next : state;
signal password: std_logic_vector(5 downto 0) := "000000";
signal remaining_lives: std_logic_vector(1 downto 0) := "11";
signal d: std_logic_vector(2 downto 0) := "000";



begin
	Process (x_current, CLOCK_50) --Process responsável pelo fluxo da máquina de estados.
	begin 
	
		if (rising_edge(CLOCK_50) and enable = '1') then
			x_current <= x_next;
			
			case x_current is
			when s_0 => 
				if (c = "000" or c = "001" or c = "101" or c = "110" or c = "111") then -- acertou número
					x_next <= s_1;
				elsif (c /= d)	then		-- errou o número
					d <= c;
					x_next <= s_2; 
				else
					x_next <= s_0;
				end if;
				
			when s_1 => -- Ativa leds correspondentes ao acerto do palpite 
				if (c = "000") then
					password(0) <= '1';
				elsif (c = "001") then
					password(3) <= '1';
					password(4) <= '1';
				elsif (c = "101") then
					password(1) <= '1';
				elsif (c = "110") then
					password(2) <= '1';
				elsif (c = "111") then
					password(5) <= '1';
				else
					x_next <= s_0;
				end if;
				
				senha <= password;
				
				if (password = "111111") then -- Acertou todos os números
					x_next <= s_3;
				else
					x_next <= s_0;
				end if;
			
			when s_2 => 
			
				if (remaining_lives = "11") then
					vida <= "10";
					remaining_lives <= "10";
					x_next <= s_0;
				elsif (remaining_lives = "10") then
					vida <= "01";
					remaining_lives <= "01";
					x_next <= s_0;
				elsif (remaining_lives = "01") then
					vida <= "00";
					remaining_lives <= "00";
					x_next <= s_4;
				end if;
					
			when s_3 =>
				x_next <= s_3; -- Venceu o jogo 
			
			when s_4 =>
				senha <= "000000";
				x_next <= s_4; -- Perdeu o jogo 
				
			end case;
			
		else
			x_current <= x_current;
		end if;

	end process;
end Behavioral;

