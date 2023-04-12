*&---------------------------------------------------------------------*
*& Report ZJP06_CASE_ENDCASE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znt06_case_endcase.

PARAMETERS: p_x  TYPE i DEFAULT 10,
            p_y  TYPE i DEFAULT 5,
            p_ch TYPE i.

DATA result TYPE i.

CASE p_ch.

    WHEN 1.
        result = p_x + p_y.
        WRITE:/'Sum is',result.

    WHEN 2.
        result = p_x - p_y.
        WRITE:/'Difference is',result.

    WHEN 3.
        result = p_x * p_y.
        WRITE:/'Product is',result.

    WHEN 4.
        result = p_x / p_y.
        WRITE:/'Division is',result.

    WHEN 5.
        result = p_x MOD p_y.
        WRITE:/'Remainder is',result.

    WHEN OTHERS.
        MESSAGE 'Please enter choice 1-5' TYPE 'I'.

ENDCASE.