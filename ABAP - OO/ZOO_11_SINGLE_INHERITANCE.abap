*&---------------------------------------------------------------------*
*& Report ZOO_11_INHERITANCE
*&---------------------------------------------------------------------*
*& Single Inheritance
*&---------------------------------------------------------------------*
REPORT zoo_11_single_inheritance.

** Inheritance -> reusability

** Superclass (base/parent class) -> class that is inherited
** Subclass (derived/child class) -> class inheriting superclass

** Simple inheritance -> derived from one superclass
** Multiple inheritance -> derived from more than 1 entity (interface)

*==================================================================
* Parent class
*==================================================================
CLASS lcl_pet DEFINITION.

  PUBLIC SECTION.
    METHODS:
      display_data.

  PROTECTED SECTION.
    DATA: dogs TYPE i,
          cats TYPE i.

ENDCLASS.

CLASS lcl_pet IMPLEMENTATION.

  METHOD display_data.
    WRITE: / |Number of dogs available: { dogs }|,
           / |Number of cats available: { cats }|.
  ENDMETHOD.

ENDCLASS.

*==================================================================
* Child class -> Single inheritance
*==================================================================
CLASS lcl_inheritance DEFINITION INHERITING FROM lcl_pet.

  PUBLIC SECTION.
    METHODS:
      data_set.

  PROTECTED SECTION.
    DATA: color TYPE string.

ENDCLASS.

CLASS lcl_inheritance IMPLEMENTATION.

  METHOD data_set.
    dogs = 1.
    cats = 2.
    color = `Blue`.
    WRITE: / |Color of the animals: { color }|.
  ENDMETHOD.

ENDCLASS.

*==================================================================
* Child class 02 -> Multi inheritance
*==================================================================
CLASS lcl_multi_inheritance DEFINITION INHERITING FROM lcl_inheritance.

  PUBLIC SECTION.
    METHODS:
      data_pawset.

  PROTECTED SECTION.
    DATA paws TYPE i.

ENDCLASS.

CLASS lcl_multi_inheritance IMPLEMENTATION.

  METHOD data_pawset.
    dogs = 2.
    cats = 4.
    color = `Red`.
    paws = 24.
    WRITE: / |Color of the animals: { color }|.
    WRITE: / |Number of paws: { paws }|.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: lcl_child   TYPE REF TO lcl_inheritance,        " Subclass 01
        lcl_child02 TYPE REF TO lcl_multi_inheritance.  " Subclass 02

  lcl_child = NEW #( ).
  lcl_child->data_set( ).
  lcl_child->display_data( ).

  ULINE.

  lcl_child02 = NEW #( ).
  lcl_child02->data_pawset( ).
  lcl_child02->display_data( ).