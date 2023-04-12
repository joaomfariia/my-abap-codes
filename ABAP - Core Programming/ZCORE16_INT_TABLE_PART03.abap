*&---------------------------------------------------------------------*
*& Report ZCORE16_INTERNAL_TABLE_PART03
*&---------------------------------------------------------------------*
*& Read, sy-subrc, Index, Searching
*&---------------------------------------------------------------------*
REPORT zcore16_int_table_part03.

*-------------------------------------------
*	Declaring Structure, Internal Table and WA
*-------------------------------------------

TYPES: BEGIN OF ty_emp,
         enum      TYPE i,
         ename(20) TYPE c,
         erole(20) TYPE c,
       END OF ty_emp.

DATA: it_emp TYPE TABLE OF ty_emp WITH NON-UNIQUE KEY enum,
      wa_emp TYPE ty_emp.

*-------------------------------------------
*	Assigning Values to Work Area
*-------------------------------------------

CLEAR wa_emp.
wa_emp-enum = 1.
wa_emp-ename = 'João'.
wa_emp-erole = 'Developer'.
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

CLEAR wa_emp.
wa_emp-enum = 7.
wa_emp-ename = 'Jardete'.
wa_emp-erole = 'Employee'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-enum = 5.
wa_emp-ename = 'Josh'.
wa_emp-erole = 'Employee'.
APPEND wa_emp TO it_emp.

*-------------------------------------------
*	Writing the data
*-------------------------------------------

WRITE: / 'Data of Internal Table 1'.
SKIP.

LOOP AT it_emp INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole, sy-tabix, sy-index.

ENDLOOP.
ULINE.

*-------------------------------------------
*	Read Internal Table
*-------------------------------------------

CLEAR wa_emp.
READ TABLE it_emp INTO wa_emp INDEX 3.

IF sy-subrc = 0.
  WRITE: / 'Third record found'.
  SKIP.
  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.
ELSE.
  WRITE: / 'Third record not found'.
ENDIF.
ULINE.

CLEAR wa_emp.
READ TABLE it_emp INTO wa_emp INDEX 5 TRANSPORTING enum ename.  " just enum ename

IF sy-subrc = 0.
  WRITE: / 'Fifth record found'.
  SKIP.
  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.
ELSE.
  WRITE: / 'Fifth record not found'.
ENDIF.
ULINE.

CLEAR wa_emp.
SORT it_emp BY enum ASCENDING.

* BINARY SEARCH -> table must be sorted in ascending order
READ TABLE it_emp INTO wa_emp WITH KEY enum = 7 BINARY SEARCH.

IF sy-subrc = 0.
  WRITE: / 'Employee number 7 found'.
  SKIP.
  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.
ELSE.
  WRITE: / 'Employee number 7 not found'.
ENDIF.
ULINE.

* Check existance of the data

CLEAR wa_emp.

* TRANSPORTING NO FIELD -> just to check if data exists
READ TABLE it_emp WITH KEY enum = 10 TRANSPORTING NO FIELDS.

IF sy-subrc = 0.
  WRITE: / 'Employee number 8 found'.
  SKIP.
  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.
ELSE.
  WRITE: / 'Employee number 8 not found'.
ENDIF.
ULINE.