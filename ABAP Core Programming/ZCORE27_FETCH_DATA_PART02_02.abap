*&---------------------------------------------------------------------*
*& Report ZCORE27_FETCH_DATA_PART02_02
*&---------------------------------------------------------------------*
*& Reading a Single Record
*&---------------------------------------------------------------------*
REPORT zcore27_fetch_data_part02_02.

TYPES: BEGIN OF ty_cust,

         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,

       END OF ty_cust.

PARAMETERS: p_kunnr TYPE kunnr.

DATA: ty_cust TYPE TABLE OF ty_cust,
      wa_cust TYPE ty_cust.

START-OF-SELECTION.

  PERFORM get_data.

  IF sy-subrc EQ 0.

    MESSAGE 'Customer found' TYPE 'I'.
    PERFORM display_data.

  ELSE.

    MESSAGE 'Customer not found...' TYPE 'W'.

  ENDIF.

*--------------------------------------------------------------------*
*  FORMS                                                             *
*--------------------------------------------------------------------*

FORM get_data.

  SELECT SINGLE kunnr
                land1
                name1
                ort01
    FROM kna1
    INTO wa_cust
    WHERE kunnr = p_kunnr.

ENDFORM.

FORM display_data.

  WRITE:/(20) 'Customer Number:', wa_cust-kunnr,
        /(20) 'Customer Country:', wa_cust-land1,
        /(20) 'Customer Name:', wa_cust-name1,
        /(20) 'Customer City:', wa_cust-ort01.

ENDFORM.