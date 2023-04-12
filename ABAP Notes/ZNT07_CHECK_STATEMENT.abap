*&---------------------------------------------------------------------*
*& Report ZJP07_CHECK_STATEMENT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znt07_check_statement.

PARAMETERS p_x TYPE i.

DATA result TYPE i.

result = p_x MOD 2. " Division reminder

WRITE:/'Before checking condition...'.
SKIP.

CHECK result EQ 0.

WRITE:/'Odd number!'.