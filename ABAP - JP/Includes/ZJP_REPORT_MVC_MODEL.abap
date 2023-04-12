*&---------------------------------------------------------------------*
*& Include          ZJP_REPORT_MVC_MODEL
*&---------------------------------------------------------------------*

CLASS report_model DEFINITION.

  PUBLIC SECTION.

    METHODS start_of_selection.

ENDCLASS.

CLASS report_model IMPLEMENTATION.

  METHOD start_of_selection.
    MESSAGE 'Model called!' TYPE 'I' DISPLAY LIKE 'I'.
  ENDMETHOD.

ENDCLASS.