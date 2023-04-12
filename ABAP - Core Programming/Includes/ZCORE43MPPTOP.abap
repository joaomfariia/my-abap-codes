*&---------------------------------------------------------------------*
*& Include ZCORE43MPPTOP                            - PoolMóds.        ZCORE43_LISTBOX_CHECK
*&---------------------------------------------------------------------*
PROGRAM zcore43_listbox_check.

" Not mandatory anymore after ECC 6.0
TYPE-POOLS: vrm.

DATA: it_values TYPE vrm_values,
      wa_value  TYPE LINE OF vrm_values.

" Dropdown listbox flag
DATA gv_flag TYPE i.

" Listbox id key
DATA io1 TYPE c LENGTH 2.

" Checkboxes and Radiobuttons
DATA: c1 TYPE abap_bool,
      c2 TYPE abap_bool,
      c3 TYPE abap_bool,
      r1 TYPE abap_bool,
      r2 TYPE abap_bool,
      r3 TYPE abap_bool.

MODULE status_0100 OUTPUT.

  " Make the listbox active all time!
  IF gv_flag EQ 0.
    gv_flag = 1.
    PERFORM listbox_values.
    PERFORM invisible_blocks.

  ELSEIF gv_flag EQ 2.
    PERFORM visible_block1.

  ELSEIF gv_flag EQ 3.
    PERFORM visible_block2.

  ELSEIF gv_flag EQ 4.
    PERFORM visible_block3.

  ENDIF.

ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

      " Exit button
    WHEN 'FC1'.
      LEAVE PROGRAM.

      " Listbox values/options
    WHEN 'FC2'.
      IF io1 = 'K1'.
        gv_flag = 2.

      ELSEIF io1 = 'K2'.
        gv_flag = 3.

      ELSEIF io1 = 'K3'.
        gv_flag = 4.

      ENDIF.

    WHEN 'FC3'.
      IF c1 = abap_true.
        MESSAGE 'Checkbox 1 selected' TYPE 'I' DISPLAY LIKE 'S'.

      ELSE.
        MESSAGE 'Checkbox 1 deselected' TYPE 'I' DISPLAY LIKE 'E'.

      ENDIF.

    WHEN 'FC4'.
      IF c2 = abap_true.
        MESSAGE 'Checkbox 2 selected' TYPE 'I' DISPLAY LIKE 'S'.

      ELSE.
        MESSAGE 'Checkbox 2 deselected' TYPE 'I' DISPLAY LIKE 'E'.

      ENDIF.

    WHEN 'FC5'.
      IF c3 = abap_true.
        MESSAGE 'Checkbox 3 selected' TYPE 'I' DISPLAY LIKE 'S'.

      ELSE.
        MESSAGE 'Checkbox 3 deselected' TYPE 'I' DISPLAY LIKE 'E'.

      ENDIF.

    WHEN 'FC6'.
      IF r1 = abap_true.
        MESSAGE 'Radiobutton 1 selected' TYPE 'I' DISPLAY LIKE 'S'.

      ELSEIF r2 = abap_true.
        MESSAGE 'Radiobutton 2 selected' TYPE 'I' DISPLAY LIKE 'S'.

      ELSEIF r3 = abap_true.
        MESSAGE 'Radiobutton 3 selected' TYPE 'I' DISPLAY LIKE 'S'.

      ENDIF.

  ENDCASE.

ENDMODULE.

FORM listbox_values.

  CLEAR wa_value.
  wa_value-key = 'K1'.
  wa_value-text = 'Courses'.
  APPEND wa_value TO it_values.

  CLEAR wa_value.
  wa_value-key = 'K2'.
  wa_value-text = 'Enterprises'.
  APPEND wa_value TO it_values.

  CLEAR wa_value.
  wa_value-key = 'K3'.
  wa_value-text = 'Locations'.
  APPEND wa_value TO it_values.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'IO1'      " screen-name
      values = it_values. " vrm table

ENDFORM.

FORM invisible_blocks.

  LOOP AT SCREEN.

    IF screen-group1 = 'G1' OR
       screen-group1 = 'G2' OR
       screen-group1 = 'G3'.

      screen-invisible = 1.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

" Checkboxes
FORM visible_block1 .

  LOOP AT SCREEN.

    " Block 1 visible
    IF screen-group1 = 'G1'.

      screen-invisible = 0.
      MODIFY SCREEN.

    ELSEIF screen-group1 = 'G2' OR
           screen-group1 = 'G3'.

      " Block 1 invisible
      screen-invisible = 1.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

" Radiobuttons
FORM visible_block2 .

  LOOP AT SCREEN.

    " Block 2 visible
    IF screen-group1 = 'G2'.

      screen-invisible = 0.
      MODIFY SCREEN.

    ELSEIF screen-group1 = 'G1' OR
           screen-group1 = 'G3'.

      " Block 2 invisible
      screen-invisible = 1.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

" Text fields
FORM visible_block3 .

  LOOP AT SCREEN.

    " Block 3 visible
    IF screen-group1 = 'G3'.

      screen-invisible = 0.
      MODIFY SCREEN.

    ELSEIF screen-group1 = 'G1' OR
           screen-group1 = 'G2'.

      " Block 3 invisible
      screen-invisible = 1.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.