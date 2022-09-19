*&---------------------------------------------------------------------*
*& Report ZCORE12_STRUCTURES_PART02
*&---------------------------------------------------------------------*
*& Including Structures
*&---------------------------------------------------------------------*
REPORT zcore12_structures_part02_02.

* Department
DATA: BEGIN OF dept,
        deptnum      TYPE i,
        deptname(20) TYPE c,
      END OF dept.

* Employee
DATA: BEGIN OF emp,
        enum      TYPE i,
        ename(20) TYPE c.
        INCLUDE STRUCTURE dept. " need a period before statement
DATA:   erole(20) TYPE c,       " declaring structure again
      END OF emp.