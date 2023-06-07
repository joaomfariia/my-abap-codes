*&---------------------------------------------------------------------*
*& Report ZSYNTAX03_ITAB_EXPRESSIONS
*&---------------------------------------------------------------------*
*& Read Table
*&---------------------------------------------------------------------*
REPORT zsyntax03_read_table.

TABLES: zemployee.

SELECT FROM zemployee
  FIELDS *
  INTO TABLE @DATA(gt_emp).

*READ TABLE gt_emp INTO DATA(ls_emp) INDEX 1.
*
*DATA(ls_emp) = gt_emp[ 1 ].
*WRITE: 'Index 1: ', ls_emp.
*ULINE.

*==================================================================
* WAY 1 - Inline
*==================================================================
TRY.

    DATA(ls_emp) = gt_emp[ zempid = '1' zempname = 'JOÃO PEDRO' zemprole = 'DEVELOPER' ].
    MESSAGE 'Data found!' TYPE 'I' DISPLAY LIKE 'S'.

  CATCH cx_sy_itab_line_not_found.

    MESSAGE 'No record found...' TYPE 'I' DISPLAY LIKE 'E'.

ENDTRY.

*==================================================================
* WAY 2 - line_exists with exception
*==================================================================
TRY.

    IF line_exists( gt_emp[ zempid = '2' zempname = 'EMPLOYEE2' zemprole = 'MANAGER' ] ).
      MESSAGE 'Line exists!' TYPE 'I' DISPLAY LIKE 'S'.
    ENDIF.

  CATCH cx_sy_itab_line_not_found.

    MESSAGE 'Lines do not exists' TYPE 'I' DISPLAY LIKE 'E'.

ENDTRY.

*==================================================================
* WAY 3 - line_exists w/o exception
*==================================================================
DATA(lv_index) = line_index( gt_emp[ zempid = '3' zempname = 'EMPLOYEE3' zemprole = 'TECH LEADER' ] ).

IF lv_index > 0.
  DATA(ls_emp2) = gt_emp[ lv_index ].
  MESSAGE 'Index data found!' TYPE 'I' DISPLAY LIKE 'S'.

ELSE.
  MESSAGE 'No index data found!' TYPE 'I' DISPLAY LIKE 'E'.

ENDIF.

*==================================================================
* WAY 4 - Value operator
*==================================================================
** The OPTIONAL keyword prevents a dump
DATA(ls_emp3) = VALUE #( gt_emp[ zempid = '99' zempname = 'EMPLOYEE4' zemprole = 'SUPERVISOR' ] OPTIONAL ).