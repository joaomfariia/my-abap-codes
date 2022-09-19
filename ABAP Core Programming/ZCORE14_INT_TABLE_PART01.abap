*&---------------------------------------------------------------------*
*& Report ZCORE14_INTERNAL_TABLE_PART01
*&---------------------------------------------------------------------*
*& Standard Internal Tables - Describe, Header, Body
*&---------------------------------------------------------------------*
REPORT zcore14_int_table_part01.

*-------------------------------------------
*	Template Structure
*-------------------------------------------

TYPES: BEGIN OF ty_emp,

         enum      TYPE i,
         ename(20) TYPE c,
         erole(20) TYPE c,

       END OF ty_emp.

*-------------------------------------------
*	Internal Table and Work Area Declaration
*-------------------------------------------

* data: it_emp type standard table of ty_emp. " one syntax kind

DATA: it_emp TYPE TABLE OF ty_emp WITH HEADER LINE. " header line -> implicity work area

*-------------------------------------------
*	Assigning Values to Internal Table
*-------------------------------------------

CLEAR it_emp.
it_emp-enum = 1.
it_emp-ename = 'João'.
it_emp-erole = 'Developer'.
APPEND it_emp.

CLEAR it_emp.
it_emp-enum = 2.
it_emp-ename = 'Arthur'.
it_emp-erole = 'Manager'.
APPEND it_emp.

CLEAR it_emp.
it_emp-enum = 3.
it_emp-ename = 'Marcelo'.
it_emp-erole = 'Director'.
APPEND it_emp.

CLEAR it_emp.
it_emp-enum = 4.
it_emp-ename = 'Ana'.
it_emp-erole = 'Teacher'.
APPEND it_emp.

*-------------------------------------------
*	Writing the Data from Internal Table
*-------------------------------------------

WRITE: / 'Default Internal Table Header Line'.
SKIP.

WRITE: / it_emp-enum, it_emp-ename, it_emp-erole.   " last header line data
SKIP 2.

WRITE: / 'Data of Internal Table Body'.
SKIP.

LOOP AT it_emp.
  WRITE: / it_emp-enum, it_emp-ename, it_emp-erole.
ENDLOOP.
SKIP 2.

WRITE: / 'Data of Internal Table Body with Role as Manager'.
SKIP.

LOOP AT it_emp WHERE erole = 'Manager'. " case-sensitive
  WRITE: / it_emp-enum, it_emp-ename, it_emp-erole.
ENDLOOP.
ULINE.

*-------------------------------------------
*	Describing Internal Tables
*-------------------------------------------

DESCRIBE TABLE it_emp.
WRITE: / 'Internal Table 1'.
WRITE: / 'Number of records:', sy-tfill LEFT-JUSTIFIED.
WRITE: / 'Number of bytes  :', sy-tleng LEFT-JUSTIFIED.
SKIP.

DATA: it_emp2 TYPE TABLE OF ty_emp.

APPEND LINES OF it_emp TO it_emp2.

DESCRIBE TABLE it_emp2.
WRITE: / 'Internal Table 2'.
WRITE: / 'Number of records after assigning it_emp:', sy-tfill LEFT-JUSTIFIED.
WRITE: / 'Number of bytes  :', sy-tleng LEFT-JUSTIFIED.
SKIP.

DATA: it_emp3 TYPE TABLE OF ty_emp.

*it_emp2 = it_emp3. " syntax error
it_emp3 = it_emp2.

DESCRIBE TABLE it_emp3.
WRITE: / 'Internal Table 3'.
WRITE: / 'Number of records after assigning it_emp2:', sy-tfill LEFT-JUSTIFIED.
WRITE: / 'Number of bytes  :', sy-tleng LEFT-JUSTIFIED.
SKIP.

CLEAR it_emp3[].  " clears the body
*refresh it_emp3.  " clears the body -> obsolete
*free    it_emp3.  " clears the body -> obsolete

DESCRIBE TABLE it_emp3.
WRITE: / 'Internal Table 3'.
WRITE: / 'Number of records after "clear it_emp3[]":', sy-tfill LEFT-JUSTIFIED.
WRITE: / 'Number of bytes  :', sy-tleng LEFT-JUSTIFIED.