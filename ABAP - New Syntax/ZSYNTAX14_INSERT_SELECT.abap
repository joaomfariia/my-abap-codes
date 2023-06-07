*&---------------------------------------------------------------------*
*& Report ZSYNTAX14_INSERT_SELECT
*&---------------------------------------------------------------------*
*& Insert with Select
*&---------------------------------------------------------------------*
REPORT zsyntax14_insert_select.

*==================================================================
* Before ABAP 7.4
*==================================================================

DATA: it_emp LIKE TABLE OF zemployee,
      wa_emp LIKE LINE OF it_emp.

DATA: it_emp_new LIKE TABLE OF zemployee.

SELECT *
  FROM zemployee
  INTO TABLE it_emp.

IF sy-subrc EQ 0.
  LOOP AT it_emp INTO wa_emp.
    INSERT wa_emp INTO TABLE it_emp_new.
  ENDLOOP.

ELSE.
  MESSAGE |Data could not be retrieved!| TYPE 'E'.

ENDIF.

*==================================================================
* After ABAP 7.4
*==================================================================

INSERT zemployee_new FROM ( SELECT * FROM zemployee ).