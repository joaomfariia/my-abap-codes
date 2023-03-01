*&---------------------------------------------------------------------*
*& Include ZCORE41MPPTOP                            - PoolMóds.        ZCORE41_TAB_STRIP_SUBSCREEN
*&---------------------------------------------------------------------*
PROGRAM zcore41_tab_strip_subscreen.

CONTROLS bx1 TYPE TABSTRIP.

DATA: gv_screen TYPE sy-dynnr.

DATA: gv_flag TYPE i.

" Makes the Tab 2 as default
MODULE subscreen OUTPUT.

  IF gv_flag EQ 0.

    gv_flag = 1.
    " bx1 is the control screen box
    bx1-activetab = 'FC2'.
    " subscreen number and content
    gv_screen = 300.

  ENDIF.

ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

    WHEN 'FC1'.

      bx1-activetab = 'FC1'.
      gv_screen = 200.

    WHEN 'FC2'.

      bx1-activetab = 'FC2'.
      gv_screen = 300.

    WHEN 'FC3'.
      LEAVE PROGRAM.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.