*&---------------------------------------------------------------------*
*& Report ZOO_13_CONSTRUCTOR_HIERARCHY01
*&---------------------------------------------------------------------*
*& Constructor Hierarchy - Scenario 01
*&---------------------------------------------------------------------*
REPORT zoo_13_constructor_hierarchy01.

* If superclass has static and instance constructor and subclass does not have any,
* when we first instantiates an object, the static constructor is called before the
* instance one. From now on, only the instance constructor will be executed.

*==================================================================
* SUPERCLASS
*==================================================================
CLASS lcl_superclass DEFINITION.

  PUBLIC SECTION.
    METHODS constructor.
    CLASS-METHODS class_constructor.

ENDCLASS.

CLASS lcl_superclass IMPLEMENTATION.

  METHOD constructor.
    WRITE:/ |This is instance constructor method of super class!|.
  ENDMETHOD.

  METHOD class_constructor.
    WRITE:/ |This is static constructor method of super class!|.
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

  DATA: lo_super TYPE REF TO lcl_superclass,
        lo_sub   TYPE REF TO lcl_subclass.

  lo_super = NEW #( ).
  ULINE.
  lo_sub = NEW #( ).