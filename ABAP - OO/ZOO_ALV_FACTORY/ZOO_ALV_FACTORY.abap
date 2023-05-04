*&---------------------------------------------------------------------*
*& Report ZOO_ALV_FACTORY
*&---------------------------------------------------------------------*
*& ALV Factory - Functions, Events, Hotspot, etc.
*&---------------------------------------------------------------------*
REPORT zoo_alv_factory.

INCLUDE zoo_alv_factory_top.

CLASS lcl_handle_events DEFINITION.

  PUBLIC SECTION.

    METHODS:
      on_line_click FOR EVENT link_click OF cl_salv_events_table
        IMPORTING row column.

ENDCLASS.

CLASS lcl_handle_events IMPLEMENTATION.

  METHOD on_line_click.

    READ TABLE it_mara INTO DATA(wa_mara) INDEX row.

    IF sy-subrc EQ 0.
      SET PARAMETER ID 'MAT' FIELD wa_mara-matnr.
      CALL TRANSACTION 'MM03' AND SKIP FIRST SCREEN.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

*-----------------------------------------------------------*
* DATA SELECTION
*-----------------------------------------------------------*
  SELECT matnr, ernam, mtart, matkl
    FROM mara
    INTO TABLE @it_mara
    UP TO 20 ROWS.

*-----------------------------------------------------------*
* CREATE ALV
*-----------------------------------------------------------*
  TRY.
      CALL METHOD cl_salv_table=>factory
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = it_mara.

    CATCH cx_salv_msg INTO DATA(lv_alv_error).
  ENDTRY.

*-----------------------------------------------------------*
* ADDING HOTSPOT
*-----------------------------------------------------------*
  DATA: lr_columns TYPE REF TO cl_salv_columns_table,
        lr_column  TYPE REF TO cl_salv_column_table.

  lo_alv->get_columns( RECEIVING value = lr_columns ).

  IF lr_columns IS NOT INITIAL.

    lr_column ?= lr_columns->get_column( 'MATNR' ).  " ?= used to call the super class
    lr_column->set_cell_type( EXPORTING value  = if_salv_c_cell_type=>hotspot ).

  ENDIF.

*-----------------------------------------------------------*
* OPTIMIZE COLUMN WIDTH
*-----------------------------------------------------------*
  lr_columns->set_optimize( ).

*-----------------------------------------------------------*
* HIDE COLUMN
*-----------------------------------------------------------*
  lr_column ?= lr_columns->get_column( 'MTART').
  lr_column->set_visible( abap_false ).

*-----------------------------------------------------------*
* REGISTERING EVENT
*-----------------------------------------------------------*
  DATA: go_events TYPE REF TO lcl_handle_events,
        lo_events TYPE REF TO cl_salv_events_table.

  go_events = NEW #( ).               " creates the object of 'lcl_handle_events'
  lo_events = lo_alv->get_event( ).
  SET HANDLER go_events->on_line_click FOR lo_events. " event registration

*-----------------------------------------------------------*
* ADDING FUNCTIONS
*-----------------------------------------------------------*
*** METHOD 1

*  CALL METHOD lo_alv->set_screen_status
*    EXPORTING
*      report        = 'SALV_TEST_FUNCTIONS'
*      pfstatus      = 'SALV_STANDARD'
*      set_functions = lo_alv->c_functions_all.

*** METHOD 2

  DATA: lo_functions TYPE REF TO cl_salv_functions_list.

  lo_functions = lo_alv->get_functions( ).
  lo_functions->set_all( abap_true ).

*-----------------------------------------------------------*
* DISPLAY SETTINGS - 'TITLE AND ZEBRA PATTERN'
*-----------------------------------------------------------*

  DATA: lo_display TYPE REF TO cl_salv_display_settings.

  lo_display = lo_alv->get_display_settings( ).
  lo_display->set_list_header( value = 'ALV TITLE' ).   " ALV title
  lo_display->set_striped_pattern( value = abap_true ). " ALV pattern

  lo_alv->display( ).