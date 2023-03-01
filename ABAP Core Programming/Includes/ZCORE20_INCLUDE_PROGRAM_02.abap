*&---------------------------------------------------------------------*
*& Include ZCORE20_INCLUDE_PROGRAM_02
*&---------------------------------------------------------------------*
*& Include Containing Variables and Subroutine Definitions
*&---------------------------------------------------------------------*

DATA: gv_x TYPE i,
      gv_y TYPE i,
      gv_z TYPE i.

gv_x = 16.
gv_y = 14.

FORM sub1.

  gv_z = gv_x + gv_y.
  WRITE:/ 'Sum is', gv_z.

ENDFORM.

FORM sub2.

  gv_z = gv_x - gv_y.
  WRITE:/ 'Difference is', gv_z.

ENDFORM.

MODULE abc OUTPUT.

  WRITE:/ 'Inside module abc...'.

ENDMODULE.