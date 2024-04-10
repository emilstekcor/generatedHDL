-- -------------------------------------------------------------
-- 
-- File Name: C:\Users\kyle\Desktop\Encoder_decoder\commrshdl\MATLAB_Function.vhd
-- Created: 2024-04-06 17:18:32
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: MATLAB_Function
-- Source Path: commrshdl/RS Subsystem/ErrorGen/MATLAB Function
-- Hierarchy Level: 2
-- Model version: 9.4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.RS_Subsystem_pkg.ALL;

ENTITY MATLAB_Function IS
  PORT( sig                               :   IN    std_logic_vector(7 DOWNTO 0);  -- uint8
        validIn                           :   IN    std_logic;
        loc                               :   IN    vector_of_std_logic_vector8(0 TO 3);  -- uint8 [4]
        out_rsvd                          :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
        );
END MATLAB_Function;


ARCHITECTURE rtl OF MATLAB_Function IS

  -- Functions
  -- HDLCODER_TO_UNSIGNED
  FUNCTION hdlcoder_to_unsigned(arg: boolean; width: integer) RETURN unsigned IS
  BEGIN
    IF arg THEN
      RETURN to_unsigned(1, width);
    ELSE
      RETURN to_unsigned(0, width);
    END IF;
  END FUNCTION;


  -- Signals
  SIGNAL sig_unsigned                     : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL loc_unsigned                     : vector_of_unsigned8(0 TO 3);  -- uint8 [4]
  SIGNAL out_tmp                          : unsigned(7 DOWNTO 0);  -- uint8

BEGIN
  sig_unsigned <= unsigned(sig);

  outputgen: FOR k IN 0 TO 3 GENERATE
    loc_unsigned(k) <= unsigned(loc(k));
  END GENERATE;

  MATLAB_Function_1_output : PROCESS (loc_unsigned, sig_unsigned, validIn)
    VARIABLE out_rsvd1 : unsigned(7 DOWNTO 0);
    VARIABLE sub_cast : vector_of_signed9(0 TO 3);
    VARIABLE sub_temp : vector_of_signed9(0 TO 3);
    VARIABLE cast : vector_of_unsigned8(0 TO 3);
  BEGIN
    out_rsvd1 := to_unsigned(16#00#, 8);
    IF validIn = '1' THEN 
      FOR i IN 0 TO 3 LOOP
        sub_cast(i) := signed(resize(loc_unsigned(i), 9));
        sub_temp(i) := sub_cast(i) - to_signed(16#001#, 9);
        IF sub_temp(i)(8) = '1' THEN 
          cast(i) := "00000000";
        ELSE 
          cast(i) := unsigned(sub_temp(i)(7 DOWNTO 0));
        END IF;
        IF cast(i) = sig_unsigned THEN 
          out_rsvd1 := to_unsigned(16#01#, 8);
        ELSE 
          out_rsvd1 := hdlcoder_to_unsigned(out_rsvd1 /= to_unsigned(16#00000000#, 8), 8);
        END IF;
      END LOOP;
    END IF;
    out_tmp <= out_rsvd1;
  END PROCESS MATLAB_Function_1_output;


  out_rsvd <= std_logic_vector(out_tmp);

END rtl;

