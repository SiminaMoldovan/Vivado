----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2023 01:34:22 AM
-- Design Name: 
-- Module Name: proiect - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity proiect is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
          
           left : in STD_LOGIC;
           right : in STD_LOGIC;
           haz : in STD_LOGIC;
           light : out STD_LOGIC_VECTOR (5 downto 0));
end proiect;

architecture Behavioral of proiect is
constant DVSR: integer:=5000000;
   signal ms_reg, ms_next: unsigned(22 downto 0);
 
   type eg_state_type is (s0, sh1, sh2, sl1, sl2, sl3, sr1, sr2, sr3);
   signal state_reg, state_next: eg_state_type;
begin
  process(clk)
   begin
      if (clk'event and clk='1') then
         ms_reg <= ms_next;
  -- d0_reg <= d0_next;
      end if;
   end process;
ms_next <=
      (others=>'0') when ms_reg=DVSR else
      ms_reg + 1;
 -- state register
   process(reset,clk,ms_reg,state_reg)
   begin
      if (reset='1') then
         state_reg <= s0;
        elsif (clk='1' and clk'event) then
  if (ms_reg=DVSR) then
  state_reg <= state_next;
      end if;
  end if;
   end process;
   -- next-state logic
   process(state_reg, left, right, haz, clk)
   begin
 --if tick='1' then
       case state_reg is
        when s0=>
     if (haz='1') then state_next <= sh1;
     elsif (left='1') then state_next <= sl1;
     elsif (right='1') then state_next <=sr1;
     else state_next <= s0;
     end if;
   when sh1=>
     state_next <= sh2;
   when sh2=>
     if (haz='1') then state_next <= sh1;
     elsif (left='1') then state_next <= sl1;
     elsif (right='1') then state_next <=sr1;
     else state_next <= s0;
     end if;
   when sl1=>
     if (haz='1') then state_next <= sh1;
     else state_next <= sl2;
     end if;
   when sl2=>
     if (haz='1') then state_next <= sh1;
     else state_next <= sl3;
     end if;
   when sl3=>
     if (haz='1') then state_next <= sh1;
     elsif (left='1') then state_next <= sl1;
     elsif (right='1') then state_next <=sr1;
     else state_next <= s0;
     end if;
   when sr1=>
     if (haz='1') then state_next <= sh1;
     else state_next <= sr2;
     end if;
   when sr2=>
     if (haz='1') then state_next <= sh1;
     else state_next <= sr3;
     end if;
   when sr3=>
     if (haz='1') then state_next <= sh1;
     elsif (left='1') then state_next <= sl1;
     elsif (right='1') then state_next <=sr1;
     else state_next <= s0;
     end if;
           end case;
  --end if;
 end process;
   -- Moore output logic
   process(state_reg)
   begin
      case state_reg is
         when s0 =>
  -- if tick='1' then
            light <= "000000";
  -- end if;    
  when sh1 =>
  -- if tick='1' then
            light <= "111111";
  -- end if;
         when sh2 =>
  -- if tick='1' then
            light <= "000000";
  -- end if;    
  when sl1 =>
  -- if tick='1' then
            light <= "001000";
  -- end if;
         when sl2 =>
  -- if tick='1' then
            light <= "011000";
  -- end if;   
  when sl3 =>
  -- if tick='1' then
            light <= "111000";
  -- end if;
         when sr1 =>
  -- if tick='1' then
            light <= "000100";
  -- end if;   
  when sr2 =>
  -- if tick='1' then
            light <= "000110";
  -- end if;
   when sr3 =>
 --  if tick='1' then
            light <= "000111";
  -- end if;
         end case;
   end process;



end Behavioral;
