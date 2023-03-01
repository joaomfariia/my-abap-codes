*&---------------------------------------------------------------------*
*& Report ZCORE33_RANGE_CONTROL
*&---------------------------------------------------------------------*
*& Ranges and Control Break Events
*&---------------------------------------------------------------------*
REPORT zcore33_range_control NO STANDARD PAGE HEADING.

RANGES: r_vbeln FOR vbap-vbeln.

TYPES: BEGIN OF ty_salesitem,

         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         netwr TYPE vbap-netwr,

       END OF ty_salesitem.

DATA: it_salesitem TYPE TABLE OF ty_salesitem,
      wa_salesitem TYPE ty_salesitem.

START-OF-SELECTION.

  r_vbeln-sign = 'I'.
  r_vbeln-option = 'BT'.
  r_vbeln-low = '0000000001'.
  r_vbeln-high = '0000000004'.
  APPEND r_vbeln.

  r_vbeln-sign = 'I'.
  r_vbeln-option = 'BT'.
  r_vbeln-low = '0180000001'.
  r_vbeln-high = '0180000004'.
  APPEND r_vbeln.

  PERFORM get_salesitem.

  IF sy-subrc EQ 0.
    PERFORM display_salesitem.

  ELSE.
    MESSAGE 'No data found..' TYPE 'I'.

  ENDIF.

*--------------------------------------------------------------------*
* FORMS                                                              *
*--------------------------------------------------------------------*

FORM get_salesitem.

  SELECT vbeln,
         posnr,
         matnr,
         netwr
    FROM vbap
    INTO TABLE @it_salesitem
    WHERE vbeln IN @r_vbeln.

ENDFORM.

FORM display_salesitem.

  LOOP AT it_salesitem INTO wa_salesitem.

    AT FIRST.
      FORMAT COLOR 1.
      WRITE:/24 'SALES DOCUMENTS ITEM DATA WITH PRICES'.
      SKIP 1.

    ENDAT.

    AT NEW vbeln.

      FORMAT COLOR 3.
      WRITE:/ 'Sales Document No:', wa_salesitem-vbeln.

    ENDAT.

    FORMAT COLOR 7.
    WRITE:/5 wa_salesitem-vbeln,
             wa_salesitem-posnr,
             wa_salesitem-matnr,
             wa_salesitem-netwr.

    AT END OF vbeln.

      SUM.
      FORMAT COLOR 5.
      WRITE:/ 'Total Values of', wa_salesitem-vbeln, wa_salesitem-netwr UNDER wa_salesitem-netwr.
      SKIP 1.

    ENDAT.

    AT LAST.
      SUM.
      FORMAT COLOR 1.
      WRITE:/ 'Total Sales Value:', wa_salesitem-netwr UNDER wa_salesitem-netwr.

    ENDAT.

  ENDLOOP.

ENDFORM.