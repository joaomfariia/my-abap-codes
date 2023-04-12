*&---------------------------------------------------------------------*
*& Report ZCORE09_LOOPING_STATEMENTS
*&---------------------------------------------------------------------*
*& Looping Statements
*&---------------------------------------------------------------------*
REPORT zcore09_looping_statements.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_x TYPE i OBLIGATORY DEFAULT 7.

  DATA: gv_result TYPE i,
        gv_count  TYPE i VALUE 1.

SELECTION-SCREEN END OF BLOCK b1.

*-------------------------------------------
*	While Statement
*-------------------------------------------

WRITE: 'USING WHILE STATEMENT'.
SKIP.

WHILE gv_count <= 10.

  gv_result = gv_count * p_x.
  WRITE: / p_x LEFT-JUSTIFIED, '*', gv_count, '=', gv_result.
  gv_count = gv_count + 1.

ENDWHILE.

ULINE.

*-------------------------------------------
*	Do Statement - Syntax 1
*-------------------------------------------

WRITE: 'USING DO STATEMENT - SYNTAX 1'.
SKIP.
gv_count = 1.

DO 10 TIMES.

  gv_result = gv_count * p_x.
  WRITE: / p_x LEFT-JUSTIFIED, '*', gv_count, '=', gv_result.
  gv_count = gv_count + 1.

ENDDO.

ULINE.

*-------------------------------------------
*	Do Statement - Syntax 2
*-------------------------------------------

WRITE: 'USING DO STATEMENT - SYNTAX 2'.
SKIP.
gv_count = 1.

DO.

  gv_result = gv_count * p_x.
  WRITE: / p_x LEFT-JUSTIFIED, '*', gv_count, '=', gv_result.
  gv_count = gv_count + 1.
  IF gv_count > 10.
    EXIT.
  ENDIF.

ENDDO.