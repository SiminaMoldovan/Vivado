----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2023 02:11:55 AM
-- Design Name: 
-- Module Name: simulare - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simulare is
--  Port ( );
end simulare;

architecture Behavioral of simulare is
constant clk_period :time :=300 ms;
component simulare is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           left : in STD_LOGIC;
           right : in STD_LOGIC;
           haz : in STD_LOGIC;
           light : out STD_LOGIC_VECTOR (5 downto 0));
end component simulare;
signal reset_tb : STD_LOGIC;
    signal clk_tb : STD_LOGIC;
    signal right_tb : STD_LOGIC;
    signal left_tb : STD_LOGIC;
    signal haz_tb : STD_LOGIC;
    signal light_tb : STD_LOGIC_VECTOR (5 downto 0);
begin
dut : simulare
        port map (
            reset => reset_tb,
            clk => clk_tb,
            right => right_tb,
            left => left_tb,
            haz => haz_tb,
            light => light_tb
        );

    
    clk_gen : process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    
    stim_proc : process
    begin
        reset_tb <= '1';  
        right_tb <= '0';
        left_tb <= '0';
        haz_tb <= '0';
        wait for 20 ns;

        reset_tb <= '0';  
        wait for 10 ns;

        right_tb <= '1';  
        wait for 50 ns;
        right_tb <= '0';  
        wait for 10 ns;

        left_tb <= '1';  
        wait for 50 ns;
        left_tb <= '0';  
        wait for 10 ns;

        haz_tb <= '1';  
        wait for 50 ns;
        haz_tb <= '0';  
        wait for 10 ns;

    

        wait;
    end process;

end Behavioral;
