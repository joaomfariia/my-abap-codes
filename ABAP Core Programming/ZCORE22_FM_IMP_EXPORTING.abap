*&---------------------------------------------------------------------*
*& Report ZCORE22_FM_IMP_EXPORTING
*&---------------------------------------------------------------------*
*& Calling a F.M and Returning Values
*&---------------------------------------------------------------------*
REPORT zcore22_fm_imp_exporting.

PARAMETERS: p_x TYPE i,
            p_y TYPE i.

DATA: gv_sum  TYPE i,
      gv_diff TYPE i,
      gv_div  TYPE i.

DATA: gv_y TYPE i.

************************************************************************
*** Calling the F.M 02                                               ***
************************************************************************

CALL FUNCTION 'ZCORE22_FM_02'
  EXPORTING
    i_x    = p_x
    i_y    = p_y
  IMPORTING
    e_sum  = gv_sum
    e_diff = gv_diff.

WRITE:/ 'Sum is', gv_sum,
      / 'Diff is', gv_diff.


************************************************************************
*** Calling the F.M 03                                               ***
************************************************************************

gv_y = p_y.

CALL FUNCTION 'ZCORE22_FM_03'
  EXPORTING
    i_x = p_x
  CHANGING
    c_y = gv_y.

WRITE: / 'Sum is (changing parameter):', gv_y.

************************************************************************
*** Calling the F.M 04                                               ***
************************************************************************

CALL FUNCTION 'ZCORE22_FM_04'
  EXPORTING
    i_x         = p_x
    i_y         = p_y
  IMPORTING
    i_r         = gv_div
  EXCEPTIONS
    zero_divide = 1
    OTHERS      = 2.

IF sy-subrc EQ 0.
  WRITE: / 'Division is', gv_div.

ELSEIF sy-subrc = 1.
  WRITE: / 'Cannot divide by zero!'.

ELSEIF sy-subrc = 2.
  WRITE: / 'Unknown error..'.

ENDIF.