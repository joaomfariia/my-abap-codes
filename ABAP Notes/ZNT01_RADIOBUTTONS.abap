*&---------------------------------------------------------------------*
*& Report ZJP01_RADIOBUTTONS
*&---------------------------------------------------------------------*
*& SELECTION SCREEN RADIOBUTTONS
*&---------------------------------------------------------------------*
REPORT znt01_radiobuttons.

PARAMETERS: p_x TYPE i DEFAULT 20,
            p_y TYPE i DEFAULT 10.

PARAMETERS: p_r1 RADIOBUTTON GROUP grp1,
            p_r2 RADIOBUTTON GROUP grp1,
            p_r3 RADIOBUTTON GROUP grp1 DEFAULT 'X',
            p_r4 RADIOBUTTON GROUP grp1.

DATA gv_res TYPE p DECIMALS 2.

" Addition
IF p_r1 = 'X'.
    gv_res = p_x + p_y.
    WRITE:/'Sum of two number is', gv_res.

" Difference
ELSEIF p_r2 = 'X'.
    gv_res = p_x - p_y.

    IF gv_res >= 0.
        WRITE:/'Difference of two numbers is', gv_res.
    ELSE.
        WRITE:/'Difference of two numbers is -' NO-GAP,gv_res NO-SIGN LEFT-JUSTIFIED.
    ENDIF.

" Product
ELSEIF p_r3 = 'X'.
    gv_res = p_x * p_y.
    WRITE:/'Product of two numbers is',gv_res.

" Division
ELSEIF p_r4 = 'X'.
    gv_res = p_x / p_y.
    WRITE:/'Division of two numbers is',gv_res.

ENDIF.