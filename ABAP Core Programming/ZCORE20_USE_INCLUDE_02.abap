*&---------------------------------------------------------------------*
*& Report ZCORE20_USE_INCLUDE_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcore20_use_include_02.

WRITE:/ 'Inside ZCORE20_USE_INCLUDE_02'.
SKIP.

INCLUDE zcore20_include_program_02.

START-OF-SELECTION. "needed because include program 02 has a module

  PERFORM sub1.