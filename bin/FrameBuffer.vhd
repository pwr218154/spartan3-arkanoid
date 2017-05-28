LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.MATH_REAL.ALL;

ENTITY FrameBuffer IS
    PORT
    (
        RotL    : IN std_logic;
        RotR    : IN std_logic;
        RotB    : IN std_logic;
        y       : IN std_logic_vector(9 DOWNTO 0);
        x       : IN std_logic_vector(9 DOWNTO 0);
        clk     : IN std_logic;
        rgb     : OUT std_logic_vector(2 DOWNTO 0);
        clk_out : OUT std_logic
    );
END FrameBuffer;

ARCHITECTURE Behavioral OF FrameBuffer IS

    CONSTANT BALL_W       : INTEGER := 10;
    CONSTANT BALL_H       : INTEGER := 10;

    CONSTANT BLOCK_W      : INTEGER := 60;
    CONSTANT BLOCK_H      : INTEGER := 15;

    CONSTANT RACKET_W     : INTEGER := 50;
    CONSTANT RACKET_H     : INTEGER := 10;

    CONSTANT RACKET_S     : INTEGER := 5;

    CONSTANT BLOCK_SPAN_X : INTEGER := 150;
    CONSTANT BLOCK_SPAN_Y : INTEGER := 35;

    CONSTANT RACKET_Y     : INTEGER := 10;

    SIGNAL xint           : INTEGER RANGE 0 TO 640;
    SIGNAL yint           : INTEGER RANGE 0 TO 480;

    SIGNAL racketX        : INTEGER RANGE 0 TO 520;

    SIGNAL ballX          : INTEGER RANGE 0 TO 620 := 319;
    SIGNAL ballY          : INTEGER RANGE 0 TO 460 := 239;

    SIGNAL clk_2Hz_i      : std_logic;
    SIGNAL prescaler      : unsigned(23 DOWNTO 0);
    SIGNAL blocks         : std_logic_vector (15 DOWNTO 0) := X"FFFF";

    SIGNAL RST_GAME       : std_logic := '0';
    SIGNAL GAME_OVER      : std_logic := '0';

BEGIN

    -- Generate clk 2Hz
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            IF prescaler = X"98968" THEN
                prescaler <= (OTHERS => '0');
                clk_2Hz_i <= NOT clk_2Hz_i;
            ELSE
                prescaler <= prescaler + "1";
            END IF;
            clk_out <= clk_2Hz_i;
        END IF;
    END PROCESS;

    -- Racket Movement
    PROCESS (clk, RotL, RotR)
        BEGIN
            IF rising_edge(clk) THEN
                IF RotL = '1' AND racketx > 0 THEN
                    racketX <= racketX - 10;
                END IF;

                IF RotR = '1' AND racketx < 520 THEN
                    racketX <= racketX + 10;
                END IF;
            END IF;
        END PROCESS;

    -- Game Reset
    PROCESS (RotB)
        BEGIN
            IF rising_edge(clk) THEN
                IF RotB = '1' THEN
                    RST_GAME <= '1';
                ELSE
                    RST_GAME <= '0';
                END IF;
            END IF;
        END PROCESS;

    -- Ball Movement
    PROCESS (clk_2Hz_i)
        VARIABLE cballX        : INTEGER RANGE 0 TO 620 := 1;
        VARIABLE cballY        : INTEGER RANGE 0 TO 460 := 1;
        VARIABLE ballKierunekX : std_logic := '1';
        VARIABLE ballKierunekY : std_logic := '0';
        BEGIN
            IF rising_edge(clk_2Hz_i) THEN

                IF RST_GAME = '1' OR GAME_OVER = '1' THEN
                    cballX        := racketX + RACKET_W;
                    cballY        := 460 - RACKET_H - BALL_H * 2;
                    ballKierunekX := '0';
                    ballKierunekY := '1';
                    ballX     <= cballX;
                    ballY     <= cballY;
                    blocks    <= X"FFFF";
                    GAME_OVER <= '0';
                ELSE
                    IF ballKierunekX = '1' THEN
                        cballX := cballX + 2;
                        ballX <= cballX;
                    ELSE
                        cballX := cballX - 2;
                        ballX <= cballX;
                    END IF;
                    IF ballKierunekY = '1' THEN
                        cballY := cballY + 1;
                        ballY <= cballY;
                    ELSE
                        cballY := cballY - 1;
                        ballY <= cballY;
                    END IF;

                    IF cballX >= 620 - 15 OR cballX <= 0 THEN
                        ballKierunekX := NOT ballKierunekX;
                    END IF;

                    IF cballY <= 0 THEN
                        ballKierunekY := NOT ballKierunekY;
                    END IF;

                    IF cballY >= 460 - RACKET_Y - RACKET_H THEN
                        IF cballX >= racketX AND cballX < racketX + 50 THEN
                            ballKierunekY := NOT ballKierunekY;
                            ballKierunekX := '0';
                        ELSIF cballX >= racketX + 50 AND cballX < racketX + 100 THEN
                            ballKierunekY := NOT ballKierunekY;
                            ballKierunekX := '1';
                        ELSE
                            GAME_OVER <= '1';
                        END IF;
                    END IF;

                    FOR c IN 0 TO 3 LOOP
                        FOR r IN 0 TO 3 LOOP
                            IF NOT (
                             NOT (cballX >= 50 + (BLOCK_SPAN_X * c) AND cballX < 50 + (BLOCK_SPAN_X * c) + BLOCK_W)
                             AND NOT (cballX + BALL_W >= 50 + (BLOCK_SPAN_X * c) AND cballX + BALL_W < 50 + (BLOCK_SPAN_X * c) + BLOCK_W)
                             )
                             AND
                             NOT (
                             NOT (cballY >= 50 + (BLOCK_SPAN_Y * r) AND cballY < 50 + (BLOCK_SPAN_Y * r) + BLOCK_H)
                             AND NOT (cballY + BALL_H >= 50 + (BLOCK_SPAN_Y * r) AND cballY + BALL_H < 50 + (BLOCK_SPAN_Y * r) + BLOCK_H)
                             )
                             AND
                             blocks(r * 4 + c) = '1' THEN
                                blocks(r * 4 + c) <= '0';
                                ballKierunekY := NOT ballKierunekY;
                            END IF;
                            END LOOP;
                        END LOOP;
                    END IF;
                END IF;
            END PROCESS;

