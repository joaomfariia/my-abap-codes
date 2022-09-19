*&---------------------------------------------------------------------*
*& Report ZCORE12_STRUCTURES_PART02
*&---------------------------------------------------------------------*
*& Nested Structures
*&---------------------------------------------------------------------*
REPORT zcore12_structures_part02.

DATA: BEGIN OF emp,
        enum      TYPE i,
        ename(20) TYPE c,
        BEGIN OF dept,          " Inner/nested structure
          deptnum      TYPE i,
          deptname(20) TYPE c,
        END OF dept,
        erole(20) TYPE c,
      END OF emp.

emp-enum = 1.
emp-ename = 'João'.
emp-dept-deptnum = 10.  " Nested component
emp-dept-deptname = 'Development'.
emp-erole = 'ABAP Developer'.

WRITE: /(20)'Employee Number   :', emp-enum LEFT-JUSTIFIED,
       /(20)'Employee Name     :', emp-ename,
       /(20)'Department Number :', emp-dept-deptnum LEFT-JUSTIFIED,
       /(20)'Department Number :', emp-dept-deptname,
       /(20)'Employee Role     :', emp-erole.