*&---------------------------------------------------------------------*
*& Report ZSYNTAX12_LINE_INDEX
*&---------------------------------------------------------------------*
*& LET Expression
*&---------------------------------------------------------------------*
REPORT zsyntax12_let_expression.

** This can be useful when you want to define a variable that will only
** be used within a specific part of the code, w/o cluttering up the
** surrounding code with unnecessary declaration.

TYPES: BEGIN OF ty_numbers,
         num1 TYPE i,
         num2 TYPE i,
       END OF ty_numbers.

DATA it_numbers TYPE TABLE OF ty_numbers.

DO 3 TIMES.
  DATA(wa_numbers) = VALUE ty_numbers( LET lv_v1 = sy-index
                                           lv_v2 = sy-index + 1
                                        IN num1 = lv_v1
                                           num2 = lv_v2 ).

  APPEND wa_numbers TO it_numbers.
ENDDO.

cl_demo_output=>display( it_numbers ).