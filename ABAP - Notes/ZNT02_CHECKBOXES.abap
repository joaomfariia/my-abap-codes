*&---------------------------------------------------------------------*
*& Report ZJP02_CHECKBOXES
*&---------------------------------------------------------------------*
*& SELECTION SCREEN CHECKBOXES
*&---------------------------------------------------------------------*
REPORT znt02_checkboxes.

PARAMETERS: n1 TYPE i DEFAULT 10,
            n2 TYPE i DEFAULT 15.

PARAMETERS: p_c1 AS CHECKBOX DEFAULT 'X',
            p_c2 AS CHECKBOX,
            p_c3 AS CHECKBOX DEFAULT 'X',
            p_c4 AS CHECKBOX.

DATA: result TYPE p DECIMALS 2.

IF p_c1 = 'X'.
  result = n1 + n2.
  WRITE:/'Sum of two numbers is', result.
ENDIF.

IF p_c2 = 'X'.
    result = n1 - n2.

    IF result >= 0.
        WRITE:/'Difference of two numbers is', result.

    ELSE.
        WRITE:/'Difference of two numbers is -' NO-GAP,result NO-SIGN LEFT-JUSTIFIED.

    ENDIF.
ENDIF.

IF p_c3 = 'X'.
    result = n1 * n2.
    WRITE:/'Product of two numbers is', result.
ENDIF.

IF p_c4 = 'X'.
    result = n1 / n2.
    WRITE:/'Division of two numbers is', result.
ENDIF.