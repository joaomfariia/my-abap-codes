*&---------------------------------------------------------------------*
*& Report ZCORE21_FUNCTION_MODULES
*&---------------------------------------------------------------------*
*& Calling Function Modules
*&---------------------------------------------------------------------*
REPORT zcore21_function_modules.

PARAMETERS: p_x TYPE i,
            p_y TYPE i.

DATA: gv_res TYPE i.

************************************************************************
*** FM01                                                             ***
************************************************************************

FORMAT COLOR 2.
WRITE:/ 'Function Modules Without Parameters'.
SKIP.
FORMAT COLOR OFF.

CALL FUNCTION 'ZCORE21_FM_01'.
ULINE.

************************************************************************
*** FM02                                                             ***
************************************************************************

FORMAT COLOR 3.
WRITE:/ 'Function Modules With Parameters'.
SKIP.
FORMAT COLOR OFF.

CALL FUNCTION 'ZCORE21_FM_02'
  EXPORTING
    number1 = p_x
    number2 = p_y
  IMPORTING
    result  = gv_res.