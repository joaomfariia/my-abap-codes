*&---------------------------------------------------------------------*
*& Report ZCORE31_SELECT_OPTIONS_02
*&---------------------------------------------------------------------*
*& For all entries - On change of - Perfomance Improvement
*&---------------------------------------------------------------------*
REPORT zcore32_for_all_entries.

*--------------------------------------------------------------------*
* STRUCTURES AND DATA DEFINITION                                                            *
*--------------------------------------------------------------------*

DATA: gv_vbeln TYPE vbak-vbeln.

SELECT-OPTIONS so_vbeln FOR gv_vbeln DEFAULT '1' TO '5'.

TYPES: BEGIN OF ty_salesheader,   "header

         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         erzet TYPE vbak-erzet,
         ernam TYPE vbak-ernam,

       END OF ty_salesheader,

       BEGIN OF ty_salesitem,     "item

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

    IF it_salesitem IS NOT INITIAL.

      PERFORM display_sales_data.

    ENDIF.

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

**  LOOP AT it_salesheader INTO wa_salesheader.   "bad performance - not recommended!!
**
**    SELECT vbeln,                               "select inside loop - not recommended!!
**           posnr,
**           matnr,
**           netwr
**      FROM vbap
**      INTO @wa_salesitem
**      WHERE vbeln = @wa_salesheader-vbeln.
**    ENDSELECT.
**
**    APPEND wa_salesitem TO it_salesitem.
**
**  ENDLOOP.

  SELECT vbeln,
         posnr,
         matnr,
         netwr
    FROM vbap
    INTO TABLE @it_salesitem
    FOR ALL ENTRIES IN @it_salesheader
    WHERE vbeln = @it_salesheader-vbeln.

ENDFORM.

FORM display_sales_data.

**  LOOP AT it_salesheader INTO wa_salesheader.     "bad performance - not recommended!!
**
**    FORMAT COLOR 3.                               "nested loops - not recommended!!
**    WRITE:/ wa_salesheader-vbeln,
**            wa_salesheader-erdat,
**            wa_salesheader-erzet,
**            wa_salesheader-ernam.
**
**    LOOP AT it_salesitem INTO wa_salesitem WHERE vbeln = wa_salesheader-vbeln.
**
**      FORMAT COLOR 7.
**      WRITE:/3 wa_salesitem-vbeln,
**               wa_salesitem-posnr,
**               wa_salesitem-matnr,
**               wa_salesitem-netwr.
**
**    ENDLOOP.
**
**  ENDLOOP.

  LOOP AT it_salesitem INTO wa_salesitem.

    ON CHANGE OF wa_salesitem-vbeln.    "executes if the object is changed and not initial

      CLEAR wa_salesheader.

      READ TABLE it_salesheader INTO wa_salesheader
        WITH KEY vbeln = wa_salesitem-vbeln.

      IF sy-subrc EQ 0.

        FORMAT COLOR 3.
        WRITE:/ wa_salesheader-vbeln,
                wa_salesheader-erdat,
                wa_salesheader-erzet,
                wa_salesheader-ernam.

      ENDIF.

    ENDON.

    FORMAT COLOR 7.
    WRITE:/3 wa_salesitem-vbeln,
             wa_salesitem-posnr,
             wa_salesitem-matnr,
             wa_salesitem-netwr.

    FORMAT COLOR OFF.

  ENDLOOP.

ENDFORM.