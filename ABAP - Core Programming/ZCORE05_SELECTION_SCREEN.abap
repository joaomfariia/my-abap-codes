*&---------------------------------------------------------------------*
*& Report ZCORE01_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*& Selection-screen Events, Write, Radiobuttons, Sy-Variables
*&---------------------------------------------------------------------*
REPORT zcore05_selection_screen.

" Workflow: abap program -> initialization -> at selection-screen output -> selection-screen

DATA: result TYPE p LENGTH 6 DECIMALS 2.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-001. " text-symbol (press F5)

  SELECTION-SCREEN BEGIN OF LINE.

    " 5(20) -> 5 spaces and length
    SELECTION-SCREEN COMMENT 5(20) lb1.           " lb1 = comment name
    PARAMETERS: p_x TYPE i DEFAULT 20 OBLIGATORY.

  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 5(20) lb2.
    PARAMETERS: p_y TYPE i DEFAULT 15 OBLIGATORY.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_add  RADIOBUTTON GROUP grp1,
              p_dif  RADIOBUTTON GROUP grp1,
              p_prod RADIOBUTTON GROUP grp1,
              p_div  RADIOBUTTON GROUP grp1 DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK bl2.

INITIALIZATION.

  lb1 = 'Enter first number'.
  lb2 = 'Enter second number'.

START-OF-SELECTION.

  IF p_add = 'X'.
    result = p_x + p_y.
    WRITE:/ 'Sum is:', result.

  ELSEIF p_dif = 'X'.
    result = p_x - p_y.

    " if the result is < 0 we need those statements
    IF result >= 0.
      WRITE:/ 'Difference is:', result.
    ELSE.
      WRITE:/ 'Difference is:', result.
    ENDIF.

  ELSEIF p_prod = 'X'.
    result = p_x * p_y.
    WRITE:/ 'Product is:', result.

  ELSEIF p_div = 'X'.
    IF p_y EQ 0.
      MESSAGE 'Divison by 0 impossible!' TYPE 'I' DISPLAY LIKE 'E'.
    ELSE.
      result = p_x / p_y.
      WRITE:/ 'Division is:', result.
    ENDIF.
  ENDIF.