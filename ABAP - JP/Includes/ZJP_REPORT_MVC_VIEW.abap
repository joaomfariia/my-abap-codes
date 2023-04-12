*&---------------------------------------------------------------------*
*& Include          ZJP_REPORT_MVC_VIEW
*&---------------------------------------------------------------------*

CLASS report_view DEFINITION.

  PUBLIC SECTION.

    METHODS initialization.
    METHODS selection_screen_output.
    METHODS selection_screen.
    METHODS start_of_selection.
    METHODS end_of_selection.

ENDCLASS.

CLASS report_view IMPLEMENTATION.

  METHOD: initialization.
    MESSAGE 'Initialization called!' TYPE 'I' DISPLAY LIKE 'I'.
  ENDMETHOD.

  METHOD: selection_screen_output.
    MESSAGE 'Selection Screen Output called!' TYPE 'I' DISPLAY LIKE 'I'.
  ENDMETHOD.

  METHOD: selection_screen.
    MESSAGE 'Selection Screen called!' TYPE 'I' DISPLAY LIKE 'I'.
  ENDMETHOD.

  METHOD: start_of_selection.
    MESSAGE 'Start of Selection called!' TYPE 'I' DISPLAY LIKE 'I'.
  ENDMETHOD.

  METHOD: end_of_selection.
    MESSAGE 'End of Selection called!' TYPE 'I' DISPLAY LIKE 'I'.
  ENDMETHOD.

ENDCLASS.