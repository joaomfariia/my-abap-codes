*&---------------------------------------------------------------------*
*& Report ZOO_10_INST_STATIC_CONSTRUCTOR
*&---------------------------------------------------------------------*
*& Instance & Static Constructor
*&---------------------------------------------------------------------*
REPORT zoo_10_inst_static_constructor.

** Constructors are executed right after an object is created
** Static constructors are executed only once at the program runtime
** Static constructors are mainly used to set default values

CLASS lcl_inst_stat_constructor DEFINITION.

  PUBLIC SECTION.

    METHODS:
      constructor.         " Instance constructor

    CLASS-METHODS:
      class_constructor.   " Static constructor -> cannot have parameters/exceptions

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_inst_stat_constructor IMPLEMENTATION.

  METHOD constructor.
    WRITE: / |Instance constructor executed!|.
  ENDMETHOD.

  METHOD class_constructor.
    WRITE: / |Static constructor executed!|.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: lo_inst_stat_constructor TYPE REF TO lcl_inst_stat_constructor.
  DATA: lo_inst_stat_constructor_2 TYPE REF TO lcl_inst_stat_constructor.

  lo_inst_stat_constructor = NEW #( ).
  lo_inst_stat_constructor_2 = NEW #( ).