*&---------------------------------------------------------------------*
*& Report ZCORE08_CHECKBOX_SCREENS
*&---------------------------------------------------------------------*
*& Checkboxes, Messages, At Selection-screen
*&---------------------------------------------------------------------*
REPORT zcore08_checkbox_screens.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_x TYPE i DEFAULT 10 OBLIGATORY,
              p_y TYPE i DEFAULT 20 OBLIGATORY.

  DATA: gv_result TYPE i.

  PARAMETERS: p_c1 AS CHECKBOX DEFAULT 'X', "sum
              p_c2 AS CHECKBOX,             "difference
              p_c3 AS CHECKBOX DEFAULT 'X', "product
              p_c4 AS CHECKBOX.             "division

SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.   "triggered right after the execution button

  IF p_c1 = 'X'.
    gv_result = p_x + p_y.
    WRITE: /'Sum is', gv_result.
  ENDIF.

  IF p_c2 = 'X'.
    gv_result = p_x - p_y.
    WRITE: /'Difference is', gv_result.
  ENDIF.

  IF p_c3 = 'X'.
    gv_result = p_x * p_y.
    WRITE: /'Product is', gv_result.
  ENDIF.

  IF p_c4 = 'X'.
    WRITE: /'Division is', gv_result.
  ENDIF.