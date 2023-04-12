*&---------------------------------------------------------------------*
*& Report ZCORE20_MODULAR_PART02_02
*&---------------------------------------------------------------------*
*& External Program containing External Subroutine
*&---------------------------------------------------------------------*
REPORT zcore20_modular_part02_02.

DATA: gv_x TYPE i,
      gv_y TYPE i.

PERFORM sub1.
ULINE.

PERFORM sub2 USING gv_x gv_y.

************************************************************************
*** Subroutine Definition                                            ***
************************************************************************

FORM sub1.

  WRITE: / 'Inside subroutine sub1 in zcore20_modular_part02_02'.

ENDFORM.

FORM sub2 USING k1 k2.

  WRITE: / 'Inside subroutine sub2 in zcore20_modular_part02_02'.
  SKIP.

  DATA: lv_result TYPE i.
  lv_result = k1 + k2.

  WRITE: / 'Sum is:', lv_result.
  SKIP.
  WRITE: / 'End of subroutine sub2.'.

ENDFORM.