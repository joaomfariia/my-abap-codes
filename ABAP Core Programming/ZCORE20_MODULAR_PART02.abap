*&---------------------------------------------------------------------*
*& Report ZCORE20_MODULAR_PART02
*&---------------------------------------------------------------------*
*& Calling External Subroutines
*&---------------------------------------------------------------------*
REPORT zcore20_modular_part02.

FORMAT COLOR 3.
WRITE: / 'Inside program part02...'.
FORMAT COLOR OFF.
SKIP.

************************************************************************
*** Two Syntaxes of Perform                                          ***
************************************************************************

WRITE:/ 'First Call Syntax:'.
PERFORM sub1 IN PROGRAM zcore20_modular_part02_02. " or
SKIP.

WRITE:/ 'Second Call Syntax:'.
PERFORM sub1(zcore20_modular_part02_02).
ULINE.

PERFORM sub2 IN PROGRAM zcore20_modular_part02_02 USING 10 20.
ULINE.

PERFORM sub2(zcore20_modular_part02_02) USING 15 25.
ULINE.

************************************************************************
*** Calling a Subroutine Pool                                        ***
************************************************************************

WRITE:/ 'Calling from the Subroutine Pool:'.
SKIP.

PERFORM sub1 IN PROGRAM zcore20_subroutine_pool. "or
PERFORM sub1(zcore20_subroutine_pool).
ULINE.

WRITE:/ 'Calling another subroutine:'.
SKIP.

PERFORM sub2(zcore20_subroutine_pool) USING 20 20.
PERFORM sub3(zcore20_subroutine_pool) USING 50 15.