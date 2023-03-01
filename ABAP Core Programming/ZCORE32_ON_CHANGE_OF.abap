*&---------------------------------------------------------------------*
*& Report ZCORE33_ON_CHANGE_OF
*&---------------------------------------------------------------------*
*& ON CHANGE OF event - Example 2
*&---------------------------------------------------------------------*
REPORT zcore32_on_change_of.

TYPES: BEGIN OF ty_customer,

         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,

       END OF ty_customer.

DATA: it_customer TYPE TABLE OF ty_customer,
      wa_customer TYPE ty_customer.

SELECT kunnr,
       land1,
       name1,
       ort01
  FROM kna1
  INTO TABLE @it_customer
  UP TO 100 ROWS.         "limits the query

IF sy-subrc EQ 0.

  SORT it_customer BY land1.

  LOOP AT it_customer INTO wa_customer.

    ON CHANGE OF wa_customer-land1.

      FORMAT COLOR 3.
      WRITE:/ 'Customer Country:', wa_customer-land1.

    ENDON.

    FORMAT COLOR 5.
    WRITE:/ wa_customer-kunnr,
            wa_customer-name1,
            wa_customer-ort01.

  ENDLOOP.

ELSE.

  WRITE:/ 'No data found...'.

ENDIF.