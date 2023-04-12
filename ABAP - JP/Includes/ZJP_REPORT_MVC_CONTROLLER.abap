*&---------------------------------------------------------------------*
*& Include          ZJP_REPORT_MVC_CONTROLLER
*&---------------------------------------------------------------------*

CLASS report_controller DEFINITION.

  PUBLIC SECTION.

    DATA: view  TYPE REF TO report_view,
          model TYPE REF TO report_model.

    METHODS constructor.
    METHODS initialization.
    METHODS selection_screen_output.
    METHODS selection_screen.
    METHODS start_of_selection.
    METHODS end_of_selection.

ENDCLASS.

CLASS report_controller IMPLEMENTATION.

  METHOD constructor.
    view = NEW #( ).
    model = NEW #( ).
  ENDMETHOD.

  METHOD initialization.
    me->view->initialization( ).
  ENDMETHOD.

  METHOD selection_screen_output.
    me->view->selection_screen_output( ).
  ENDMETHOD.

  METHOD selection_screen.
    me->view->selection_screen( ).
  ENDMETHOD.

  METHOD start_of_selection.
    me->model->start_of_selection( ).
  ENDMETHOD.

  METHOD end_of_selection.
    me->view->end_of_selection( ).
  ENDMETHOD.

ENDCLASS.