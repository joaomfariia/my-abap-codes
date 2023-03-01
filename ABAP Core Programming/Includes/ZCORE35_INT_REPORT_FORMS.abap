*&---------------------------------------------------------------------*
*& Include          ZCORE34_INT_REPORT_FORMS
*&---------------------------------------------------------------------*

FORM get_customers.

  SELECT kunnr,
         land1,
         name1
    FROM kna1
    INTO TABLE @it_customers
    WHERE kunnr IN @so_kunnr.

ENDFORM.

FORM display_customers.

  ULINE.
  FORMAT COLOR 3.
  WRITE: /(20) 'Customer Number', (15) 'Customer Key', (35) 'Customer Name'.
  FORMAT COLOR OFF.
  ULINE.

  LOOP AT it_customers INTO wa_customer.

    WRITE: /(20) wa_customer-kunnr COLOR 7 HOTSPOT ON,
                 sy-vline,
            (10) wa_customer-land1,
                 sy-vline,
            (35) wa_customer-name1.

    HIDE wa_customer-kunnr.      "maintain the value where user interacted

  ENDLOOP.
  ULINE.

ENDFORM.

FORM get_sales_orders.

*  gv_kunnr = |{ gv_kunnr ALPHA = IN }|. "inline convertion

*  wa_customer-kunnr do not need to be converted
*  cause the internal table already did that !!

  SELECT vbeln,
         erdat,
         erzet,
         ernam
    FROM vbak
    INTO TABLE @it_vbak
    WHERE kunnr = @wa_customer-kunnr.   "maintened value from HIDE

ENDFORM.

FORM display_sales_orders.

  ULINE.
  FORMAT COLOR 3.
  WRITE: /(25) 'Sales Document', (25) 'Creation Date', (20) 'Registry Time', (25) 'Creator'.
  FORMAT COLOR OFF.
  ULINE.

  LOOP AT it_vbak INTO wa_vbak.

    WRITE: /(25) wa_vbak-vbeln COLOR 4 HOTSPOT ON,
                 sy-vline,
            (25) wa_vbak-erdat,
                 sy-vline,
            (15) wa_vbak-erzet,
                 sy-vline,
            (25) wa_vbak-ernam.

    HIDE wa_vbak-vbeln.     "maintain the value where user interacted

  ENDLOOP.
  ULINE.

ENDFORM.

FORM get_sales_items.

  SELECT vbeln,
         posnr,
         matnr,
         netwr
    FROM vbap
    INTO TABLE @it_vbap
    WHERE vbeln = @wa_vbak-vbeln.   "maintened value from HIDE

ENDFORM.

FORM display_sales_items.

  ULINE.
  FORMAT COLOR 3.
  WRITE: /(25) 'Sales Document', (30) 'Document Item', (25) 'Material', (30) 'Value'.
  FORMAT COLOR OFF.
  ULINE.

  LOOP AT it_vbap INTO wa_vbap.

    WRITE: /(25) wa_vbap-vbeln,
                 sy-vline,
            (30) wa_vbap-posnr,
                 sy-vline,
            (25) wa_vbap-matnr COLOR 1 HOTSPOT ON,
                 sy-vline,
            (30) wa_vbap-netwr.

    HIDE wa_vbap-matnr.     "maintain the value where user interacted

  ENDLOOP.

ENDFORM.