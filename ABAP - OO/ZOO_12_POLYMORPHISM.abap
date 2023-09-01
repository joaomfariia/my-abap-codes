*&---------------------------------------------------------------------*
*& Report ZOO_12_POLYMORPHISM
*&---------------------------------------------------------------------*
*& Overloading and Overwriting in Polymorphism
*&---------------------------------------------------------------------*
REPORT zoo_12_polymorphism.

CLASS lcl_poly DEFINITION.

  PUBLIC SECTION.
    METHODS md1.
    METHODS md2 IMPORTING ip_x TYPE i DEFAULT '10'.
    METHODS md3.
    CLASS-METHODS md4.

  PROTECTED SECTION.
    METHODS md5.

*    METHODS md1 IMPORTING ip_x TYPE i.            "Overloading not supported in ABAP
*    METHODS md1 IMPORTING ip_y TYPE string.       "Overloading not supported in ABAP

ENDCLASS.

CLASS lcl_poly IMPLEMENTATION.

  METHOD md1.
    WRITE:/ |This is instance method 'MD1' from class 'LCL_POLY'.|.
    ULINE.
  ENDMETHOD.

  METHOD md2.
    WRITE:/ |This is instance method 'MD2' from class 'LCL_POLY'.|,
          / |Importing parameter: { ip_x }|.
    ULINE.
  ENDMETHOD.

  METHOD md3.
    WRITE:/ |This is instance method 'MD3' from class 'LCL_POLY'|.
    ULINE.
  ENDMETHOD.

  METHOD md4.
    WRITE:/ |This is static method 'MD4' from class 'LCL_POLY'.|.
    ULINE.
  ENDMETHOD.

  METHOD md5.
    WRITE:/ |This is instance method 'MD5' from class 'LCL_POLY'.|.
    ULINE.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_subclass DEFINITION INHERITING FROM lcl_poly.

  PUBLIC SECTION.
    METHODS md1 REDEFINITION.
    METHODS md2 REDEFINITION.
*    METHODS md3 REDEFINITION. "Final methods cannot be redefined but can be inherited
*    CLASS-METHODS md4 REDEFINITION. "Static methods cannot be redefined

ENDCLASS.

CLASS lcl_subclass IMPLEMENTATION.

  METHOD md1.
    WRITE: / |This is redefined instance method 'MD1' from class 'LCL_POLY'.|.
    ULINE.
  ENDMETHOD.

  METHOD md2.
    WRITE: / |This is redefined instance method 'MD2' from class 'LCL_POLY'.|.
    SKIP.
    WRITE:/ |Super class method 'MD2':|.
    super->md2( ).
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA lo_poly TYPE REF TO lcl_poly.
  DATA lo_subclass TYPE REF TO lcl_subclass.

  lo_poly = NEW #( ).
  lo_poly->md1( ).
  lo_poly->md2( ).

  lo_subclass = NEW #( ).
  lo_subclass->md1( ).
  lo_subclass->md2( ).
  lo_subclass->md3( ).

  lcl_poly=>md4( ).