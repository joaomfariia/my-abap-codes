*&---------------------------------------------------------------------*
*& Report zcore26_fetch_data_part01
*&---------------------------------------------------------------------*
*& Data Retrieval - Database Fields
*&---------------------------------------------------------------------*
REPORT zcore27_fetch_data_part02.

*Bad data definition!!

*DATA: k1 TYPE c LENGTH 10,
*      k2 TYPE c LENGTH 3,
*      k3 TYPE c LENGTH 35,
*      k4 TYPE c LENGTH 35.

*Data definition based on data elements

*DATA: k1 type kunnr,
*      k2 type land1_gp,
*      k3 type name1_gp,
*      k4 type ort01_gp. (or)

*Data definition based on data fields

*DATA: k1 TYPE kna1-kunnr,
*      k2 TYPE kna1-land1,
*      k3 TYPE kna1-name1,
*      k4 TYPE kna1-ort01. (or)

*Data definition based on data fields #02

DATA: kunnr TYPE kna1-kunnr,
      land1 TYPE kna1-land1,
      name1 TYPE kna1-name1,
      ort01 TYPE kna1-ort01.

*PARAMETERS: p_cust TYPE c LENGTH 10. "generic type

*PARAMETERS: p_cust TYPE kna1-kunnr. "referring to field

PARAMETERS: p_cust TYPE kunnr. "referring to data element

SELECT SINGLE kunnr
              land1
              name1
              ort01
    FROM kna1
    INTO ( kunnr, land1, name1, ort01 )
    WHERE kunnr = p_cust.

IF sy-subrc EQ 0.

  MESSAGE 'Customer found!' TYPE 'I'.

  WRITE:/(20) 'Customer Number:', kunnr,
        /(20) 'Customer Country:', land1,
        /(20) 'Customer Name:', name1,
        /(20) 'Customer City:', ort01.

ELSE.

  MESSAGE 'Customer not found...' TYPE 'W'.

ENDIF.