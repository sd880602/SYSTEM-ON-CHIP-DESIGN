-- -------------------------------------------------------------
-- 
-- File Name: D:\GSLAB\FPGA_LinearRegression\G01-SourceCode\codegen\linearRegression_LeastSquares\hdlsrc\linearRegression_LeastSquares_fixpt.vhd
-- Created: 2022-05-07 22:24:30
-- 
-- Generated by MATLAB 9.11, MATLAB Coder 5.3 and HDL Coder 3.19
-- 
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Design base rate: 1
-- 
-- 
-- Clock Enable  Sample Time
-- -------------------------------------------------------------
-- ce_out        1
-- -------------------------------------------------------------
-- 
-- 
-- Output Signal                 Clock Enable  Sample Time
-- -------------------------------------------------------------
-- m                             ce_out        1
-- b                             ce_out        1
-- -------------------------------------------------------------
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: linearRegression_LeastSquares_fixpt
-- Source Path: linearRegression_LeastSquares_fixpt
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.linearRegression_LeastSquares_fixpt_pkg.ALL;

ENTITY linearRegression_LeastSquares_fixpt IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        Sum_x                             :   IN    std_logic_vector(13 DOWNTO 0);  -- sfix14
        Sum_y                             :   IN    std_logic_vector(13 DOWNTO 0);  -- sfix14
        Sum_xy                            :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23
        Sum_xx                            :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23
        ce_out                            :   OUT   std_logic;
        m                                 :   OUT   std_logic_vector(23 DOWNTO 0);  -- sfix24_En13
        b                                 :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En4
        );
END linearRegression_LeastSquares_fixpt;


ARCHITECTURE rtl OF linearRegression_LeastSquares_fixpt IS

  -- Constants
  CONSTANT C_divbyzero_p                  : signed(46 DOWNTO 0) := 
    signed'("01111111111111111111111111111111111111111111111");  -- sfix47
  CONSTANT C_divbyzero_n                  : signed(46 DOWNTO 0) := 
    signed'("10000000000000000000000000000000000000000000000");  -- sfix47

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL Sum_x_signed                     : signed(13 DOWNTO 0);  -- sfix14
  SIGNAL Sum_xx_signed                    : signed(22 DOWNTO 0);  -- sfix23
  SIGNAL tmp                              : signed(28 DOWNTO 0);  -- sfix29
  SIGNAL tmp_1                            : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL tmp_2                            : signed(27 DOWNTO 0);  -- sfix28
  SIGNAL tmp_3                            : signed(27 DOWNTO 0);  -- sfix28
  SIGNAL tmp_4                            : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL tmp_5                            : signed(27 DOWNTO 0);  -- sfix28
  SIGNAL tmp_6                            : signed(27 DOWNTO 0);  -- sfix28
  SIGNAL tmp_7                            : signed(22 DOWNTO 0);  -- sfix23
  SIGNAL tmp_8                            : std_logic;
  SIGNAL rd_1_reg                         : std_logic_vector(0 TO 1);  -- ufix1 [2]
  SIGNAL tmp_9                            : std_logic;
  SIGNAL Sum_y_signed                     : signed(13 DOWNTO 0);  -- sfix14
  SIGNAL Sum_xy_signed                    : signed(22 DOWNTO 0);  -- sfix23
  SIGNAL tmp_10                           : signed(28 DOWNTO 0);  -- sfix29
  SIGNAL tmp_11                           : signed(25 DOWNTO 0);  -- sfix26
  SIGNAL tmp_12                           : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL tmp_13                           : signed(27 DOWNTO 0);  -- sfix28
  SIGNAL tmp_14                           : signed(25 DOWNTO 0);  -- sfix26
  SIGNAL tmp_15                           : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL tmp_16                           : signed(26 DOWNTO 0);  -- sfix27
  SIGNAL tmp_17                           : signed(22 DOWNTO 0);  -- sfix23
  SIGNAL c_10                             : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL p0c_div_temp                     : signed(46 DOWNTO 0);  -- sfix47_En24
  SIGNAL p0c_slice_cast                   : signed(46 DOWNTO 0);  -- sfix47_En24
  SIGNAL p0c_slice_cast_1                 : signed(46 DOWNTO 0);  -- sfix47_En24
  SIGNAL p0c_cast                         : signed(46 DOWNTO 0);  -- sfix47_En24
  SIGNAL rd_2_reg                         : vector_of_signed46(0 TO 1);  -- sfix46 [2]
  SIGNAL c_11                             : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL tmp_18                           : std_logic;
  SIGNAL tmp_19                           : std_logic;
  SIGNAL c_12                             : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL c_13                             : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL c_14                             : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL c_15                             : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL tmp_20                           : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL c_16                             : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL tmp_21                           : signed(45 DOWNTO 0);  -- sfix46_En24
  SIGNAL tmp_22                           : signed(23 DOWNTO 0);  -- sfix24_En13
  SIGNAL m_1                              : signed(23 DOWNTO 0);  -- sfix24_En13
  SIGNAL rd_10_reg                        : vector_of_signed24(0 TO 1);  -- sfix24 [2]
  SIGNAL m_tmp                            : signed(23 DOWNTO 0);  -- sfix24_En13
  SIGNAL tmp_23                           : signed(24 DOWNTO 0);  -- sfix25
  SIGNAL rd_7_reg                         : vector_of_signed25(0 TO 3);  -- sfix25 [4]
  SIGNAL tmp_24                           : signed(24 DOWNTO 0);  -- sfix25
  SIGNAL rd_0_reg                         : vector_of_signed14(0 TO 2);  -- sfix14 [3]
  SIGNAL Sum_x_1                          : signed(13 DOWNTO 0);  -- sfix14
  SIGNAL tmp_25                           : signed(37 DOWNTO 0);  -- sfix38_En13
  SIGNAL tmp_26                           : signed(23 DOWNTO 0);  -- sfix24
  SIGNAL tmp_27                           : signed(24 DOWNTO 0);  -- sfix25
  SIGNAL tmp_28                           : signed(24 DOWNTO 0);  -- sfix25
  SIGNAL tmp_29                           : signed(24 DOWNTO 0);  -- sfix25
  SIGNAL tmp_30                           : signed(23 DOWNTO 0);  -- sfix24
  SIGNAL tmp_31                           : signed(27 DOWNTO 0);  -- sfix28_En4
  SIGNAL c_23                             : signed(27 DOWNTO 0);  -- sfix28_En4
  SIGNAL tmp_32                           : signed(23 DOWNTO 0);  -- sfix24_En4
  SIGNAL b_tmp                            : signed(23 DOWNTO 0);  -- sfix24_En4

