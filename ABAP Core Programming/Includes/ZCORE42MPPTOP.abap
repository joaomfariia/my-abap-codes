*&---------------------------------------------------------------------*
*& Include ZCORE42MPPTOP  - PoolMóds.        ZCORE42_MODAL_DIALOG_BOX
*&---------------------------------------------------------------------*
PROGRAM zcore42_modal_dialog_box.

TABLES: vbak, vbap.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

    WHEN 'FC1'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

MODULE get_sales_data INPUT.

  IF vbak-vbeln IS NOT INITIAL.

    SELECT SINGLE vbeln,
                  erdat,
                  erzet,
                  ernam
      FROM vbak
      INTO ( @vbak-vbeln,
             @vbak-erdat,
             @vbak-erzet,
             @vbak-ernam )
      WHERE vbeln = @vbak-vbeln.

    IF sy-subrc EQ 0.

      MESSAGE 'Sales document found!' TYPE 'I' DISPLAY LIKE 'S'.

      " Starting/Ending at defines the modal dialog box size
      " Must be defined!
      CALL SCREEN 200 STARTING AT 10 10 ENDING AT 50 20.

    ELSE.

      MESSAGE 'No sales document found...' TYPE 'I' DISPLAY LIKE 'E'.

    ENDIF.

  ELSE.

    MESSAGE 'Please, enter a sales document number.' TYPE 'I' DISPLAY LIKE 'W'.

  ENDIF.

ENDMODULE.

MODULE user_command_0200 INPUT.

  CASE sy-ucomm.

    WHEN 'FC2'.
      " Screen 0 = parent screen
      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.

MODULE get_f4_values INPUT.

  SELECT vbeln,
         netwr
    FROM vbak
    INTO TABLE @DATA(it_f4values)
    WHERE netwr LE 2000.

  IF sy-subrc EQ 0.

    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield    = 'VBELN'
        dynpprog    = sy-repid
        dynpnr      = sy-dynnr
        dynprofield = 'VBAK-VBELN'
        value_org   = 'S'
      TABLES
        value_tab   = it_f4values.

  ELSE.

    MESSAGE 'No data for F4 help' TYPE 'I' DISPLAY LIKE 'E'.

  ENDIF.

ENDMODULE.

MODULE f1_help_request INPUT.

  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'Sales Document Number'
      txt1  = 'Table Name: VBAK'
      txt2  = 'Field Name: VBAK_VBELN'.

ENDMODULE.