*&---------------------------------------------------------------------*
*& Report ZCORE28_FETCH_DATA_PART03
*&---------------------------------------------------------------------*
*& Retrieving Multiple Data Into Internal Table
*&---------------------------------------------------------------------*
REPORT zcore28_fetch_data_part03.

TABLES: kna1.

TYPES: BEGIN OF ty_cust,

         kunnr TYPE kna1-kunnr,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,

       END OF ty_cust.

DATA: it_cust  TYPE TABLE OF ty_cust,
      wa_cust  TYPE ty_cust,
      cl_table TYPE REF TO cl_salv_table.

SELECT-OPTIONS so_land1 FOR kna1-land1.

*--------------------------------------------------------------------*
*  START OF SELECTION                                                *
*--------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_data.

  IF sy-subrc EQ 0.

    MESSAGE 'Customer data found!!' TYPE 'I'.

    PERFORM display_data.

  ELSE.

    MESSAGE 'No data found!!' TYPE 'I'.

  ENDIF.

*--------------------------------------------------------------------*
*  FORMS                                                             *
*--------------------------------------------------------------------*

FORM get_data.

  SELECT kunnr
         name1
         ort01
    FROM kna1
    INTO TABLE it_cust
    WHERE land1 IN so_land1.

  SORT it_cust BY kunnr.

ENDFORM.


FORM display_data.

  CALL METHOD cl_salv_table=>factory    "creates the alv table
*    EXPORTING
*      list_display = abap_true    "a different whey to display data
    IMPORTING
      r_salv_table = cl_table
    CHANGING
      t_table      = it_cust.

  PERFORM alv_functions.

  CALL METHOD cl_table->display. "displays the alv table

ENDFORM.


FORM alv_functions.

  DATA: lc_functions TYPE REF TO cl_salv_functions.

  lc_functions = cl_table->get_functions( ).         "get functions from alv class table
  lc_functions->set_all( abap_true ).                "activates the functions

ENDFORM.