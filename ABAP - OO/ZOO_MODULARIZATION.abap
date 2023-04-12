*& Report YABAP_750_REPORT
*&--------------------------------------------------------*
*& ABAP OO MODULARIZATION
*&--------------------------------------------------------*
REPORT yabap_750_report.

CLASS lcl_alv DEFINITION FINAL.

  PUBLIC SECTION.

    CONSTANTS :
      information TYPE sy-msgty VALUE 'I'.

    TYPES :
      tt_flights TYPE STANDARD TABLE OF sflight
        WITH EMPTY KEY.
    "... add more types here

    METHODS :
      constructor IMPORTING i_carrier    TYPE sflight-carrid
                            i_connection TYPE sflight-connid,
      start_report_process RETURNING VALUE(r_error) TYPE char1.

    "... add more public methods here

  PROTECTED SECTION.
    "Add protected data/methods if needed

  PRIVATE SECTION.

    DATA :
      carrier    TYPE sflight-carrid,
      connection TYPE sflight-connid,
      flights    TYPE tt_flights.
    "... add more data declarations here

    METHODS :
      get_flights RETURNING VALUE(rt_flights) TYPE tt_flights,
      display_flights RETURNING VALUE(r_error) TYPE char1.
    "... add more private methods here

ENDCLASS.

CLASS lcl_alv IMPLEMENTATION.

  METHOD constructor.

    "Set variables based on called parameters
    carrier    = i_carrier.
    connection = i_connection.

    "Initialize attributes
    CLEAR flights.

  ENDMETHOD.

  METHOD start_report_process.

    CLEAR r_error.

    flights = get_flights( ).
    IF flights IS INITIAL.
      MESSAGE e001(00) WITH 'No data found'(002) INTO DATA(lv_error).
      r_error = abap_true.
    ELSE.
      r_error = display_flights( ).
    ENDIF.

  ENDMETHOD.

  METHOD get_flights.
    CLEAR rt_flights.
    SELECT * FROM sflight INTO TABLE @rt_flights
      WHERE carrid = @carrier
      AND   connid = @connection.
  ENDMETHOD.

  METHOD display_flights.
    CLEAR r_error.
    TRY.
        "Create ALV table object for the output data table
        cl_salv_table=>factory( 
          IMPORTING r_salv_table = DATA(lo_table)
          CHANGING  t_table      = flights ).

        lo_table->get_functions( )->set_all( ).
        lo_table->get_columns( )->set_optimize( ).
        lo_table->display( ).

      CATCH cx_root.   
        MESSAGE e001(00) WITH 'Error in ALV creation'(003)
          INTO DATA(lv_error).
        r_error = abap_true.
    ENDTRY.
  ENDMETHOD.

  "... add more methods implementation here
ENDCLASS.

*-----------------------------------------------------*

"... build selection screen here or in another include
SELECTION-SCREEN BEGIN OF BLOCK main_block 
                          WITH FRAME TITLE TEXT-001.
  PARAMETERS : carrid TYPE sflight-carrid,
               connid TYPE sflight-connid.
SELECTION-SCREEN END OF BLOCK main_block.

*-----------------------------------------------------*

START-OF-SELECTION.
  "Create object for the class
  DATA(o_alv) = NEW lcl_alv( i_carrier    = carrid
                             i_connection = connid ).
  "Start the main process
  DATA(lv_error) = o_alv->start_report_process( ).

* Below code issues error & goes back to selection screen
* This is better implemented with exceptions, though
  
  IF lv_error IS NOT INITIAL.
    MESSAGE ID sy-msgid
      TYPE lcl_alv=>information
      NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
      DISPLAY LIKE sy-msgty.
    LEAVE LIST-PROCESSING.
  ENDIF.