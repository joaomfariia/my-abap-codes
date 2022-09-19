*&---------------------------------------------------------------------*
*& Report ZCORE30_SELECT_OPTIONS
*&---------------------------------------------------------------------*
*& Select-Options - Debugger - Watchpoints
*&---------------------------------------------------------------------*
REPORT zcore30_select_options.

*--------------------------------------------------------------------*
* STRUCTURES AND TYPES/DATA DEFINITIONS                                   *
*--------------------------------------------------------------------*

*"case 1
*DATA: gv_netwr TYPE netwr_ak. "data element
*SELECT-OPTIONS so_netwr FOR gv_netwr.

*case 2
*DATA: gv_netwr TYPE vbak-netwr. "data field
*SELECT-OPTIONS so_netwr FOR gv_netwr.

*case 3
TABLES: vbak. "creates a workarea based on VBAK DDIC
SELECT-OPTIONS so_netwr FOR vbak-netwr DEFAULT 20 TO 200.

TYPES: BEGIN OF ty_vbak,

         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         erzet TYPE vbak-erzet,
         ernam TYPE vbak-ernam,
         netwr TYPE vbak-netwr,

       END OF ty_vbak.

DATA: it_vbak  TYPE TABLE OF ty_vbak,
      wa_vbak  TYPE ty_vbak,
      cl_table TYPE REF TO cl_salv_table.

*--------------------------------------------------------------------*
* START-OF-SELECTION                                                 *
*--------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_sales_order.

  IF it_vbak IS NOT INITIAL.
    DESCRIBE TABLE it_vbak.
    WRITE:/ 'Number of sales order in the given net value range:', sy-tfill.

    PERFORM display_sales_order.

  ELSE.
    MESSAGE 'No sales orders in the given net value range found...' TYPE 'I' DISPLAY LIKE 'E'.

  ENDIF.

*--------------------------------------------------------------------*
* FORMS                                                        *
*--------------------------------------------------------------------*

FORM get_sales_order.

  SELECT vbeln,
         erdat,
         erzet,
         ernam,
         netwr
    FROM vbak
    INTO TABLE @it_vbak
    WHERE netwr IN @so_netwr.

ENDFORM.

FORM display_sales_order.

  CALL METHOD cl_salv_table=>factory
*    EXPORTING
*      list_display = abap_true     "a different way to display the ALV
    IMPORTING
      r_salv_table = cl_table
    CHANGING
      t_table      = it_vbak.

  PERFORM feed_functions.

  CALL METHOD cl_table->display.

ENDFORM.

FORM feed_functions.

  DATA: lc_functions TYPE REF TO cl_salv_functions. "local class referring to std class

  lc_functions = cl_table->get_functions( ). "search for functions in ALV class
  lc_functions->set_all( abap_true ).        "activates all the functions

ENDFORM.