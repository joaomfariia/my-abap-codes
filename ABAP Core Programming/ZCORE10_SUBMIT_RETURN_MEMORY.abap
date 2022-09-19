*&---------------------------------------------------------------------*
*& Report ZCORE10_SUBMIT_RETURN_MEMORY
*&---------------------------------------------------------------------*
*& Program 01 make the I/O operations
*& Program 02 make all the calculations
*&---------------------------------------------------------------------*
REPORT zcore10_submit_return_memory.

*-------------------------------------------
*	I/O Operations and Parameters
*-------------------------------------------

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_x TYPE i DEFAULT 15 OBLIGATORY,
              p_y TYPE i DEFAULT 10 OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.

*-------------------------------------------
*	Exporting the variables to memory IDs
*-------------------------------------------

EXPORT p_x TO MEMORY ID 'M1'. " memory lifetime = during this particular session
EXPORT p_y TO MEMORY ID 'M2'.

*-------------------------------------------
*	Calls program 02 which make calculations
*-------------------------------------------

SUBMIT zcore10_submit_return_memory_2 AND RETURN.

DATA: gv_result TYPE i. " variable from target program

*-------------------------------------------
*	Importing the variable from memory ID
*-------------------------------------------

IMPORT gv_result FROM MEMORY ID 'M3'.

WRITE: / 'The sum is:', gv_result.