*&---------------------------------------------------------------------*
*& Report ZOO_01_BASIC_CLASS
*&---------------------------------------------------------------------*
*& Basic Class - Attributes and Methods
*&---------------------------------------------------------------------*
REPORT zoo_01_basic_class.

CLASS lcl_math DEFINITION.

  PUBLIC SECTION.

    DATA: num1   TYPE i,       " Instanced attributes
          num2   TYPE i,
          result TYPE i.

*    CLASS-DATA: num3 TYPE i.   " Static attributes

    METHODS: sum.
    METHODS: diff.
    METHODS: prod.
    METHODS: div.

ENDCLASS.

CLASS lcl_math IMPLEMENTATION.

  METHOD sum.

    result = num1 + num2.
    WRITE: / 'The sum is:', result.

  ENDMETHOD.

  METHOD diff.

    result = num1 - num2.
    WRITE: / 'The difference is:', result.

  ENDMETHOD.

  METHOD prod.

    result = num1 * num2.
    WRITE: / 'The product is:', result.

  ENDMETHOD.

  METHOD div.

    result = num1 / num2.
    WRITE: / 'The division is:', result.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  " Reference variable/table to create alias of class (NO MEMORY ALLOCATED)
  DATA: math_obj TYPE REF TO lcl_math,
        gt_math  TYPE TABLE OF REF TO lcl_math.

  " Create object - NEW SYNTAX!
  math_obj = NEW #(  ).

  " Set the instanced attribute
  math_obj->num1 = 10.
  math_obj->num2 = 15.

  " Call a instanced method
  math_obj->sum(  ).
  math_obj->diff(  ).
  math_obj->prod(  ).
  math_obj->div(  ).
  APPEND math_obj TO gt_math.

  DATA(math_obj2) = NEW lcl_math(  ).

  math_obj2->num1 = 100.
  math_obj2->num2 = 4.

  math_obj2->sum(  ).
  math_obj2->diff(  ).
  math_obj2->prod(  ).
  math_obj2->div(  ).
  APPEND math_obj2 TO gt_math.