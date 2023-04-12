*&---------------------------------------------------------------------*
*& Report ZSYNTAX05_FOR_OPERATOR
*&---------------------------------------------------------------------*
*& For Operator
*&---------------------------------------------------------------------*
REPORT zsyntax05_for_operator.

TYPES: BEGIN OF ty_number,

         number1 TYPE i,
         number2 TYPE i,
         number3 TYPE i,

       END OF ty_number.

TYPES: tt_number TYPE TABLE OF ty_number WITH EMPTY KEY.

DATA: gt_number TYPE TABLE OF ty_number.

" Generic type from # -> already declared!
gt_number = VALUE #( FOR i = 10 THEN i + 10 UNTIL i > 50
                     ( number1 = i number2 = i + 1 number3 = i + 3 ) ).

cl_demo_output=>write( gt_number ).

" Loop at gt_number into ls_number
DATA(gt_number2) = VALUE tt_number( FOR ls_number2 IN gt_number
                                      WHERE ( number1 > 30 ) ( ls_number2 ) ).

cl_demo_output=>display( gt_number2 ).

" Start at the index line value
DATA(gt_number3) = VALUE tt_number( FOR ls_number3 IN gt_number INDEX INTO lv_index
                                     WHERE ( number1 = 20 ) ( LINES OF gt_number FROM lv_index ) ).

cl_demo_output=>write( gt_number3 ).

" Use the index to get a range and select which data will be shown
DATA(gt_number4) = VALUE tt_number( FOR ls_number4 IN gt_number FROM 2 TO 4
                                     ( number1 = ls_number4-number1 number3 = ls_number4-number3 ) ).

cl_demo_output=>display( gt_number4 ).

TYPES: tt_i TYPE TABLE OF i WITH EMPTY KEY.

DATA(gt_number5) = VALUE tt_i( FOR ls_number4 IN gt_number ( ls_number4-number1 ) ( ls_number4-number2 ) ).

cl_demo_output=>display( gt_number5 ).