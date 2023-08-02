*&---------------------------------------------------------------------*
*& Report ZCORE12_STRUCTURES_PART02_04
*&---------------------------------------------------------------------*
*& Field Symbols
*&---------------------------------------------------------------------*
REPORT zcore12_structures_part02_04.


DATA: gv_x   TYPE i VALUE 10,
      gv_str TYPE string VALUE 'Learning ABAP!!'.

*FIELD-SYMBOLS abc. " syntax error

FIELD-SYMBOLS <abc>.

WRITE: / 'Before assigning gv_x to field symbol <abc>.'.
SKIP.
WRITE: / 'gv_x   is', gv_x,
       / 'gv_str is', gv_str,
       / '<abc>  is', <abc>.
ULINE.

*-------------------------------------------
*	Assigning Values To Field Symbol
*-------------------------------------------

WRITE: / 'After assigning gv_x to field symbol <abc>.'.
SKIP.

*<abc> = gv_x " syntax error
ASSIGN gv_x TO <abc>.

WRITE: / 'gv_x   is', gv_x,
       / 'gv_str is', gv_str,
       / '<abc>  is', <abc>.
ULINE.

WRITE: / 'After assigning gv_str to field symbol <abc>.'.
SKIP.

*<abc> = gv_str " syntax error
ASSIGN gv_str TO <abc>.

WRITE: / 'gv_x   is', gv_x,
       / 'gv_str is', gv_str,
       / '<abc>  is', <abc>.
ULINE.

WRITE: / 'Changing gv_str value and printing data again.'.
SKIP.

gv_str = 'Learning how to program.'.

WRITE: / 'gv_x   is', gv_x,
       / 'gv_str is', gv_str,
       / '<abc>  is', <abc>.  " now carries gv_str value
ULINE.

WRITE: / 'Changing <abc> value and printing data again.'.
SKIP.

<abc> = 'Field-symbol changed!'.

WRITE: / 'gv_x   is', gv_x,
       / 'gv_str is', gv_str,
       / '<abc>  is', <abc>.  " now carries <abc> new value