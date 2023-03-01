*&---------------------------------------------------------------------*
*& Report ZCORE44_SELECT_OPTIONS
*&---------------------------------------------------------------------*
*& Select Options Functionality in Module Pool
*&---------------------------------------------------------------------*
REPORT zcore44_select_options.

" Data Type Structure
TABLES: zdt_vbak.

DATA: gv_vbeln TYPE vbak-vbeln.

DATA: it_sales TYPE TABLE OF zdt_vbak,
      wa_sales TYPE zdt_vbak.

DATA: io1 TYPE i.

" Must be declared to show the table control
CONTROLS tbctrl TYPE TABLEVIEW USING SCREEN 200.

SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.

  SELECT-OPTIONS so_vbeln FOR gv_vbeln DEFAULT 0180000001 TO 0180000010.

SELECTION-SCREEN END OF SCREEN 100.

CALL SCREEN 200.

MODULE user_command_0200 INPUT.

  CASE sy-ucomm.
    WHEN 'FC1'.

      IF so_vbeln IS NOT INITIAL.

        PERFORM get_sales_orders.

      ENDIF.

    WHEN 'FC2'.
      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.

FORM get_sales_orders .

  SELECT vbeln,
         erdat,
         erzet,
         ernam
    FROM vbak
    INTO TABLE @it_sales
    WHERE vbeln BETWEEN @so_vbeln-low
                    AND @so_vbeln-high.

  IF sy-subrc EQ 0.
    tbctrl-lines = sy-dbcnt.
    io1 = sy-dbcnt.

  ELSE.

    MESSAGE 'No data found...' TYPE 'I' DISPLAY LIKE 'E'.

  ENDIF.

ENDFORM.

MODULE transfer_data OUTPUT.

  CLEAR zdt_vbak.
  zdt_vbak-vbeln = wa_sales-vbeln.
  zdt_vbak-erdat = wa_sales-erdat.
  zdt_vbak-erzet = wa_sales-erzet.
  zdt_vbak-ernam = wa_sales-ernam.

  IF so_vbeln IS INITIAL.

    CLEAR: zdt_vbak-vbeln,
           zdt_vbak-erdat,
           zdt_vbak-erzet,
           zdt_vbak-ernam.
  ENDIF.

ENDMODULE.