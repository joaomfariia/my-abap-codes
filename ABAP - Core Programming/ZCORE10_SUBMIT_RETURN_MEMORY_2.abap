*&---------------------------------------------------------------------*
*& Report ZCORE10_SUBMIT_RETURN_MEMORY
*&---------------------------------------------------------------------*
*& Program 01 make the I/O operations
*& Program 02 make all the calculations
*&---------------------------------------------------------------------*
REPORT zcore10_submit_return_memory_2.

*-------------------------------------------
*	Creates the variables from initial Program
*-------------------------------------------

DATA: p_x       TYPE i, " p_x from program 01
      p_y       TYPE i, " p_y from program 01
      gv_result TYPE i.

*-------------------------------------------
*	Importing the variables values from memory
*-------------------------------------------

IMPORT p_x FROM MEMORY ID 'M1'.
IMPORT p_y FROM MEMORY ID 'M2'.

*-------------------------------------------
*	Doing the calculation
*-------------------------------------------

gv_result = p_x + p_y.

*-------------------------------------------
*	Exporting to another memory ID
*-------------------------------------------

EXPORT gv_result TO MEMORY ID 'M3'.