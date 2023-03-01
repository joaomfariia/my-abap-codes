*&---------------------------------------------------------------------*
*& Report ZCORE36_INNER_LEFT_OUTER_JOIN
*&---------------------------------------------------------------------*
*& Select | Inner Join | Left Outer Join
*&---------------------------------------------------------------------*
REPORT zcore37_left_outer_join.

TYPES: BEGIN OF ty_sflight,

         carrid   TYPE sflight-carrid,
         fldate   TYPE sflight-fldate,
         price    TYPE sflight-price,
         currency TYPE sflight-currency,
         cityfrom TYPE spfli-cityfrom,
         cityto   TYPE spfli-cityto,

       END OF ty_sflight.

DATA: it_sflight TYPE TABLE OF ty_sflight,
      wa_sflight TYPE ty_sflight.

DATA: gv_carrid TYPE sflight-carrid.

DATA: gv_string TYPE string.

SELECT-OPTIONS so_carr FOR gv_carrid DEFAULT 'DL'.

START-OF-SELECTION.

* Get customers and their sales data
  PERFORM get_flight_info.

  IF it_sflight IS NOT INITIAL.

    gv_string = 'Num of Entries: ' && '' && sy-dbcnt.

    MESSAGE gv_string TYPE 'I'.

    PERFORM display_flight_info.

  ELSE.

    MESSAGE 'Flight info not found!' TYPE 'I' DISPLAY LIKE 'E'.

  ENDIF.

*--------------------------------------------------------------------*
* SUBROUTINES                                                        *
*--------------------------------------------------------------------*

FORM get_flight_info.

  SELECT a~carrid,
         a~fldate,
         price,
         currency,
         cityfrom,
         cityto
    FROM sflight AS a
    INNER JOIN spfli AS b
      ON a~carrid = b~carrid
    INTO TABLE @it_sflight
    WHERE a~carrid IN @so_carr.

ENDFORM.

FORM display_flight_info.

  SORT it_sflight BY fldate DESCENDING.

  cl_demo_output=>display( it_sflight ).

ENDFORM.