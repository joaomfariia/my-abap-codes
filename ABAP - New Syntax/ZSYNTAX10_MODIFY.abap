*&---------------------------------------------------------------------*
*& Report ZSYNTAX10_MODIFY
*&---------------------------------------------------------------------*
*& Modify Statement
*&---------------------------------------------------------------------*
REPORT zsyntax10_modify.

*==================================================================
* OLD SYNTAX
*==================================================================
SELECT *
FROM zemployee
INTO TABLE @DATA(it_emp)
UP TO 5 ROWS.

cl_demo_output=>write( it_emp ).

LOOP AT it_emp INTO DATA(wa_emp) WHERE zempname = 'EMP2'.
  wa_emp-zempname = 'NEW EMPLOYEE 2'.
  wa_emp-zemprole = 'NEW ROLE 2'.
  MODIFY it_emp FROM wa_emp.
ENDLOOP.

cl_demo_output=>display( it_emp ).

*==================================================================
* NEW SYNTAX
*==================================================================
SELECT *
FROM zemployee
INTO TABLE @DATA(it_emp2)
UP TO 5 ROWS.

it_emp2[ zempname = 'EMP3' ]-zemprole = 'NEW ROLE 3'.
it_emp2[ zemprole = 'NEW ROLE 3' ]-zempname = 'NEW EMPLOYEE 3'.

cl_demo_output=>display( it_emp2 ).