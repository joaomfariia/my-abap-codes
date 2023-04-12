*&---------------------------------------------------------------------*
*& Report ZCORE33_SELECT_ENDSELECT
*&---------------------------------------------------------------------*
*& ON CHANGE OF event in SELECT..ENDSELECT
*&---------------------------------------------------------------------*
REPORT zcore33_on_change_of_02.

TYPES: BEGIN OF ty_customer,

         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,
         ort01 TYPE kna1-ort01,

       END OF ty_customer.

DATA: it_customer TYPE TABLE OF ty_customer,
      wa_customer TYPE ty_customer.

**SELECT kunnr,                       "bad performance - not recommended!!
**       land1,
**       name1,
**       ort01
**  FROM kna1
**  INTO @wa_customer
**  WHERE land1 IN ('BR','DE','CA')
**  ORDER BY land1 ASCENDING.         "can't sort because it's is not a table!!
**
**  ON CHANGE OF wa_customer-land1.
**
**    FORMAT COLOR 3.
**    WRITE:/ 'Country Key', wa_customer-land1.
**
**  ENDON.
**
**  FORMAT COLOR 1.
**  WRITE:/5 wa_customer-kunnr,
**           wa_customer-land1,
**           wa_customer-name1,
**           wa_customer-ort01.
**
**ENDSELECT.

SELECT kunnr,
       land1,
       name1,
       ort01
  FROM kna1
  INTO TABLE @it_customer
  WHERE land1 IN ('BR','DE','CA')
  ORDER BY land1 ASCENDING.         "can't sort because it's is not a table!!

IF sy-subrc EQ 0.

  SORT it_customer BY land1.

  LOOP AT it_customer INTO wa_customer.

    ON CHANGE OF wa_customer-land1.

      FORMAT COLOR 3.
      WRITE:/ 'Country Key', wa_customer-land1.

    ENDON.

    FORMAT COLOR 1.
    WRITE:/5 wa_customer-kunnr,
             wa_customer-land1,
             wa_customer-name1,
             wa_customer-ort01.

  ENDLOOP.

ENDIF.