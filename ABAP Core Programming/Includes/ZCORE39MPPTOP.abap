*&---------------------------------------------------------------------*
*& Include ZCORE39MPPTOP                            - PoolMóds.        ZCORE39_TABLE_CONTROL
*&---------------------------------------------------------------------*
PROGRAM zcore39_table_control.

TABLES: zdt_vbak, zdt_vbap.

" The table control from screen painter must be defined
CONTROLS tbctrl TYPE TABLEVIEW USING SCREEN 100.

DATA: it_vbap TYPE TABLE OF zdt_vbap,
      wa_vbap TYPE zdt_vbap.

DATA: gv_flag TYPE i.

MODULE status_0100 OUTPUT.

  SET PF-STATUS 'ABC'.

  IF gv_flag EQ 0.
    PERFORM invisible_block.

  ELSEIF gv_flag EQ 1.
    PERFORM visible_block.

  ENDIF.

ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

    WHEN `FC1`.
      LEAVE PROGRAM.

    WHEN `BACK`.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

MODULE get_sales_header_data INPUT.

  SELECT SINGLE vbeln,
                erdat,
                erzet,
                ernam
    FROM vbak
    INTO ( @zdt_vbak-vbeln,
           @zdt_vbak-erdat,
           @zdt_vbak-erzet,
           @zdt_vbak-ernam )
    WHERE vbeln EQ @zdt_vbak-vbeln.

  IF sy-subrc EQ 0.

    " Visible block
    gv_flag = 1.

    SELECT vbeln,
           posnr,
           matnr,
           netwr
      FROM vbap
      INTO TABLE @it_vbap
      WHERE vbeln EQ @zdt_vbak-vbeln.

    " Not implemented yet
    IF sy-subrc EQ 0.
      tbctrl-lines = sy-dbcnt.
    ENDIF.

  ELSE.

    IF zdt_vbak-vbeln IS INITIAL.
      " Invisible block
      gv_flag = 0.
      MESSAGE 'Please, enter a sales document number.' TYPE 'I' DISPLAY LIKE 'W'.

    ELSE.
      " Invisible block
      gv_flag = 0.
      MESSAGE |'No item header data found for doc. number { zdt_vbak-vbeln }'| TYPE 'I' DISPLAY LIKE 'E'.
      CLEAR zdt_vbak-vbeln.

    ENDIF.

  ENDIF.

ENDMODULE.

MODULE transfer_item_data OUTPUT.

  CLEAR zdt_vbap.

  zdt_vbap-vbeln = wa_vbap-vbeln.
  zdt_vbap-posnr = wa_vbap-posnr.
  zdt_vbap-matnr = wa_vbap-matnr.
  zdt_vbap-netwr = wa_vbap-netwr.

  IF zdt_vbak-vbeln IS INITIAL.

    CLEAR: zdt_vbap-vbeln,
           zdt_vbap-posnr,
           zdt_vbap-matnr,
           zdt_vbap-netwr.

  ENDIF.

ENDMODULE.

*&---------------------------------------------------------------------*
*& Forms
*&---------------------------------------------------------------------*

FORM invisible_block.

  LOOP AT SCREEN.

    IF screen-name EQ 'ZDT_VBAK-ERDAT' OR
       screen-name EQ 'ZDT_VBAK-ERZET' OR
       screen-name EQ 'ZDT_VBAK-ERNAM'.

      screen-invisible = 1.
      screen-input = 0.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM visible_block.

  LOOP AT SCREEN.

    IF screen-name EQ 'ZDT_VBAK-ERDAT' OR
       screen-name EQ 'ZDT_VBAK-ERZET' OR
       screen-name EQ 'ZDT_VBAK-ERNAM'.

      screen-invisible = 0.
      screen-input = 0.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.