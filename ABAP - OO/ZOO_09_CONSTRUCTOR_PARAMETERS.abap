*&---------------------------------------------------------------------*
*& Report ZOO_08_CONSTRUCTOR
*&---------------------------------------------------------------------*
*& Constructor with parameters
*&---------------------------------------------------------------------*
REPORT zoo_09_constructor_parameters.

CLASS lcl_constructor DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING i_empid   TYPE i OPTIONAL
                  i_empname TYPE c OPTIONAL
                  i_emprole TYPE c OPTIONAL,

      display_data.

  PROTECTED SECTION.

    DATA: empid   TYPE i,
          empname TYPE c LENGTH 10,
          emprole TYPE c LENGTH 10.

ENDCLASS.

CLASS lcl_constructor IMPLEMENTATION.

  " Executed right after the object is created
  METHOD constructor.
    empid = i_empid.
    empname = i_empname.
    emprole = i_emprole.
  ENDMETHOD.

  METHOD display_data.
    WRITE: / |The employee { empname } works as { emprole } and has ID { empid }.|.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  PARAMETERS: p_empid TYPE i,
              p_ename TYPE c LENGTH 20,
              p_erole TYPE c LENGTH 20.

  DATA: lo_constructor TYPE REF TO lcl_constructor.

  lo_constructor = NEW #( i_empid = p_empid
                          i_empname = p_ename
                          i_emprole = p_erole ).        " Constructor method executed

  lo_constructor->display_data( ).