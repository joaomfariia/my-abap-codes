*&---------------------------------------------------------------------*
*& Report ZCORE20_USE_INCLUDE
*&---------------------------------------------------------------------*
*& Use Include Containing Variable Declarations
*& Include: ZCORE20_INCLUDE_PROGRAM
*&---------------------------------------------------------------------*
REPORT zcore20_use_include.

WRITE:/ 'Inside ZCORE20_USE_INCLUDE Program'.
SKIP.

INCLUDE zcore20_include_program.

* Variables from include
gv_x = 10.
gv_y = 20.
gv_z = gv_x + gv_y.

WRITE:/ 'Sum is', gv_z.