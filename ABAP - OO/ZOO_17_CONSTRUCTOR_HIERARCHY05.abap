*&---------------------------------------------------------------------*
*& Report ZOO_13_CONSTRUCTOR_HIERARCHY01
*&---------------------------------------------------------------------*
*& Constructor Hierarchy - Scenario 05
*&---------------------------------------------------------------------*
REPORT zoo_17_constructor_hierarchy05.

* If superclass has instance constructor with importing parameters and sub
* does not have any, we must pass the value of parameters in sub instance
* constructor method

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

ENDCLASS.

CLASS lcl_subclass IMPLEMENTATION.

ENDCLASS.

START-OF-SELECTION.

  PARAMETERS: p_num TYPE i.

  DATA: lo_super TYPE REF TO lcl_superclass,
        lo_sub   TYPE REF TO lcl_subclass.

  lo_sub = NEW #( ip_num = p_num ).