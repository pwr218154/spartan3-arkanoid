<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan3e" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1(2:0)" />
        <signal name="VGA_R" />
        <signal name="VGA_G" />
        <signal name="VGA_B" />
        <signal name="VGA_HS" />
        <signal name="VGA_VS" />
        <signal name="XLXN_5" />
        <signal name="XLXN_4" />
        <signal name="ROT_A" />
        <signal name="ROT_B" />
        <signal name="Clk_50MHz" />
        <signal name="XLXN_14(2:0)" />
        <signal name="XLXN_15(9:0)" />
        <signal name="XLXN_16(9:0)" />
        <signal name="ROT_CENTER" />
        <port polarity="Output" name="VGA_R" />
        <port polarity="Output" name="VGA_G" />
        <port polarity="Output" name="VGA_B" />
        <port polarity="Output" name="VGA_HS" />
        <port polarity="Output" name="VGA_VS" />
        <port polarity="Input" name="ROT_A" />
        <port polarity="Input" name="ROT_B" />
        <port polarity="Input" name="Clk_50MHz" />
        <port polarity="Input" name="ROT_CENTER" />
        <blockdef name="VGA_DRIVER">
            <timestamp>2017-3-24T11:29:32</timestamp>
            <rect width="256" x="64" y="-448" height="448" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-416" y2="-416" x1="320" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="RotaryEnc">
            <timestamp>2017-3-31T10:54:17</timestamp>
            <rect width="256" x="64" y="-256" height="192" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="FrameBuffer">
            <timestamp>2017-5-26T10:45:45</timestamp>
            <rect width="256" x="64" y="-384" height="384" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="VGA_DRIVER" name="XLXI_1">
            <blockpin signalname="Clk_50MHz" name="clk" />
            <blockpin signalname="XLXN_14(2:0)" name="rgb(2:0)" />
            <blockpin signalname="VGA_R" name="rout" />
            <blockpin signalname="VGA_G" name="gout" />
            <blockpin signalname="VGA_B" name="bout" />
            <blockpin signalname="VGA_HS" name="hs" />
            <blockpin signalname="VGA_VS" name="vs" />
            <blockpin signalname="XLXN_15(9:0)" name="x(9:0)" />
            <blockpin signalname="XLXN_16(9:0)" name="y(9:0)" />
        </block>
        <block symbolname="RotaryEnc" name="XLXI_4">
            <blockpin signalname="ROT_A" name="ROT_A" />
            <blockpin signalname="ROT_B" name="ROT_B" />
            <blockpin signalname="XLXN_4" name="RotL" />
            <blockpin signalname="XLXN_5" name="RotR" />
            <blockpin signalname="Clk_50MHz" name="Clk" />
        </block>
        <block symbolname="FrameBuffer" name="XLXI_14">
            <blockpin signalname="XLXN_4" name="RotL" />
            <blockpin signalname="XLXN_5" name="RotR" />
            <blockpin signalname="ROT_CENTER" name="RotB" />
            <blockpin signalname="Clk_50MHz" name="clk" />
            <blockpin signalname="XLXN_16(9:0)" name="y(9:0)" />
            <blockpin signalname="XLXN_15(9:0)" name="x(9:0)" />
            <blockpin name="clk_out" />
            <blockpin signalname="XLXN_14(2:0)" name="rgb(2:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="VGA_R">
            <wire x2="2144" y1="1008" y2="1008" x1="2112" />
        </branch>
        <iomarker fontsize="28" x="2144" y="1008" name="VGA_R" orien="R0" />
        <branch name="VGA_G">
            <wire x2="2144" y1="1072" y2="1072" x1="2112" />
        </branch>
        <iomarker fontsize="28" x="2144" y="1072" name="VGA_G" orien="R0" />
        <branch name="VGA_B">
            <wire x2="2144" y1="1136" y2="1136" x1="2112" />
        </branch>
        <iomarker fontsize="28" x="2144" y="1136" name="VGA_B" orien="R0" />
        <branch name="VGA_HS">
            <wire x2="2144" y1="1200" y2="1200" x1="2112" />
        </branch>
        <iomarker fontsize="28" x="2144" y="1200" name="VGA_HS" orien="R0" />
        <branch name="VGA_VS">
            <wire x2="2144" y1="1264" y2="1264" x1="2112" />
        </branch>
        <iomarker fontsize="28" x="2144" y="1264" name="VGA_VS" orien="R0" />
        <branch name="XLXN_5">
            <wire x2="1168" y1="1648" y2="1648" x1="976" />
        </branch>
        <instance x="592" y="1808" name="XLXI_4" orien="R0">
        </instance>
        <branch name="XLXN_4">
            <wire x2="1168" y1="1584" y2="1584" x1="976" />
        </branch>
        <branch name="ROT_A">
            <wire x2="592" y1="1584" y2="1584" x1="560" />
        </branch>
        <iomarker fontsize="28" x="560" y="1584" name="ROT_A" orien="R180" />
        <branch name="ROT_B">
            <wire x2="592" y1="1648" y2="1648" x1="560" />
        </branch>
        <iomarker fontsize="28" x="560" y="1648" name="ROT_B" orien="R180" />
        <iomarker fontsize="28" x="544" y="1008" name="Clk_50MHz" orien="R180" />
        <instance x="1728" y="1424" name="XLXI_1" orien="R0">
        </instance>
        <branch name="Clk_50MHz">
            <wire x2="576" y1="1008" y2="1008" x1="544" />
            <wire x2="576" y1="1008" y2="1712" x1="576" />
            <wire x2="592" y1="1712" y2="1712" x1="576" />
            <wire x2="992" y1="1008" y2="1008" x1="576" />
            <wire x2="1728" y1="1008" y2="1008" x1="992" />
            <wire x2="992" y1="1008" y2="1776" x1="992" />
            <wire x2="1168" y1="1776" y2="1776" x1="992" />
        </branch>
        <instance x="1168" y="1936" name="XLXI_14" orien="R0">
        </instance>
        <branch name="XLXN_14(2:0)">
            <wire x2="1632" y1="1904" y2="1904" x1="1552" />
            <wire x2="1632" y1="1392" y2="1904" x1="1632" />
            <wire x2="1728" y1="1392" y2="1392" x1="1632" />
        </branch>
        <branch name="XLXN_15(9:0)">
            <wire x2="1168" y1="1904" y2="1904" x1="1120" />
            <wire x2="1120" y1="1904" y2="1968" x1="1120" />
            <wire x2="2144" y1="1968" y2="1968" x1="1120" />
            <wire x2="2144" y1="1328" y2="1328" x1="2112" />
            <wire x2="2144" y1="1328" y2="1968" x1="2144" />
        </branch>
        <branch name="XLXN_16(9:0)">
            <wire x2="1168" y1="1840" y2="1840" x1="1104" />
            <wire x2="1104" y1="1840" y2="1984" x1="1104" />
            <wire x2="2176" y1="1984" y2="1984" x1="1104" />
            <wire x2="2176" y1="1392" y2="1392" x1="2112" />
            <wire x2="2176" y1="1392" y2="1984" x1="2176" />
        </branch>
        <iomarker fontsize="28" x="576" y="1840" name="ROT_CENTER" orien="R180" />
        <branch name="ROT_CENTER">
            <wire x2="1056" y1="1840" y2="1840" x1="576" />
            <wire x2="1056" y1="1712" y2="1840" x1="1056" />
            <wire x2="1168" y1="1712" y2="1712" x1="1056" />
        </branch>
    </sheet>
</drawing>