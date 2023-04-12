*&---------------------------------------------------------------------*
*& Report ZCORE27_FETCH_DATA_PART02_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcore27_fetch_data_part02_03.

DATA: gv_kunnr TYPE kna1-kunnr,
      gv_land1 TYPE kna1-land1,
      gv_name1 TYPE kna1-name1,
      gv_ort01 TYPE kna1-ort01.

PARAMETERS: p_kunnr TYPE kna1-kunnr.

*--------------------------------------------------------------------*
* START OF SELECTION                                                 *
*--------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_data.

  IF sy-subrc EQ 0.

    MESSAGE 'Customer found!!' TYPE 'I'.

    PERFORM display_data.

  ELSE.

    MESSAGE 'Customer not found...' TYPE 'W'.

  ENDIF.

*--------------------------------------------------------------------*
* FORM - NATIVE SQL                                                  *
*--------------------------------------------------------------------*
FORM get_data.

  "native SQL syntax
  EXEC SQL.

    select kunnr, land1, name1, ort01
      from kna1
      into :gv_kunnr, :gv_land1, :gv_name1, :gv_ort01
      where kunnr = :p_kunnr

  ENDEXEC.

ENDFORM.

FORM display_data.

  WRITE:/(20) 'Customer Number:', gv_kunnr,
        /(20) 'Customer Country:', gv_land1,
        /(20) 'Customer Name:', gv_name1,
        /(20) 'Customer City:', gv_ort01.

ENDFORM.