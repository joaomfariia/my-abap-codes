*&---------------------------------------------------------------------*
*& Report ZOO_07_INSTANCE_STATIC_METHOD
*&---------------------------------------------------------------------*
*& instance and Static Methods
*&---------------------------------------------------------------------*
REPORT zoo_07_instance_static_method.

CLASS lcl_instance_static DEFINITION.

  PUBLIC SECTION.

    METHODS instance_method.
    CLASS-METHODS static_method.

  PROTECTED SECTION.

    DATA i_number TYPE i.
    CLASS-DATA s_number TYPE i.
    CONSTANTS c_number TYPE i VALUE 999.

ENDCLASS.

CLASS lcl_instance_static IMPLEMENTATION.

  METHOD instance_method.
    WRITE: / |This is public instance method!|.

** Instance method can access all kind of data
    i_number = 100.
    s_number = 200.
    WRITE: / |i_number = { i_number } |.
    WRITE: / |s_number = { s_number } |.
    WRITE: / |c_number = { c_number } |.
    ULINE.

  ENDMETHOD.

  METHOD static_method.
    WRITE: / |This is public static method!|.

** Instance attributes cannot be accessed from static methods
*    i_number = 50.
*    WRITE: / |i_number = { i_number } |.

    s_number = 50.
    WRITE: / |s_number = { s_number } |.
    WRITE: / |c_number = { c_number } |.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  " May be called without reference to the class
  lcl_instance_static=>static_method( ).
  ULINE.

  DATA: lo_method TYPE REF TO lcl_instance_static.

  lo_method = NEW #( ).
  lo_method->instance_method( ).
  lo_method->static_method( ).