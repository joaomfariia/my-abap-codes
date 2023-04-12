*&---------------------------------------------------------------------*
*& Pool subrotinas  ZCORE20_SUBROUTINE_POOL
*&---------------------------------------------------------------------*
*& Subroutine Pool For External Subroutines
*&---------------------------------------------------------------------*
PROGRAM zcore20_subroutine_pool.

DATA: gv_result TYPE i.

************************************************************************
*** Subroutines Definition                                           ***
************************************************************************
FORM sub1.
  WRITE: / 'Inside subroutine sub1 of ZCORE20_SUBROUTINE_POOL'.
ENDFORM.

FORM sub2 USING x y.

  gv_result = x + y.
  WRITE: / 'Sum is', gv_result.

ENDFORM.

FORM sub3 USING x y.

  gv_result = x - y.
  WRITE: / 'Difference is', gv_result.

ENDFORM.