*&---------------------------------------------------------------------*
*& Report ZCORE13_TABBED_SUBSCREENS
*&---------------------------------------------------------------------*
*& Standard Syntax for Declaring Structures
*&---------------------------------------------------------------------*
REPORT zcore12_structures_part02_03 .

*-------------------------------------------
*	Template Structure
*-------------------------------------------

* Memory is not allocated, it's just a template!
TYPES: BEGIN OF ty_emp,
         enum      TYPE i,
         ename(20) TYPE c,
         erole(20) TYPE c,
       END OF ty_emp.

*ty_emp-enum = 1.    " syntax error due to memory allocation

*-------------------------------------------
*	Work area to access the template data
*-------------------------------------------

DATA: wa_emp TYPE ty_emp.

wa_emp-enum = 1.
wa_emp-ename = 'João'.
wa_emp-erole = 'Developer'.

WRITE: / 'wa_emp Structure'.

WRITE: / wa_emp-enum,
         wa_emp-ename,
         wa_emp-erole.