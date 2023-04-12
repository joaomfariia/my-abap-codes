**&---------------------------------------------------------------------*
**& Include          ZCORE34_INT_REPORT_ALV_FORMS
**&---------------------------------------------------------------------*
*
*FORM display_customers2.
*
**  cl_demo_output=>display( it_customers ).  "a way to display data
*
*  TRY.
*
*      cl_salv_table=>factory( IMPORTING r_salv_table = alv_table
*                              CHANGING  t_table      = it_customers ).  "ALV calls static method
*
*    CATCH cx_salv_msg.
*
*  ENDTRY.
*
**  PERFORM set_columns_technical USING lr_columns.
*
*  PERFORM alv_functions. "alv table functions
*
*  alv_table->display( ). "display method
*
*ENDFORM.
*
*FORM alv_functions.
*
*  DATA: lr_functions TYPE REF TO cl_salv_functions.
*
*  lr_functions = alv_table->get_functions( ).   "get the functions
*  lr_functions->set_all( 'X' ).                 "activates all functions
*
*ENDFORM.
*
*FORM hotspot.
*
*  DATA: lr_column  TYPE REF TO cl_salv_column,
*        lr_columns TYPE REF TO cl_salv_columns.
*
*  lr_columns = alv_table->get_columns( ).
*  lr_columns->set_optimize( abap_true ).
*
*  TRY.
*      lr_column ?= lr_columns->get_column( 'KUNNR' ).
*      lr_column->set_cell_type( if_salv_c_cell_type=>hotspot ).
*
*    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
*
*  ENDTRY.
*
*ENDFORM.
*
*FORM set_columns_technical USING ir_columns TYPE REF TO cl_salv_columns.
*
*  DATA: lr_column TYPE REF TO cl_salv_column.
*
*  TRY.
*
*      lr_column = ir_columns->get_column( 'KUNNR' ).
*      lr_column->set_technical( if_salv_c_bool_sap=>true ).
*
*    CATCH cx_salv_not_found.
*                                                        "#EC NO_HANDLER
*  ENDTRY.
*
*ENDFORM.