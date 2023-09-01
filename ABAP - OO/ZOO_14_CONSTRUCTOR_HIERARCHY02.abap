*&---------------------------------------------------------------------*
*& Report ZOO_13_CONSTRUCTOR_HIERARCHY01
*&---------------------------------------------------------------------*
*& Constructor Hierarchy - Scenario 02
*&---------------------------------------------------------------------*
REPORT zoo_14_constructor_hierarchy02.

* If superclass has static and instance constructor and subclass has static constructor,
* when we first instantiates an object, the super static constructor is called before the
* sub static constructor. From now on, only the super instance constructor will be executed.

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

  PUBLIC SECTION.
    CLASS-METHODS class_constructor.

ENDCLASS.

CLASS lcl_subclass IMPLEMENTATION.

  METHOD class_constructor.
    WRITE:/ |This is static constructor method of sub class...|.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: lo_sub TYPE REF TO lcl_subclass.

  lo_sub = NEW #( ).