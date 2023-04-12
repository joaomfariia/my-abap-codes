*&---------------------------------------------------------------------*
*& Report ZCORE10_SUBMIT_RETURN_MEMORY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcore10_submit_return_memory_3.

*-------------------------------------------
*	Calls program ZCORE09_LOOPING_STATEMENTS
*-------------------------------------------

SUBMIT zcore09_looping_statements  " Product table number program
  with p_x = 5.                    " changes the parameter value