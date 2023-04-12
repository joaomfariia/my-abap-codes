*&---------------------------------------------------------------------*
*& Report ZJP_DATE_MAX_MIN
*&---------------------------------------------------------------------*
*& Initial and Final Date of a Month
*&---------------------------------------------------------------------*
REPORT zjp_date_max_min.

DATA: gv_date   TYPE dats VALUE '20240217',
      gv_date_i TYPE dats,
      gv_date_f TYPE dats.

DATA gv_month TYPE numc2.

CALL FUNCTION 'LAST_DAY_OF_MONTHS'
  EXPORTING
    day_in            = gv_date
  IMPORTING
    last_day_of_month = gv_date_f
  EXCEPTIONS
    day_in_no_date    = 1
    OTHERS            = 2.

IF sy-subrc <> 0.
  MESSAGE |Problema ao converter data { gv_date }.| TYPE 'E' DISPLAY LIKE 'E'.
ENDIF.

gv_month = gv_date+4(2).

gv_date_i = |{ gv_date+0(6) }| && |01|.

WRITE: |Date: | && |{ gv_date }|,
      / |Initial Day of Month: | && |{ gv_date_i }|,
      / |Final Day of Month: | && |{ gv_date_f }|.