*&---------------------------------------------------------------------*
*& Report ZCORE18_INT_TABLE_PART05
*&---------------------------------------------------------------------*
*& Passing Internal Tables as Parameters to Subroutines
*&---------------------------------------------------------------------*
REPORT zcore18_int_table_part05.

TYPES: BEGIN OF ty_emp,
         enum  TYPE i,
         ename TYPE c LENGTH 20,
         erole TYPE c LENGTH 20,
       END OF ty_emp.

DATA: it_emp TYPE TABLE OF ty_emp,
      wa_emp TYPE ty_emp.

CLEAR wa_emp.
wa_emp-enum = 6.
wa_emp-ename = 'João'.
wa_emp-erole = 'Developer'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-enum = 3.
wa_emp-ename = 'Ana'.
wa_emp-erole = 'Teacher'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-enum = 10.
wa_emp-ename = 'Marcelo'.
wa_emp-erole = 'Manager'.
APPEND wa_emp TO it_emp.

CLEAR wa_emp.
wa_emp-enum = 15.
wa_emp-ename = 'Arthur'.
wa_emp-erole = 'Director'.
APPEND wa_emp TO it_emp.

*-------------------------------------------
*	Calling Subroutine
*-------------------------------------------

PERFORM sub1 USING it_emp.  " syntax 1
ULINE.

PERFORM sub2 TABLES it_emp. " syntax 2
ULINE.

WRITE: / 'Data from it_emp after deleting Teacher role'.
SKIP.

PERFORM sub3 TABLES it_emp. " deletes a record
PERFORM sub2 TABLES it_emp.
ULINE.

WRITE: / 'Data from it_emp after modifying Developer to CEO'.
SKIP.

PERFORM sub4 TABLES it_emp.
PERFORM sub2 TABLES it_emp.
ULINE.

*-------------------------------------------
*	Defining Subroutine Syntaxes
*-------------------------------------------

FORM sub1 USING k1.           "k1 = formal parameter

  LOOP AT it_emp INTO wa_emp. "can't loop at k1 (not an i.table)

    WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

  ENDLOOP.

ENDFORM.

FORM sub2 TABLES k1.          "k1 = formal parameter

  LOOP AT k1 INTO wa_emp.     "can loop at k1 (it's an i.table)

    WRITE: / wa_emp-enum, wa_emp-ename, wa_emp-erole.

  ENDLOOP.

ENDFORM.

FORM sub3 TABLES k1 STRUCTURE wa_emp. "must refer the work area!!

  DELETE k1 WHERE erole = 'Teacher'.

ENDFORM.

FORM sub4 TABLES k1 STRUCTURE wa_emp.

  CLEAR wa_emp.
  wa_emp-erole = 'CEO'.
  MODIFY k1 FROM wa_emp TRANSPORTING erole WHERE erole = 'Developer'.

ENDFORM.

*-------------------------------------------
*	Other Subroutine 3 Syntaxes
*-------------------------------------------

*FORM sub3 TABLES k1.
*
*  DELETE it_emp WHERE erole = 'Teacher'.
*
*ENDFORM.

*FORM sub3 TABLES it_emp STRUCTURE wa_emp.
*
*  DELETE it_emp WHERE erole = 'Teacher'.
*
*ENDFORM.