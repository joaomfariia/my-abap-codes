*&---------------------------------------------------------------------*
*& Report zcore26_fetch_data_part01
*&---------------------------------------------------------------------*
*& Data Retrieval - SELECT SINGLE
*&---------------------------------------------------------------------*
REPORT zcore26_fetch_data_part01.

*Bad data definition!!

DATA: k1 TYPE c LENGTH 10,
      k2 TYPE c LENGTH 3,
      k3 TYPE c LENGTH 35,
      k4 TYPE c LENGTH 35.

PARAMETERS: p_cust TYPE c LENGTH 10. "generic type

SELECT SINGLE kunnr,    "OPEN SQL syntax
              land1,
              name1,
              ort01
    FROM kna1
    INTO ( @k1, @k2, @k3, @k4 )
    WHERE kunnr = @p_cust.

IF sy-subrc EQ 0.

  MESSAGE 'Customer found!' TYPE 'I'.

  WRITE:/(20) 'Customer Number:', k1,
        /(20) 'Customer Country:', k2,
        /(20) 'Customer Name:', k3,
        /(20) 'Customer City:', k4.

ELSE.

  MESSAGE 'Customer not found...' TYPE 'W'.

ENDIF.