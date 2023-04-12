*&---------------------------------------------------------------------*
*& Report ZJP03_DATA_TYPES_SYS_FIELDS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znt03_data_types_sys_fields.

DATA: n1 TYPE i.       "declaration

n1 = 105.              "assignment
WRITE: 'Integer:', n1. "display

n1 = '123.45'. " n1 = 123.45. --syntax error
WRITE:/ 'Integer:',  n1.

n1 = '123.87'.
WRITE:/ 'Integer:', n1.
ULINE.

DATA: n2 TYPE p.
n2 = '123.45'.
WRITE:/ 'Packed number w/o decimals(2):', n2.
ULINE.

DATA: n3 TYPE p DECIMALS 2.
n3 = '123.45'.
WRITE:/ 'Packed number w/ decimals(2):', n3.
ULINE.

DATA: c1 TYPE c.
c1 = 'This is a string!'.
WRITE:/ 'Type c:', c1.
ULINE.

DATA: c2(10) TYPE c. "array of characters
c2 = 'This is a string!'.
WRITE:/ 'Type c Length(10):', c2.
ULINE.

DATA: c3 TYPE string.
c3 = 'This is a string!'.
WRITE:/ 'Type string:', c3.
ULINE.

DATA: date TYPE d.                             "date - 8 bytes
date = sy-datum.                               "sys field for AS current date
WRITE:/ date.                                  "format DDMMYYYY
WRITE:/(10) date.                              "format DD.MM.YYYY
WRITE:/(10) date USING EDIT MASK '__/__/____'. "DD/MM/YYYY
ULINE.

DATA: time TYPE t. "time - 6 bytes
time = sy-uzeit.   "sys field for AS current time
WRITE:/ time.      "HHMMSS
WRITE:/(8) time.   "HH:MM:SS
WRITE:/(8) time USING EDIT MASK '__-__-__'. "HH-MM-SS
ULINE.

WRITE:/ 'Current program name', sy-repid.  "current program name
WRITE:/ 'Login user name', sy-uname.       "login user name
WRITE:/ 'Current page number', sy-pagno.   "current page number
WRITE:/ 'Current screen number', sy-dynnr. "current screen number