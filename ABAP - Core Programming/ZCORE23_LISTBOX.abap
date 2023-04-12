*&---------------------------------------------------------------------*
*& Report ZCORE23_LISTBOX
*&---------------------------------------------------------------------*
*& Drop Down List Box in Selection Screen
*&---------------------------------------------------------------------*
REPORT zcore23_listbox.

*TYPE-POOL VRM. "required in ecc 6.0 and before

*PARAMETERS: p_books(20) type c as LISTBOX. "syntax error

PARAMETERS: p_books TYPE c VISIBLE LENGTH 80 AS LISTBOX. "visible length

SELECTION-SCREEN SKIP 2.

SELECTION-SCREEN PUSHBUTTON 1(15) b1 USER-COMMAND fc2.

DATA: t_values  TYPE TABLE OF vrm_value, "vrm_value is a table from function VRM_SET_VALUES
      wa_values TYPE vrm_value.

************************************************************************
*** When program starts                                                   ***
************************************************************************

INITIALIZATION.

  b1 = 'Identify'.  "naming the pushbutton

  PERFORM prepare_dropdown.

  IF t_values IS NOT INITIAL. "with data - not empty
    PERFORM display_dropdown.

  ENDIF.

************************************************************************
*** At the screen                                                    ***
************************************************************************

AT SELECTION-SCREEN.

  CASE sy-ucomm. "user command cases

    WHEN 'FC2'. "UPPERCASE STRING

      IF p_books = 'A'. "A1 not supported?!
        MESSAGE 'BC100 - Introduction to Programming with ABAP' TYPE 'I'.

      ELSEIF p_books = 'B'.
        MESSAGE 'BC400 - ABAP Workbench Foundations' TYPE 'I'.

      ELSEIF p_books = 'C'.
        MESSAGE 'BC401 - ABAP Objects' TYPE 'I'.

      ELSEIF p_books = 'D'.
        MESSAGE 'BC402 - Advanced ABAP' TYPE 'I'.

      ELSE.
        MESSAGE 'No book is selected!' TYPE 'I'.

      ENDIF.

  ENDCASE.

************************************************************************
*** FORM - prepare_dropdown                                          ***
************************************************************************
FORM prepare_dropdown.

  CLEAR wa_values.

  wa_values-key = 'A'.  "A1 not supported?!
  wa_values-text = 'BC100 - Introduction to Programming with ABAP'.
  APPEND wa_values TO t_values.

  wa_values-key = 'B'.
  wa_values-text = 'BC400 - ABAP Workbench Foundations'.
  APPEND wa_values TO t_values.

  wa_values-key = 'C'.
  wa_values-text = 'BC401 - ABAP Objects'.
  APPEND wa_values TO t_values.

  wa_values-key = 'D'.
  wa_values-text = 'BC402 - Advanced ABAP'.
  APPEND wa_values TO t_values.

ENDFORM.
************************************************************************
*** FORM - display_dropdown                                          ***
************************************************************************

FORM display_dropdown.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = 'P_BOOKS'
      values          = t_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc EQ 1.
    MESSAGE 'Illegal drop down list box name.' TYPE 'I'.

  ELSEIF sy-subrc EQ 2.
    MESSAGE 'Unknown error...' TYPE 'I'.

  ENDIF.

ENDFORM.