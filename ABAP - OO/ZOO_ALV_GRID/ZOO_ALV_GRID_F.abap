*&---------------------------------------------------------------------*
*& Include          ZOO_ALV_REPORT_F
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form f_mara_query
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_mara_query .

  SELECT matnr, mtart, ernam
    FROM mara
    INTO TABLE @gt_mara
    WHERE matnr BETWEEN '000000000000000001'
                    AND '000000000000000100'.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_fcat_change
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_fcat_change .

  gs_fcat = VALUE #( row_pos = '1'
                     col_pos = '1'
                     fieldname = 'MATNR'
                     tabname = 'GT_MARA'
                     outputlen = 20
                     scrtext_m = 'Material' ).
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gs_fcat = VALUE #( row_pos = '1'
                     col_pos = '2'
                     fieldname = 'MTART'
                     tabname = 'GT_MARA'
                     outputlen = 20
                     f4availabl = abap_true
                     scrtext_m = 'Material Type' ).
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gs_fcat = VALUE #( row_pos = '1'
                     col_pos = '3'
                     fieldname = 'ERNAM'
                     tabname = 'GT_MARA'
                     outputlen = 20
                     scrtext_m = 'Created By'
                     edit = abap_true ).
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

ENDFORM.