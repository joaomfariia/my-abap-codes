*&---------------------------------------------------------------------*
*& Report ZCORE31_SELECT_OPTIONS_02
*&---------------------------------------------------------------------*
*& Select-options - Forms - Routines
*&---------------------------------------------------------------------*
REPORT zcore31_select_options_02.

*--------------------------------------------------------------------*
* STRUCTURES AND DATA DEFINITION                                                            *
*--------------------------------------------------------------------*

DATA: gv_vbeln TYPE vbak-vbeln.

SELECT-OPTIONS so_vbeln FOR gv_vbeln DEFAULT '1' TO '4'.

TYPES: BEGIN OF ty_salesheader,   "header

         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         erzet TYPE vbak-erzet,
         ernam TYPE vbak-ernam,

       END OF ty_salesheader,

       BEGIN OF ty_salesitem,  "item

         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         netwr TYPE vbap-netwr,

       END OF ty_salesitem.

DATA: it_salesheader TYPE TABLE OF ty_salesheader,
      wa_salesheader TYPE ty_salesheader,
      it_salesitem   TYPE TABLE OF ty_salesitem,
      wa_salesitem   TYPE ty_salesitem.

*--------------------------------------------------------------------*
* START OF SELECTION                                                 *
*--------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_sales_header_data.

  IF it_salesheader IS NOT INITIAL.

    PERFORM get_sales_item_data.

  ENDIF.

*--------------------------------------------------------------------*
* FORMS                                                              *
*--------------------------------------------------------------------*

FORM get_sales_header_data.

  SELECT vbeln,
         erdat,
         erzet,
         ernam
    FROM vbak
    INTO TABLE @it_salesheader
    WHERE vbeln IN @so_vbeln.

ENDFORM.

FORM get_sales_item_data.

  LOOP AT it_salesitem INTO wa_salesitem.

    SELECT vbeln,
           posnr,
           matnr,
           netwr
      FROM vbap
      INTO TABLE @it_salesitem
      WHERE vbeln = @wa_salesitem-vbeln.

  ENDLOOP.

ENDFORM.