*&---------------------------------------------------------------------*
*& Report ZCORE17_INTERNAL_TABLE_PART04
*&---------------------------------------------------------------------*
*& Hashed Internal Table
*&---------------------------------------------------------------------*
REPORT zcore17_int_table_part04_02.

*-------------------------------------------
*	Declaring Structure, Internal Table and WA
*-------------------------------------------

TYPES: BEGIN OF ty_emp,
         enum      TYPE i,
         ename(20) TYPE c,
         erole(20) TYPE c,
       END OF ty_emp.

* HASHED TABLE -> indexing is not possible!
* HASHED TABLE -> time to search a record is CONSTANT!

* DATA: it_emp TYPE HASHED TABLE OF ty_emp.     " syntax error
* DATA: it_emp TYPE HASHED TABLE OF ty_emp WITH NON-UNIQUE KEY enum.     " syntax error

DATA: it_emp TYPE HASHED TABLE OF ty_emp WITH UNIQUE KEY enum,
      wa_emp TYPE ty_emp.

*-------------------------------------------
*	Declaring Structure, Internal Table and WA
*-------------------------------------------

* APPEND cannot be used in HASHED TABLES
* INSERT with index statement is not supported

CLEAR wa_emp.
wa_emp-enum = 7.
wa_emp-ename = 'João'.
wa_emp-erole = 'Developer'.
*APPEND wa_emp TO it_emp.                 " syntax error
*INSERT wa_emp INTO TABLE it_emp index 2.  " syntax error
INSERT wa_emp INTO TABLE it_emp.

CLEAR wa_emp.
wa_emp-enum = 13.
wa_emp-ename = 'Ana'.
wa_emp-erole = 'Teacher'.
INSERT wa_emp INTO TABLE it_emp.

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

WRITE: / 'Hashed Internal Table Data'.
SKIP.

LOOP AT it_emp INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.

*-------------------------------------------
*	Sorting the Data
*-------------------------------------------

ULINE.
WRITE: / 'Hashed Internal Table Sorted by Key(ename)'.
SKIP.

CLEAR wa_emp.
SORT it_emp BY ename.

LOOP AT it_emp INTO wa_emp.

  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

ENDLOOP.

*-------------------------------------------
*  Reading the Data - Sequential Search
*-------------------------------------------

ULINE.
CLEAR wa_emp.

* HASHED TABLE -> does not supports INDEX
* READ TABLE it_emp INTO wa_emp index 2.  " syntax error

READ TABLE it_emp INTO wa_emp WITH KEY enum = 3.

IF sy-subrc = 0.
  WRITE: / 'Third record found'.
  SKIP.
  WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.
ELSE.
  WRITE: / 'Third record not found...'.
ENDIF.

*-------------------------------------------
*  Reading the Data - Binary Search
*-------------------------------------------

ULINE.
CLEAR wa_emp.

* HASHED TABLE -> does not supports INDEX
* BINARY SEARCH uses indexes
* READ TABLE it_emp INTO wa_emp WITH KEY enum = 1 BINARY SEARCH. " syntax error