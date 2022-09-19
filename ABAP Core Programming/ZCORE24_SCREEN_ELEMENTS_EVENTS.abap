*&---------------------------------------------------------------------*
*& Report ZCORE24_SCREEN_ELEMENTS_EVENTS
*&---------------------------------------------------------------------*
*& Drop Down Listbox in Selection Screen
*&---------------------------------------------------------------------*
REPORT zcore24_screen_elements_events.

*TYPE-POOL vrm. "required in ecc 6.0 and before

*PARAMETERS: p_option type c LENGTH 15 as LISTBOX. "syntax error
*PARAMETERS: p_option(15) TYPE c VISIBLE LENGTH 20 AS LISTBOX USER-COMMAND fc1. "syntax error

PARAMETERS: p_option TYPE c VISIBLE LENGTH 20 AS LISTBOX USER-COMMAND fc1 MODIF ID id0.

DATA: t_values  TYPE TABLE OF vrm_value,
      wa_values TYPE vrm_value.

DATA: gv_flag TYPE i.

************************************************************************
*** Blocks                                                           ***
************************************************************************

SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE t1.

  PARAMETERS: p_c1 AS CHECKBOX MODIF ID id1,
              p_c2 AS CHECKBOX MODIF ID id1,
              p_c3 AS CHECKBOX MODIF ID id1.

SELECTION-SCREEN END OF BLOCK bk1.

SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE t2.

  PARAMETERS: p_r1 RADIOBUTTON GROUP grp1 MODIF ID id2,
              p_r2 RADIOBUTTON GROUP grp1 MODIF ID id2,
              p_r3 RADIOBUTTON GROUP grp1 MODIF ID id2.

SELECTION-SCREEN END OF BLOCK bk2.

SELECTION-SCREEN BEGIN OF BLOCK bk3 WITH FRAME TITLE t3.

  SELECTION-SCREEN COMMENT 3(15) lb1 MODIF ID id3.
  SELECTION-SCREEN COMMENT /3(15) lb2 MODIF ID id3.
  SELECTION-SCREEN COMMENT /3(15) lb3 MODIF ID id3.

SELECTION-SCREEN END OF BLOCK bk3.

************************************************************************
*** When program starts                                              ***
************************************************************************

INITIALIZATION.

  PERFORM prepare_values.
  PERFORM invisible_blocks.

  t1 = 'Courses'.
  t2 = 'SAP Products'.
  t3 = 'Technologies'.
  lb1 = 'ABAP'.
  lb2 = 'Python'.
  lb3 = 'Linux'.

************************************************************************
*** At Selection Screen                                              ***
************************************************************************

AT SELECTION-SCREEN.

  IF p_option = 'A'.
    gv_flag = 1.

  ELSEIF p_option = 'B'.
    gv_flag = 2.

  ELSEIF p_option = 'C'.
    gv_flag = 3.

  ENDIF.

************************************************************************
*** At Selection Screen Output                                       ***
************************************************************************

AT SELECTION-SCREEN OUTPUT.

  IF gv_flag = 1.
    PERFORM visible_block1.

  ELSEIF gv_flag = 2.
    PERFORM visible_block2.

  ELSEIF gv_flag = 3.
    PERFORM visible_block3.

  ENDIF.

************************************************************************
*** Help Request (F1)                                                ***
************************************************************************

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_option.

  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'F1 HELP FOR DROPDOWN'
      txt1  = 'Select an option from the dropdown.'
      txt2  = 'When selected, displays the blocks of the option.'.

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_c1.
  MESSAGE i000(zcore24).   " <message type> (<message class>)

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_r1.
  MESSAGE s001(zcore24).   " <message type> (<message class>)

************************************************************************
*** FORM prepare_values                                              ***
************************************************************************

FORM prepare_values.

  CLEAR wa_values.

  wa_values-key = 'A'.
  wa_values-text = 'Courses'.
  APPEND wa_values TO t_values.

  wa_values-key = 'B'.
  wa_values-text = 'SAP Products'.
  APPEND wa_values TO t_values.

  wa_values-key = 'C'.
  wa_values-text = 'Skills'.
  APPEND wa_values TO t_values.

  CALL FUNCTION 'VRM_SET_VALUES' "function to populate the listbox parameter
    EXPORTING
      id              = 'P_OPTION'
      values          = t_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc EQ 1.
    MESSAGE 'Exception #01 - Illegal name raised.' TYPE 'I'.

  ELSEIF sy-subrc EQ 2.
    MESSAGE 'Unknown Exception raised.' TYPE 'I'.
  ENDIF.

ENDFORM.

************************************************************************
*** FORM invisible_blocks                                            ***
************************************************************************
FORM invisible_blocks.

  LOOP AT SCREEN.

    "all screen elements besides listbox
*    IF screen-name = 'BK1' OR screen-name = 'T1'         "before screen-group1 with modify id
*                           OR screen-name = 'P_C1'
*                           OR screen-name = 'P_C2'
*                           OR screen-name = 'P_C3'
*                           OR screen-name = 'BK2'
*                           OR screen-name = 'T2'
*                           OR screen-name = 'P_R1'
*                           OR screen-name = 'P_R2'
*                           OR screen-name = 'P_R3'
*                           OR screen-name = 'BK3'
*                           OR screen-name = 'T3'
*                           OR screen-name = 'LB1'
*                           OR screen-name = 'LB2'
*                           OR screen-name = 'LB3'.

    IF screen-group1 = 'ID1' OR screen-group1 = 'ID2'
                             OR screen-group1 = 'ID3'.

      screen-invisible = '1'. "activates invisible element at screen
      MODIFY SCREEN.
    ENDIF.

  ENDLOOP.

ENDFORM.

************************************************************************
*** FORM visible_block (1, 2 and 3)                                  ***
************************************************************************

FORM visible_block1.

  LOOP AT SCREEN.

    IF screen-group1 = 'ID1' OR screen-name = 'P_OPTION'
                             OR screen-name = 'T1'
                             OR screen-group1 = 'ID0'.

      screen-invisible = '0'. "not invisible
      MODIFY SCREEN.

    ELSE.
      screen-invisible = '1'. "invisible
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM visible_block2.

  LOOP AT SCREEN.

    IF screen-group1 = 'ID2' OR screen-name = 'P_OPTION'
                             OR screen-name = 'T2'
                             OR screen-group1 = 'ID0'.

      screen-invisible = '0'. "not invisible
      MODIFY SCREEN.

    ELSE.
      screen-invisible = '1'. "invisible
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM visible_block3.

  LOOP AT SCREEN.

    IF screen-group1 = 'ID3' OR screen-name = 'P_OPTION'
                             OR screen-name = 'T3'
                             OR screen-group1 = 'ID0'.

      screen-invisible = '0'. "not invisible
      MODIFY SCREEN.

    ELSE.
      screen-invisible = '1'. "invisible
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.