*&---------------------------------------------------------------------*
*& Report ZJP08_FIELD_SYMBOLS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znt08_field_symbols.

DATA gv_r TYPE i VALUE 10.

* FIELD-SYMBOLS abc " Syntax error

FIELD-SYMBOLS <abc>. " Capable of storing any type of data

WRITE: / 'Integer variable gv_r is', gv_r,
       / 'Field Symbol <abc> is', <abc>.
ULINE.

*<abc> = gv_r " Runtime error - error at assignment

ASSIGN gv_r TO <abc>.

WRITE: / 'Integer variable gv_r is', gv_r,
       / 'Field Symbol <abc> is', <abc>.
ULINE.

gv_r = 20.

WRITE: / 'Integer variable gv_r is', gv_r,
       / 'Field Symbol <abc> is', <abc>.
ULINE.

<abc> = 30.

WRITE: / 'Integer variable gv_r is', gv_r,
       / 'Field Symbol <abc> is', <abc>.
ULINE.

DATA gv_m TYPE string VALUE 'Gensoft'.

ASSIGN gv_m TO <abc>.

WRITE: / 'Integer variable gv_r is', gv_r,
       / 'Field Symbol <abc> is', <abc>,
       / 'String gv_m is', gv_m.