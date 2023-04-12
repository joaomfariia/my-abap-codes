*&---------------------------------------------------------------------*
*& Include ZCORE40MPPTOP                            - PoolMóds.        ZCORE40_VALIDATIONS
*&---------------------------------------------------------------------*
PROGRAM zcore40_validations.

TABLES: kna1, vbak.

MODULE status_0100 OUTPUT.
  SET PF-STATUS `ABC`.

ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.

    WHEN `FC2`.
      LEAVE PROGRAM.

    WHEN `BACK`.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

MODULE cancel_button INPUT.

  CASE sy-ucomm.

    WHEN 'FC1'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

MODULE get_sales_data INPUT.

  IF vbak-vbeln IS NOT INITIAL.

    SELECT SINGLE erdat,
                  erzet,
                  ernam
      FROM vbak
      INTO ( @vbak-erdat,
             @vbak-erzet,
             @vbak-ernam )
      WHERE vbeln = @vbak-vbeln.

    IF sy-subrc EQ 0.

      MESSAGE 'Sales document found!' TYPE 'I' DISPLAY LIKE 'S'.

    ELSE.

      MESSAGE 'Sales document not found..' TYPE 'I' DISPLAY LIKE 'E'.

    ENDIF.

  ELSE.

    MESSAGE 'Please, enter a sales document number' TYPE 'I' DISPLAY LIKE 'W'.

  ENDIF.

ENDMODULE.