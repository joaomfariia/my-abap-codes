*&---------------------------------------------------------------------*
*& Report ZCORE17_INTERNAL_TABLE_PART04
*&---------------------------------------------------------------------*
*& Sorted Internal Table
*&---------------------------------------------------------------------*
REPORT zcore17_int_table_part04.

*-------------------------------------------
*	Declaring Structure, Internal Table and WA
*-------------------------------------------

TYPES: BEGIN OF ty_emp,
         enum      TYPE i,
         ename(20) TYPE c,
         erole(20) TYPE c,
       END OF ty_emp.

* SORTED TABLES -> the key is mandatory!!
* DATA: it_emp TYPE SORTED TABLE OF ty_emp.     " syntax error

DATA: it_emp TYPE SORTED TABLE OF ty_emp WITH UNIQUE KEY enum,
      wa_emp TYPE ty_emp.

*-------------------------------------------
*	Declaring Structure, Internal Table and WA
*-------------------------------------------

* APPEND can only be used in SORTED tables as a sequence key field
CLEAR wa_emp.
wa_emp-enum = 7.
wa_emp-ename = 'João'.
wa_emp-erole = 'Developer'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-enum = 13.
wa_emp-ename = 'Ana'.
wa_emp-erole = 'Teacher'.
APPEND wa_emp TO it_emp.

* INSERT must be used if the sequence key(enum) is "broken"
CLEAR wa_emp.
wa_emp-enum = 3.
wa_emp-ename = 'Marcelo'.
wa_emp-erole = 'Manager'.
INSERT wa_emp INTO TABLE it_emp.

CLEAR wa_emp.
wa_emp-enum = 1.
wa_emp-ename = 'Arthur'.
wa_emp-erole = 'Employee'.
INSERT wa_emp INTO TABLE it_emp.

*-------------------------------------------
*	Writing the Data
*-------------------------------------------

WRITE: / 'Internal Table sorted by unique key (enum)'.
SKIP.

LOOP AT it_emp INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.

*-------------------------------------------
*	Reading the Data - Sequential Search
*-------------------------------------------

ULINE.
CLEAR wa_emp.
READ TABLE it_emp INTO wa_emp INDEX 3.

IF sy-subrc = 0.
  WRITE: / 'Third record found'.
  SKIP.
  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.
ELSE.
  WRITE: / 'Third record not found...'.
ENDIF.

*-------------------------------------------
*	Reading the Data - Binary Search
*-------------------------------------------

ULINE.
CLEAR wa_emp.
READ TABLE it_emp INTO wa_emp with key enum = 13 BINARY SEARCH.

IF sy-subrc = 0.
  WRITE: / '13th record found'.
  SKIP.
  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.
ELSE.
  WRITE: / '13th record not found...'.
ENDIF.