*&---------------------------------------------------------------------*
*& Report ZCORE19_MODULAR_PART01
*&---------------------------------------------------------------------*
*& Subroutines
*&---------------------------------------------------------------------*
REPORT zcore19_modular_part01.

DATA: gv_x TYPE i VALUE 15,
      gv_y TYPE i VALUE 10,
      gv_z TYPE i,
      gv_w TYPE i.

*-------------------------------------------
*	Calling Subroutines
*-------------------------------------------

PERFORM sub1.
ULINE.

PERFORM sub2 USING gv_x gv_y. " actual parameters

CLEAR: gv_x,
       gv_y.

gv_x = 28.
gv_y = 12.

PERFORM sub2 USING gv_x gv_y.
ULINE.

* Using previous variables to calculate new ones
PERFORM sub3 USING gv_x gv_y CHANGING gv_z gv_w.
ULINE.

WRITE: / 'Pass by reference'.
SKIP.
WRITE: / 'gv_x and gv_y before subroutine:', gv_x, gv_y.

PERFORM sub4 USING gv_x gv_y.
WRITE: / 'gv_x and gv_y after subroutine :', gv_x, gv_y.
ULINE.

CLEAR: gv_x,
       gv_y.

gv_x = 5.
gv_y = 25.

WRITE: / 'Pass by value'.
SKIP.
WRITE: / 'gv_x and gv_y before subroutine:', gv_x, gv_y.

PERFORM sub5 USING gv_x gv_y.
WRITE: / 'gv_x and gv_y after subroutine :', gv_x, gv_y.

*-------------------------------------------
*	Subroutines Definition
*-------------------------------------------

FORM sub1.

  WRITE: / 'My first subroutine.'.
  WRITE: / 'I am learning a lot.'.
  WRITE: / 'Core ABAP'.

ENDFORM.

FORM sub2 USING k1 k2.  " formal parameters

  DATA: lv_r TYPE i.    " local variable

  lv_r = gv_x + gv_y.
  WRITE: / 'Sum is:', lv_r.

ENDFORM.

FORM sub3 USING k1 k2 CHANGING m1 m2.

  m1 = k1 + k2.
  m2 = k1 - k2.
  WRITE: / 'Sum is:', m1,
         / 'Difference is:', m2.

ENDFORM.

FORM sub4 USING k1 k2.

  DATA: k3 TYPE i.

  k3 = k1.
  k1 = k2.
  k2 = k3.

ENDFORM.

* Changes made to formal parameters do not affect actual parameters
FORM sub5 USING VALUE(k1) VALUE(k2).

  DATA: k3 TYPE i.

  k3 = k1.
  k1 = k2.
  k2 = k3.

ENDFORM.