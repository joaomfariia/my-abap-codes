*&---------------------------------------------------------------------*
*& Report ZCORE01_SELECTION_SCREEN
*&---------------------------------------------------------------------*
*& String Operations, Function Code, User COmmand
*&---------------------------------------------------------------------*
REPORT zcore07_string_func_user_c.

" Workflow: abap program -> initialization -> at selection-screen output -> selection-screen

DATA: result TYPE p DECIMALS 2.

DATA: str1 TYPE string,
      str2 TYPE string,
      msg  TYPE string.

SELECTION-SCREEN BEGIN OF BLOCK bl1 WITH FRAME TITLE TEXT-001. " text-symbol (press F5)

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 5(20) lb1.           " lb1 = comment name
    PARAMETERS: p_x TYPE i DEFAULT 20 OBLIGATORY.

  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 5(20) lb2.
    PARAMETERS: p_y TYPE i DEFAULT 15 OBLIGATORY.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK bl1.

SELECTION-SCREEN BEGIN OF BLOCK bl2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_add  RADIOBUTTON GROUP grp1 USER-COMMAND fc1, " occurs only in 1st parameter
              p_dif  RADIOBUTTON GROUP grp1,
              p_prod RADIOBUTTON GROUP grp1,
              p_div  RADIOBUTTON GROUP grp1,
              p_none RADIOBUTTON GROUP grp1 DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK bl2.

INITIALIZATION.

  lb1 = 'Enter first number'.     " selection-screen comment
  lb2 = 'Enter second number'.

AT SELECTION-SCREEN ON RADIOBUTTON GROUP grp1.

  " user command sys variable
  CASE sy-ucomm.

    " function command
    WHEN 'FC1'.

      " Sum
      IF p_add = 'X'.
        result = p_x + p_y.

        str1 = 'Sum is:'.
        str2 = result.
        CLEAR msg.
        CONCATENATE str1 str2 INTO msg SEPARATED BY space.
        MESSAGE msg TYPE 'I'.   " information message

      " Difference
      ELSEIF p_dif = 'X'.
        result = p_x - p_y.

        str1 = 'Difference is:'.
        str2 = result.
        CLEAR msg.
        CONCATENATE str1 str2 INTO msg SEPARATED BY space.
        MESSAGE msg TYPE 'I'.

      " Product
      ELSEIF p_prod = 'X'.
        result = p_x * p_y.

        str1 = 'Product is:'.
        str2 = result.
        CLEAR msg.
        CONCATENATE str1 str2 into msg SEPARATED BY space.
        MESSAGE msg TYPE 'I'.

      " Division
      ELSEIF p_div = 'X'.
        result = p_x / p_y.

        str1 = 'Division is:'.
        str2 = result.
        CLEAR msg.
        CONCATENATE str1 str2 into msg SEPARATED BY space.
        MESSAGE msg TYPE 'I'.

      ENDIF.
  ENDCASE.