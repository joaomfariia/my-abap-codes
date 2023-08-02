*&---------------------------------------------------------------------*
*& Report ZOO_05_FRIEND_CLASS
*&---------------------------------------------------------------------*
*& Friend Local Class
*&---------------------------------------------------------------------*
REPORT zoo_05_friend_class.

**** NOT BEST PRACTICE! ****
" Needs to be declared before "parent" class A
" so it can be declared in class A definition

*CLASS lcl_class_b_friend DEFINITION.
*
*  PUBLIC SECTION.
*    METHODS
*      method04.
*
*ENDCLASS.

" DEFERRED keyword -> the class can be defined somewhere in the program!
CLASS lcl_class_b_friend DEFINITION DEFERRED.

CLASS lcl_class_a_parent DEFINITION FRIENDS lcl_class_b_friend.

  PUBLIC SECTION.
    METHODS
      method01.

  PROTECTED SECTION.
    METHODS
      method02.

  PRIVATE SECTION.
    METHODS
      method03.

ENDCLASS.

CLASS lcl_class_a_parent IMPLEMENTATION.

  METHOD method01.
    WRITE: / |This is instanced method 01 from the "parent" class lcl_class_a_parent.|.
  ENDMETHOD.

  METHOD method02.
    WRITE: / |This is instanced method 02 from the "parent" class lcl_class_a_parent.|.
  ENDMETHOD.

  METHOD method03.
    WRITE: / |This is instanced method 03 from the "parent" class lcl_class_a_parent.|.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_class_b_friend DEFINITION.

  PUBLIC SECTION.
    METHODS
      method04.

ENDCLASS.

CLASS lcl_class_b_friend IMPLEMENTATION.

  METHOD method04.
    WRITE: / |This is method 04 from the friend class LCL_CLASS_B_FRIEND.|.

    " Instantiating and accessing the method from the "parent" class
    DATA lo_obj_a TYPE REF TO lcl_class_a_parent.

    lo_obj_a = NEW #( ).

    ULINE.
    lo_obj_a->method01( ).
    ULINE.
    lo_obj_a->method02( ).  " Cannot access while no friend -> protected method!
    ULINE.
    lo_obj_a->method03( ).  " Cannot access while no friend -> private method!

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA lo_obj_b TYPE REF TO lcl_class_b_friend.

  lo_obj_b = NEW #( ).
  lo_obj_b->method04( ).