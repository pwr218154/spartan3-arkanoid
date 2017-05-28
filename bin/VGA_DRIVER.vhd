library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Resolution: 640 X 480

entity VGA_DRIVER is
   port
   (
      rgb : in std_logic_vector(2 downto 0);
      clk : in std_logic;
      rout : out std_logic;
      gout : out std_logic;
      bout : out std_logic;
      hs : out std_logic;
      vs : out std_logic;
      x : out std_logic_vector(9 downto 0);
      y : out std_logic_vector(9 downto 0)
   );
end VGA_DRIVER;

architecture Behavioral of VGA_DRIVER is
    signal clk_2 : std_logic;
    signal xcounter : integer range 0 to 799;
    signal ycounter : integer range 0 to 520;
begin

    process (clk)
    begin
        if rising_edge(clk) then
            clk_2 <= not clk_2;
        end if;
    end process;

    process (clk_2)
    begin
        if rising_edge(clk_2) then
            if xcounter >= 799 then
                xcounter <= 0;
                if ycounter >= 520 then
                    ycounter <= 0;
                else
                    ycounter <= ycounter + 1;
                end if;
            else
                xcounter <= xcounter + 1;
            end if;
        end if;
    end process;
    
    hs <= '0' when xcounter >= 16 and xcounter < 112 else '1';
    vs <= '0' when ycounter >= 10 and ycounter < 12 else '1';
    
    process (xcounter, ycounter, rgb)
    begin
        if xcounter < 160 or ycounter < 41 then
            rout <= '0';
            gout <= '0';
            bout <= '0';
        else
            rout <= rgb(2);
            gout <= rgb(1);
            bout <= rgb(0);
        end if;
    end process;
    
    process(xcounter)
    begin
         if xcounter>=160 then 
            x<=std_logic_vector(to_unsigned(xcounter-160, x'length));
         else
            x<=std_logic_vector(to_unsigned(640, x'length));
            end if;
    end process;
    
    process(ycounter)
    begin
         if ycounter>=41 then 
            y<=std_logic_vector(to_unsigned(ycounter-41, y'length));
         else
            y<=std_logic_vector(to_unsigned(480, y'length));
            end if;
    end process;
    
end Behavioral;

