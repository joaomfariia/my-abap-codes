*&---------------------------------------------------------------------*
*& Report ZSYNTAX04_VALUE_OPERATOR
*&---------------------------------------------------------------------*
*& Value Operator
*&---------------------------------------------------------------------*
REPORT zsyntax04_value_operator.

TYPES: BEGIN OF ty_person,

         name TYPE string,
         role TYPE string,

       END OF ty_person.

DATA: gt_person TYPE TABLE OF ty_person,
      ls_person TYPE ty_person.

DATA: gt_person2 LIKE gt_person.

" Already declared structure
ls_person = VALUE #( name = 'João Pedro' role = 'Developer' ).

" Inline declaration points to a structure
DATA(ls_person2) = VALUE ty_person( name = 'Person 2' role = 'Manager' ).

" Copy the base values
DATA(ls_person3) = VALUE ty_person( BASE ls_person2 name = 'BasePerson' ).

APPEND ls_person TO gt_person.
APPEND ls_person2 TO gt_person.
APPEND ls_person3 TO gt_person.

" Internal table
gt_person2 = VALUE #( ( name = 'Itab Person 1' role = 'Tech Lead' )
                      ( name = 'Itab Person 2' role = 'Supervisor' ) ).

" Append Way 1
APPEND VALUE #( name = 'Append1' role = 'Way 1' ) TO gt_person2.

" Append Way 2
gt_person2 = VALUE #( BASE gt_person2 ( name = 'Append2' role = 'Way 2' ) ).

" Need to handle the exception if failed!
DATA(ls_read) = gt_person[ role = 'Manager' ].

" Do not need to handle the exception if failed!
DATA(ls_read2) = VALUE #( gt_person[ role = 'XYZ' ] OPTIONAL ).

cl_demo_output=>write( gt_person ).
cl_demo_output=>display( gt_person2 ).

cl_demo_output=>write( ls_read ).
cl_demo_output=>display( ls_read2 ).