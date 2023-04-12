*&---------------------------------------------------------------------*
*& Report ZCORE08_CHECKBOX_SCREENS
*&---------------------------------------------------------------------*
*& Checkboxes, Messages, At Selection-screen
*&---------------------------------------------------------------------*
REPORT zcore08_checkbox_screens_02.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_x TYPE i DEFAULT 10 OBLIGATORY,
              p_y TYPE i DEFAULT 20 OBLIGATORY.

  DATA: gv_result TYPE i.

  PARAMETERS: p_add  AS CHECKBOX USER-COMMAND fc1,
              p_diff AS CHECKBOX USER-COMMAND fc2,
              p_prod AS CHECKBOX USER-COMMAND fc3,
              p_div  AS CHECKBOX USER-COMMAND fc4.

SELECTION-SCREEN END OF BLOCK b1.

AT SELECTION-SCREEN.

  CASE sy-ucomm.

    WHEN 'FC1'.   " user command MUST be UPPERCASE!!
      IF p_add = 'X'.
        MESSAGE: 'Addition checkbox selected.' TYPE 'I'.
      ELSE.
        MESSAGE: 'Addition checkbox deselected.' TYPE 'I'.
      ENDIF.

    WHEN 'FC2'.
      IF p_diff = 'X'.
        MESSAGE: 'Difference checkbox selected.' TYPE 'I'.
      ELSE.
        MESSAGE: 'Difference checkbox deselected.' TYPE 'I'.
      ENDIF.


    WHEN 'FC3'.
      IF p_prod = 'X'.
        MESSAGE: 'Product checkbox selected.' TYPE 'I'.
      ELSE.
        MESSAGE: 'Product checkbox deselected.' TYPE 'I'.
      ENDIF.

    WHEN 'FC4'.
      IF p_div = 'X'.
        MESSAGE: 'Division checkbox selected.' TYPE 'I'.
      ELSE.
        MESSAGE: 'Division checkbox deselected.' TYPE 'I'.
      ENDIF.

    WHEN OTHERS.
      MESSAGE: 'None of the checkboxes are selected.' TYPE 'E'.

  ENDCASE.


START-OF-SELECTION.   "triggered right after the execution button

  IF p_add = 'X'.
    gv_result = p_x + p_y.
    WRITE: /'Sum is', gv_result.
  ENDIF.

  IF p_diff = 'X'.
    gv_result = p_x - p_y.
    WRITE: /'Difference is', gv_result.
  ENDIF.

  IF p_prod = 'X'.
    gv_result = p_x * p_y.
    WRITE: /'Product is', gv_result.
  ENDIF.

  IF p_div = 'X'.
    WRITE: /'Division is', gv_result.
  ENDIF.