--------------------------------------------------------------------------------
-- Drawing ---------------------------------------------------------------------
--------------------------------------------------------------------------------

    PROCESS (x, y, blocks)
        VARIABLE pseudoRgb : std_logic_vector(2 DOWNTO 0);
        BEGIN
            pseudoRgb := "000";

            IF xint >= ballX AND xint < ballX + BALL_W THEN
                IF yint >= ballY AND yint < ballY + BALL_H THEN
                    pseudoRgb(2) := '1';
                    pseudoRgb(1) := '0';
                    pseudoRgb(0) := '1';
                END IF;
            END IF;

            IF xint >= 0 AND xint < 2 THEN
                IF yint >= 0 AND yint < 460 THEN
                    pseudoRgb(2) := '1';
                    pseudoRgb(1) := '1';
                    pseudoRgb(0) := '1';
                END IF;
            END IF;

            IF xint >= 618 AND xint < 620 THEN
                IF yint >= 0 AND yint < 460 THEN
                    pseudoRgb(2) := '1';
                    pseudoRgb(1) := '1';
                    pseudoRgb(0) := '1';
                END IF;
            END IF;

            IF xint >= 0 AND xint < 620 THEN
                IF yint >= 0 AND yint < 2 THEN
                    pseudoRgb(2) := '1';
                    pseudoRgb(1) := '1';
                    pseudoRgb(0) := '1';
                END IF;
            END IF;

            IF yint >= 460 - RACKET_H AND yint < 460 THEN
                IF xint >= racketX AND xint < racketX + RACKET_W THEN
                    pseudoRgb(2) := '1';
                    pseudoRgb(1) := '0';
                    pseudoRgb(0) := '0';
                END IF;
                IF xint >= racketX + RACKET_W AND xint < racketX + RACKET_W * 2 THEN
                    pseudoRgb(2) := '0';
                    pseudoRgb(1) := '1';
                    pseudoRgb(0) := '1';
                END IF;
            END IF;

            FOR c IN 0 TO 3 LOOP
                FOR r IN 0 TO 3 LOOP
                    IF xint >= 50 + (BLOCK_SPAN_X * c) AND xint < 50 + (BLOCK_SPAN_X * c) + BLOCK_W AND
                     yint >= 50 + (BLOCK_SPAN_Y * r) AND yint < 50 + (BLOCK_SPAN_Y * r) + BLOCK_H AND blocks(r * 4 + c) = '1' THEN
                        pseudoRgb(2) := '0';
                        pseudoRgb(1) := '1';
                        pseudoRgb(0) := '0';
                    END IF;
                    END LOOP;
                END LOOP;

                rgb(2) <= pseudoRgb(2);
                rgb(1) <= pseudoRgb(1);
                rgb(0) <= pseudoRgb(0);

            END PROCESS;

            xint <= to_integer(unsigned(x));
            yint <= to_integer(unsigned(y));

END Behavioral;
