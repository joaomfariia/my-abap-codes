*&---------------------------------------------------------------------*
*& Report ZJP04_EVENT_HANDLING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znt04_event_handling.

PARAMETERS: n1 TYPE i DEFAULT 20,
            n2 TYPE i DEFAULT 10.

PARAMETERS: p_r1 RADIOBUTTON GROUP grp1 USER-COMMAND abc,
            p_r2 RADIOBUTTON GROUP grp1,
            p_r3 RADIOBUTTON GROUP grp1,
            p_r4 RADIOBUTTON GROUP grp1.

AT SELECTION-SCREEN ON RADIOBUTTON GROUP grp1.

IF sy-ucomm = 'ABC'. " MUST BE ALWAYS UPPER CASE!!
* message 'Selected the radiobutton' type 'I'.      " information msg

    IF p_r1 = 'X'.
        MESSAGE 'First radiobutton selected!' TYPE 'I'.

    ELSEIF p_r2 = 'X'.
        MESSAGE 'Second radiobutton selected!' TYPE 'I'.

    ELSEIF p_r3 = 'X'.
        MESSAGE 'Third radiobutton selected!' TYPE 'I'.

    ELSEIF p_r4 = 'X'.
        MESSAGE 'Fourth radiobutton selected!' TYPE 'I'.

    ENDIF.

ENDIF.