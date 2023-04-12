*&---------------------------------------------------------------------*
*& Report ZJP_REPORT_MVC
*&---------------------------------------------------------------------*
*& ABAP OOPS - MVC Architecture
*&---------------------------------------------------------------------*
REPORT zjp_report_mvc.

INCLUDE: zjp_report_mvc_screen,
         zjp_report_mvc_model,
         zjp_report_mvc_view,
         zjp_report_mvc_controller.

DATA: gc_controller TYPE REF TO report_controller.

INITIALIZATION.

  gc_controller = NEW #( ).
  gc_controller->initialization( ).

AT SELECTION-SCREEN OUTPUT. " View

  gc_controller->selection_screen_output( ).

AT SELECTION-SCREEN. " View

  gc_controller->selection_screen( ).

START-OF-SELECTION. " Model

  gc_controller->start_of_selection( ).

END-OF-SELECTION. " View

  gc_controller->end_of_selection( ).