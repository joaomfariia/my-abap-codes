*&---------------------------------------------------------------------*
*& Report ZOO_13_CONSTRUCTOR_HIERARCHY01
*&---------------------------------------------------------------------*
*& Constructor Hierarchy - Scenario 03
*&---------------------------------------------------------------------*
REPORT zoo_15_constructor_hierarchy03.

* If superclass and subclass has static and instance constructor then it is mandatory
* for sub instance constructor to call super instance constructor explicity. Then SAP
* first executes static constructor from super to subclass. From second object the
* instance constructor is executed from sub to subclass.

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
    METHODS constructor.
    CLASS-METHODS class_constructor.

ENDCLASS.

CLASS lcl_subclass IMPLEMENTATION.

  METHOD constructor.
    WRITE:/ |This is instance constructor method of sub class...|.
    super->constructor( ).
  ENDMETHOD.

  METHOD class_constructor.
    WRITE:/ |This is static constructor method of sub class...|.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: lo_super TYPE REF TO lcl_superclass,
        lo_sub   TYPE REF TO lcl_subclass,
        lo_sub2  TYPE REF TO lcl_subclass.

  lo_sub = NEW #( ).
  ULINE.
  lo_sub2 = NEW #( ).