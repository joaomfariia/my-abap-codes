*&---------------------------------------------------------------------*
*& Report ZCORE11_STRUCTURES_PART01
*&---------------------------------------------------------------------*
*& Move, Move-correspoding, Clear
*&---------------------------------------------------------------------*
REPORT zcore11_structures_part01.

*-------------------------------------------
*	Declaring Structure - Syntax 1
*-------------------------------------------
DATA: BEGIN OF emp1,
        enum      TYPE i,
        ename(15) TYPE c,           " Length syntax 1
        erole     TYPE c LENGTH 20, " Length syntax 2
      END OF emp1.

emp1-enum = 1.
emp1-ename = 'João'.
emp1-erole = 'Engineer'.

FORMAT COLOR 5.
WRITE: / '--- EMPLOYEES STRUCTURE ---'.
SKIP.
FORMAT COLOR OFF.

WRITE: / 'Employee 1 Structure'.
SKIP.
WRITE: / emp1-enum LEFT-JUSTIFIED, emp1-ename, emp1-erole.
ULINE.

*-------------------------------------------
*	Declaring Structure - Syntax 2
*-------------------------------------------

DATA: emp2 LIKE emp1,
      emp3 LIKE emp1.    " referring the last structure

emp2-enum = 2.
emp2-ename = 'Roberta'.
emp2-erole = 'Manager'.

WRITE: / 'Employee 2 Structure '.
SKIP.
WRITE: / emp2-enum LEFT-JUSTIFIED, emp2-ename, emp2-erole.
ULINE.

CLEAR emp2.
WRITE: / 'Employee 2 Structure after clear'.
SKIP.
WRITE: / emp2-enum LEFT-JUSTIFIED, emp2-ename, emp2-erole.
ULINE.

MOVE-CORRESPONDING emp1 TO emp2. " assign components with same name
WRITE: / 'Employee 2 Structure after move corresponding'.
SKIP.
WRITE: / emp2-enum LEFT-JUSTIFIED, emp2-ename, emp2-erole.
ULINE.

MOVE emp1 TO emp3.
WRITE: / 'Moving Employee 1 info to Employee 3'.
SKIP.
WRITE: / emp3-enum LEFT-JUSTIFIED, emp3-ename, emp3-erole.
ULINE.
SKIP 2.

*-------------------------------------------
*	Declaring Other Structure
*-------------------------------------------

DATA: BEGIN OF dept,
        deptnum  TYPE i,
        deptname TYPE c LENGTH 10,
      END OF dept.

FORMAT COLOR 3.
WRITE: / '--- DEPARTMENT STRUCTURE ---'.
SKIP.
FORMAT COLOR OFF.

*emp1 = dept. " syntax error
dept = emp1.
WRITE: / 'Department Structure after assigning Employee 1 to it'.
SKIP.
WRITE: / dept-deptnum LEFT-JUSTIFIED, dept-deptname.
ULINE.

MOVE emp1 TO dept.
WRITE: / 'Department Structure after moving Employee 1 to it'.
SKIP.
WRITE: / dept-deptnum LEFT-JUSTIFIED, dept-deptname.
ULINE.

MOVE-CORRESPONDING emp1 TO dept.
WRITE: / 'Department Structure after moving corresponding Employee 1 to it'.
SKIP.
WRITE: / dept-deptnum LEFT-JUSTIFIED, dept-deptname.
ULINE.