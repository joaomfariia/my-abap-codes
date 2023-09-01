*&---------------------------------------------------------------------*
*& Report ZOO_13_CONSTRUCTOR_HIERARCHY01
*&---------------------------------------------------------------------*
*& Constructor Hierarchy - Scenario 04
*&---------------------------------------------------------------------*
REPORT zoo_16_constructor_hierarchy04.

* If superclass and subclass has instance constructor with importing parameters
* we must pass the super values in the sub instance constructor method.

*==================================================================
* SUPERCLASS
*==================================================================
CLASS lcl_superclass DEFINITION.

  PUBLIC SECTION.
    METHODS constructor IMPORTING ip_num TYPE i.

ENDCLASS.

CLASS lcl_superclass IMPLEMENTATION.

  METHOD constructor.
    WRITE:/ |This is instance constructor method of super class!|,
          / |Super number: { ip_num }|.
  ENDMETHOD.

ENDCLASS.

*==================================================================
* SUBCLASS
*==================================================================
CLASS lcl_subclass DEFINITION INHERITING FROM lcl_superclass.

  PUBLIC SECTION.
    METHODS constructor IMPORTING ip_num2 TYPE i
                                  ip_num3 TYPE i.

ENDCLASS.

CLASS lcl_subclass IMPLEMENTATION.

  METHOD constructor.
    WRITE:/ |This is instance constructor method of sub class...|,
          / |Sub number 1: { ip_num2 }|,
          / |Sub number 2: { ip_num3 }|.
    SKIP 1.
    super->constructor( ip_num = 10 ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: lo_super TYPE REF TO lcl_superclass,
        lo_sub   TYPE REF TO lcl_subclass.

  lo_sub = NEW #( ip_num2 = 20 ip_num3 = 30 ).