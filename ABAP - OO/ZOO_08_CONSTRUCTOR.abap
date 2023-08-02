*&---------------------------------------------------------------------*
*& Report ZOO_08_CONSTRUCTOR
*&---------------------------------------------------------------------*
*& Constructor
*&---------------------------------------------------------------------*
REPORT zoo_08_constructor.

CLASS lcl_constructor DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor,
      display_data.

  PROTECTED SECTION.

    DATA: empid   TYPE i,
          empname TYPE c LENGTH 10,
          emprole TYPE c LENGTH 10.

ENDCLASS.

CLASS lcl_constructor IMPLEMENTATION.

  " Executed right after the object is created
  METHOD constructor.
    empid = '1'.
    empname = 'João'.
    emprole = 'Developer'.
  ENDMETHOD.

  METHOD display_data.
    WRITE: / |The employee { empname } works as { emprole } and has ID { empid }.|.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: lo_constructor TYPE REF TO lcl_constructor.

  lo_constructor = NEW #( ).        " Constructor method executed
  lo_constructor->display_data( ).