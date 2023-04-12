*&---------------------------------------------------------------------*
*& Report ZSYNTAX06_FILTER_OPERATOR
*&---------------------------------------------------------------------*
*& Filter Operator
*&---------------------------------------------------------------------*
REPORT zsyntax06_filter_operator.

TYPES: BEGIN OF ty_student,

         name   TYPE string,
         active TYPE abap_bool,

       END OF ty_student.

DATA: gt_students TYPE SORTED TABLE OF ty_student WITH NON-UNIQUE KEY active.

DATA: gt_filter TYPE SORTED TABLE OF abap_bool WITH NON-UNIQUE KEY table_line.

gt_students = VALUE #( ( name = 'João Pedro' active = abap_true )
                       ( name = 'Student 2' active = abap_false )
                       ( name = 'Student 3' active = abap_false )
                       ( name = 'Student 4' active = abap_true ) ).

cl_demo_output=>display( gt_students ).

" Filter operator must be used within a sorted/hashed table (!)
DATA(gt_active) = FILTER #( gt_students WHERE active = abap_true ).

cl_demo_output=>write( gt_active ).

" Can be used with USING KEY keyword (?)
DATA(gt_non_active) = FILTER #( gt_students EXCEPT WHERE active = abap_true ).

cl_demo_output=>display( gt_non_active ).

" Filter Internal Table
gt_filter = VALUE #( ( abap_true ) ( abap_false ) ).

DATA(gt_filtered) = FILTER #( gt_students IN gt_filter WHERE active = table_line ).

cl_demo_output=>display( gt_filtered ).