*&---------------------------------------------------------------------*
*& Include ZCORE38_MPP_TOP                          - PoolMóds.        ZCORE38_PF_STATUS_PBO_PAI
*&---------------------------------------------------------------------*
PROGRAM zcore38_pf_status_pbo_pai.

TABLES zemployee.

DATA gv_flag TYPE i.

*** PBO ***
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'ABC'.

  IF gv_flag EQ 0.
    PERFORM invisible_block.

  ELSEIF gv_flag EQ 1.
    PERFORM visible_block.

  ENDIF.

ENDMODULE.


*** PAI ***
MODULE user_command_0100 INPUT.

  IF sy-ucomm = ''.

    sy-ucomm = 'ENTER'.

  ENDIF.

  CASE sy-ucomm.

    WHEN 'FC1'.

      SELECT SINGLE zempname, zemprole
        FROM zemployee
        " Screen name fields
        INTO ( @zemployee-zempname,@zemployee-zemprole )
        WHERE zempid = @zemployee-zempid.

      IF sy-subrc EQ 0.
        " Visible Block
        gv_flag = 1.
      ELSE.
        " Invisible Block
        gv_flag = 0.
        MESSAGE |No employee found for the employee number { zemployee-zempid }| TYPE 'I' DISPLAY LIKE 'E'.
      ENDIF.

    WHEN 'ENTER'.

      SELECT SINGLE zempname, zemprole
        FROM zemployee
        " Screen name fields
        INTO ( @zemployee-zempname,@zemployee-zemprole )
        WHERE zempid = @zemployee-zempid.

      IF sy-subrc EQ 0.
        " Visible Block
        gv_flag = 1.
      ELSE.
        " Invisible Block
        gv_flag = 0.
        MESSAGE |No employee found for the employee number { zemployee-zempid }| TYPE 'I' DISPLAY LIKE 'E'.
      ENDIF.

    WHEN 'FC2'.
      LEAVE PROGRAM.

    WHEN 'BACK'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

**********************************************************************

*** FORMS ***

FORM invisible_block .

  LOOP AT SCREEN.

    IF screen-name EQ 'ZEMPLOYEE-ZEMPNAME' OR
       screen-name EQ 'ZEMPLOYEE-ZEMPROLE'.

      screen-invisible = 1.
      screen-input = 0.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM visible_block .

  LOOP AT SCREEN.

    IF screen-name EQ 'ZEMPLOYEE-ZEMPNAME' OR
       screen-name EQ 'ZEMPLOYEE-ZEMPROLE'.

      screen-invisible = 0.
      screen-input = 0.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.