BEGIN
  Sum_x_signed <= signed(Sum_x);

  Sum_xx_signed <= signed(Sum_xx);

  -- 'linearRegression_LeastSquares_fixpt:14' buf13 = fi(fi(16, 1, 6, 0, fm)*Sum_xx, 1, 27, 0, fm);
  tmp <= resize(Sum_xx_signed & '0' & '0' & '0' & '0', 29);

  tmp_1 <= tmp(26 DOWNTO 0);

  -- 'linearRegression_LeastSquares_fixpt:19' buf22 = fi(buf13 - buf14, 1, 23, 0, fm);
  tmp_2 <= resize(tmp_1, 28);

  -- 'linearRegression_LeastSquares_fixpt:15' buf14 = fi(Sum_x*Sum_x, 1, 27, 0, fm);
  tmp_3 <= Sum_x_signed * Sum_x_signed;

  tmp_4 <= tmp_3(26 DOWNTO 0);

  tmp_5 <= resize(tmp_4, 28);

  tmp_6 <= tmp_2 - tmp_5;

  -- 'linearRegression_LeastSquares_fixpt:57' b1 = fi( b, 'RoundMode', 'fix' );
  tmp_7 <= tmp_6(22 DOWNTO 0);

  -- 'linearRegression_LeastSquares_fixpt:58' nType = divideType( a1, b1 );
  -- 
  -- 'linearRegression_LeastSquares_fixpt:59' if isfi( a ) && isfi( b ) && isscalar( b )
  -- 
  -- 'linearRegression_LeastSquares_fixpt:60' c1 = divide( nType, a1, b1 );
  
  tmp_8 <= '1' WHEN tmp_7 = to_signed(16#000000#, 23) ELSE
      '0';

  enb <= clk_enable;

  rd_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_1_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_1_reg(0) <= tmp_8;
        rd_1_reg(1) <= rd_1_reg(0);
      END IF;
    END IF;
  END PROCESS rd_1_process;

  tmp_9 <= rd_1_reg(1);

  Sum_y_signed <= signed(Sum_y);

  Sum_xy_signed <= signed(Sum_xy);

  -- HDL code generation from MATLAB function: linearRegression_LeastSquares_fixpt
  -- 
  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  -- 
  --                                                                          %
  -- 
  --          Generated by MATLAB 9.11 and Fixed-Point Designer 7.3           %
  -- 
  --                                                                          %
  -- 
  -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  -- 
  -- stage 1
  -- 
  -- 'linearRegression_LeastSquares_fixpt:10' fm = get_fimath();
  -- 
  -- 'linearRegression_LeastSquares_fixpt:12' buf11 = fi(fi(16, 1, 6, 0, fm)*Sum_xy, 1, 26, 0, fm);
  tmp_10 <= resize(Sum_xy_signed & '0' & '0' & '0' & '0', 29);

  tmp_11 <= tmp_10(25 DOWNTO 0);

  -- stage 2
  -- 
  -- 'linearRegression_LeastSquares_fixpt:18' buf21 = fi(buf11 - buf12, 1, 23, 0, fm);
  tmp_12 <= resize(tmp_11, 27);

  -- 'linearRegression_LeastSquares_fixpt:13' buf12 = fi(Sum_x*Sum_y, 1, 26, 0, fm);
  tmp_13 <= Sum_x_signed * Sum_y_signed;

  tmp_14 <= tmp_13(25 DOWNTO 0);

  tmp_15 <= resize(tmp_14, 27);

  tmp_16 <= tmp_12 - tmp_15;

  -- stage 3 , calculate m
  -- 
  -- 'linearRegression_LeastSquares_fixpt:22' m = fi(fi_div(buf21, buf22), 1, 24, 13, fm) ;
  -- 
  -- 'linearRegression_LeastSquares_fixpt:55' coder.inline( 'always' );
  -- 
  -- 'linearRegression_LeastSquares_fixpt:56' a1 = fi( a, 'RoundMode', 'fix' );
  tmp_17 <= tmp_16(22 DOWNTO 0);

  -- HDL code generation from MATLAB function: linearRegression_LeastSquares_fixpt_falseregionp50
  p0c_slice_cast <= tmp_17 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';
  
  p0c_slice_cast_1 <= C_divbyzero_p WHEN p0c_slice_cast(46) = tmp_7(22) ELSE
      C_divbyzero_n;
  p0c_cast <= tmp_17 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0';
  
  p0c_div_temp <= p0c_slice_cast_1 WHEN tmp_7 = 0 ELSE
      p0c_cast / tmp_7;
  c_10 <= p0c_div_temp(45 DOWNTO 0);

  rd_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_2_reg <= (OTHERS => to_signed(0, 46));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_2_reg(0) <= c_10;
        rd_2_reg(1) <= rd_2_reg(0);
      END IF;
    END IF;
  END PROCESS rd_2_process;

  c_11 <= rd_2_reg(1);

  
  tmp_18 <= '1' WHEN tmp_17 < to_signed(16#000000#, 23) ELSE
      '0';

  rd_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tmp_19 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        tmp_19 <= tmp_18;
      END IF;
    END IF;
  END PROCESS rd_5_process;


  -- HDL code generation from MATLAB function: linearRegression_LeastSquares_fixpt_falseregionp54
  c_12 <= signed'("0111111111111111111111111111111111111111111111");

  rd_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      c_13 <= to_signed(0, 46);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        c_13 <= c_12;
      END IF;
    END IF;
  END PROCESS rd_4_process;


  -- HDL code generation from MATLAB function: linearRegression_LeastSquares_fixpt_trueregionp54
  c_14 <= signed'("1000000000000000000000000000000000000000000000");

  rd_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      c_15 <= to_signed(0, 46);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        c_15 <= c_14;
      END IF;
    END IF;
  END PROCESS rd_3_process;


  -- HDL code generation from MATLAB function: linearRegression_LeastSquares_fixpt_trueregionp50
  
  tmp_20 <= c_13 WHEN tmp_19 = '0' ELSE
      c_15;

  rd_11_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      c_16 <= to_signed(0, 46);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        c_16 <= tmp_20;
      END IF;
    END IF;
  END PROCESS rd_11_process;


  -- 'linearRegression_LeastSquares_fixpt:61' c = fi( c1, numerictype( c1 ), fimath( a ) );
  
  tmp_21 <= c_11 WHEN tmp_9 = '0' ELSE
      c_16;

  tmp_22 <= tmp_21(34 DOWNTO 11);

  rd_9_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      m_1 <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        m_1 <= tmp_22;
      END IF;
    END IF;
  END PROCESS rd_9_process;


  rd_10_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_10_reg <= (OTHERS => to_signed(16#000000#, 24));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_10_reg(0) <= m_1;
        rd_10_reg(1) <= rd_10_reg(0);
      END IF;
    END IF;
  END PROCESS rd_10_process;

  m_tmp <= rd_10_reg(1);

  m <= std_logic_vector(m_tmp);

  -- stage 5
  -- 
  -- 'linearRegression_LeastSquares_fixpt:28' buf41 = fi(Sum_y - buf31, 1, 24, 0, fm);
  tmp_23 <= resize(Sum_y_signed, 25);

  rd_7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_7_reg <= (OTHERS => to_signed(16#0000000#, 25));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_7_reg(0) <= tmp_23;
        rd_7_reg(1 TO 3) <= rd_7_reg(0 TO 2);
      END IF;
    END IF;
  END PROCESS rd_7_process;

  tmp_24 <= rd_7_reg(3);

  rd_0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_0_reg <= (OTHERS => to_signed(16#0000#, 14));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_0_reg(0) <= Sum_x_signed;
        rd_0_reg(1 TO 2) <= rd_0_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS rd_0_process;

  Sum_x_1 <= rd_0_reg(2);

  -- stage 4
  -- 
  -- 'linearRegression_LeastSquares_fixpt:25' buf31 = fi(m*Sum_x, 1, 24, 0, fm);
  tmp_25 <= m_1 * Sum_x_1;

  tmp_26 <= tmp_25(36 DOWNTO 13);

  tmp_27 <= resize(tmp_26, 25);

  rd_8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      tmp_28 <= to_signed(16#0000000#, 25);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        tmp_28 <= tmp_27;
      END IF;
    END IF;
  END PROCESS rd_8_process;


  tmp_29 <= tmp_24 - tmp_28;

  tmp_30 <= tmp_29(23 DOWNTO 0);

  -- stage 6
  -- 
  -- 'linearRegression_LeastSquares_fixpt:31' b = fi(fi_div_by_shift(buf41, 4), 1, 24, 4, fm);
  -- 
  -- 'linearRegression_LeastSquares_fixpt:69' coder.inline( 'always' );
  -- 
  -- 'linearRegression_LeastSquares_fixpt:70' if isfi( a )
  -- 
  -- 'linearRegression_LeastSquares_fixpt:71' nt = numerictype( a );
  -- 
  -- 'linearRegression_LeastSquares_fixpt:72' fm = fimath( a );
  -- 
  -- 'linearRegression_LeastSquares_fixpt:73' nt_bs = numerictype( nt.Signed, nt.WordLength + shift_len, nt.FractionLength 
  -- + shift_len )
  -- 
  -- 'linearRegression_LeastSquares_fixpt:74' y = bitsra( fi( a, nt_bs, fm ), shift_len );
  tmp_31 <= tmp_30 & '0' & '0' & '0' & '0';

  c_23 <= SHIFT_RIGHT(tmp_31, 4);

  tmp_32 <= c_23(23 DOWNTO 0);

  rd_6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      b_tmp <= to_signed(16#000000#, 24);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        b_tmp <= tmp_32;
      END IF;
    END IF;
  END PROCESS rd_6_process;


  b <= std_logic_vector(b_tmp);

  ce_out <= clk_enable;

END rtl;

