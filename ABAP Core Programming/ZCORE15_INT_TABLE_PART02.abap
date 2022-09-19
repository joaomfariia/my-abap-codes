*&---------------------------------------------------------------------*
*& Report ZCORE15_INTERNAL_TABLE_PART02
*&---------------------------------------------------------------------*
*& Work areas, Insert, Append, Keys, Sort
*&---------------------------------------------------------------------*
REPORT zcore15_int_table_part02.

*-------------------------------------------
*	Declaring Structure, Internal Table and WA
*-------------------------------------------

TYPES: BEGIN OF ty_emp,
         enum      TYPE i,
         ename(20) TYPE c,
         erole(20) TYPE c,
       END OF ty_emp.

DATA: it_emp TYPE TABLE OF ty_emp,
      wa_emp TYPE ty_emp.

*-------------------------------------------
*	Assigning Values to Work Area
*-------------------------------------------

CLEAR wa_emp.
wa_emp-enum = 1.
wa_emp-ename = 'João'.
wa_emp-erole = 'Engineer'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-enum = 2.
wa_emp-ename = 'Arthur'.
wa_emp-erole = 'Manager'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-enum = 3.
wa_emp-ename = 'Marcelo'.
wa_emp-erole = 'Director'.
APPEND wa_emp TO it_emp.

*-------------------------------------------
*	Writing the data
*-------------------------------------------

WRITE: / 'Data of Internal Table 1'.
SKIP.

LOOP AT it_emp INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.
ULINE.

CLEAR wa_emp.
wa_emp-enum = 7.
wa_emp-ename = 'Ana'.
wa_emp-erole = 'Supervisor'.
INSERT wa_emp INTO it_emp INDEX 2.

WRITE: / 'Data of Internal Table 1 after INSERT'.
SKIP.

LOOP AT it_emp INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.
ULINE.

*-------------------------------------------
*	Declaring a Second Internal Table
*-------------------------------------------

DATA: it_emp2 TYPE TABLE OF ty_emp WITH NON-UNIQUE KEY enum.  " enum -> secondary key

APPEND LINES OF it_emp TO it_emp2.

WRITE: / 'Data of Internal Table 2 after APPEND LINES'.
SKIP.

LOOP AT it_emp2 INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.
ULINE.

*-------------------------------------------
*	Sorting Internal Tables
*-------------------------------------------

SORT it_emp.  " default sorting by character
WRITE: / 'Data of Internal Table 1 after SORT'.
SKIP.

LOOP AT it_emp INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.
uline.

SORT it_emp2. " its definition sorts it by employee number (enum)
WRITE: / 'Data of Internal Table 2 after SORT by ENUM'.
SKIP.

LOOP AT it_emp2 INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.
uline.

SORT it_emp2 by erole DESCENDING.
WRITE: / 'Data of Internal Table 2 after SORT by EROLE (descending)'.
SKIP.

LOOP AT it_emp2 INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.