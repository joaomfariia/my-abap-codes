*&---------------------------------------------------------------------*
*& Report ZCORE08_CHECKBOX_SCREENS
*&---------------------------------------------------------------------*
*& Pushbuttons, User-command
*&---------------------------------------------------------------------*
REPORT zcore08_checkbox_screens_03.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_x TYPE i DEFAULT 15,
              p_y TYPE i DEFAULT 20,
              p_z TYPE i MODIF ID p3.   " id reference

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  " Starts at position 6 and has 12 length
  " / command jumps a line
  SELECTION-SCREEN PUSHBUTTON /6(12) b3 USER-COMMAND fc1 MODIF ID pb1.

  SELECTION-SCREEN PUSHBUTTON 20(12) b4 USER-COMMAND fc2.
  SELECTION-SCREEN SKIP 2.

  SELECTION-SCREEN PUSHBUTTON 6(12) b5 USER-COMMAND fc3.

SELECTION-SCREEN END OF BLOCK b2.

*--------------------------------
*	Before program starts
*--------------------------------
INITIALIZATION.

* Naming the pushbuttons
  b3 = 'Addition'.
  b4 = 'Clear'.
  b5 = 'Exit'.

*--------------------------------
*	Event during selection-screen
*--------------------------------
AT SELECTION-SCREEN.

  CASE sy-ucomm.    " last user action triggered

* Pushbutton 'fc1'
    WHEN 'FC1'.
      p_z = p_x + p_y.

    WHEN 'FC2'.
      CLEAR: p_x,
             p_y,
             p_z.

    WHEN 'FC3'.
      LEAVE PROGRAM.

  ENDCASE.

*--------------------------------
*	Event at screen output
*--------------------------------

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_z IS NOT INITIAL.  " if p_z has a value

      IF screen-group1 = 'P3'.  " refers to the screen field and parameter p_z
        screen-input = '0'.
        screen-invisible = '0'.
        screen-required = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.

  ENDLOOP.