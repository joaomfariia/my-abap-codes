*&---------------------------------------------------------------------*
*& Report ZOO_ALV_REPORT
*&---------------------------------------------------------------------*
*& OO ALV Report
*&---------------------------------------------------------------------*
REPORT zoo_alv_grid.

CLASS lcl_alv_evt DEFINITION.

  PUBLIC SECTION.

    METHODS:
      evt_doubleclick FOR EVENT double_click OF cl_gui_alv_grid
        IMPORTING e_row e_column.

    METHODS:
      evt_f4help FOR EVENT onf4 OF cl_gui_alv_grid.

    METHODS:
      evt_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
        IMPORTING e_object.

    METHODS:
      evt_usercomm FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING e_ucomm.

ENDCLASS.

CLASS lcl_alv_evt IMPLEMENTATION.

  METHOD evt_doubleclick.
    CASE e_column.

      WHEN 'MATNR'.
        MESSAGE |'Material' column double clicked!| TYPE 'I' DISPLAY LIKE 'S'.

      WHEN 'MTART'.
        MESSAGE |'Material type' column double clicked!| TYPE 'I' DISPLAY LIKE 'S'.

      WHEN 'ERNAM'.
        MESSAGE |'Created by' column double clicked!| TYPE 'I' DISPLAY LIKE 'S'.

    ENDCASE.
  ENDMETHOD.

  METHOD evt_f4help.
    MESSAGE |F4 help method called!| TYPE 'I' DISPLAY LIKE 'S'.
  ENDMETHOD.

  METHOD evt_toolbar. " creates a button

    DATA: ls_button TYPE stb_button.

    ls_button-butn_type = 0.
    ls_button-function = 'EXIT'.
    ls_button-text = 'Close'.

    APPEND ls_button TO e_object->mt_toolbar.

  ENDMETHOD.

  METHOD evt_usercomm.
    CASE e_ucomm.     " toolbar user command

      WHEN 'EXIT'.
        LEAVE PROGRAM.

    ENDCASE.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  CALL SCREEN 200.

  INCLUDE: zoo_alv_grid_top,
           zoo_alv_grid_f.

*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&  PBO EVENTS
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS 'MENU'.
* SET TITLEBAR 'xxx'.

  PERFORM f_mara_query.
  PERFORM f_fcat_change.

** Step 1
** Create an object ref to CL_GUI_CUSTOM_CONTAINER
  lo_cust_cont = NEW #( container_name = 'CUST_CONT' ).

** Step 2
** Create an object ref to CL_GUI_ALV_GRID
  lo_alv = NEW #( i_parent = lo_cust_cont ).

*&---------------------------------------------------------------------*
*&  EVENT HANDLING
*&---------------------------------------------------------------------*
  DATA(lo_alv_evt) = NEW lcl_alv_evt( ). " Instantiating ALV event class

*&---------------------------------------------------------------------*
*&  F4 HELP EVENT
*&---------------------------------------------------------------------*
  gs_f4help-fieldname = 'MTART'.
  gs_f4help-register = abap_true.
  APPEND gs_f4help TO gt_f4help.

  lo_alv->register_f4_for_fields(
    EXPORTING
      it_f4 = gt_f4help
  ).

*&---------------------------------------------------------------------*
*&  EXCLUDING A BUTTON FROM TOOLBAR
*&---------------------------------------------------------------------*
  gs_exclude = cl_gui_alv_grid=>mc_fc_print.
  APPEND gs_exclude TO gt_exclude.

  gs_exclude = cl_gui_alv_grid=>mc_fc_sum.
  APPEND gs_exclude TO gt_exclude.

*&---------------------------------------------------------------------*
*&  EVENT REGISTRATION
*&---------------------------------------------------------------------*
  SET HANDLER lo_alv_evt->evt_doubleclick FOR lo_alv.
  SET HANDLER lo_alv_evt->evt_f4help FOR lo_alv.
  SET HANDLER lo_alv_evt->evt_toolbar FOR lo_alv.
  SET HANDLER lo_alv_evt->evt_usercomm FOR lo_alv.

** Step 3
** Display the ALV
  lo_alv->set_table_for_first_display(
    EXPORTING
      it_toolbar_excluding = gt_exclude
    CHANGING
      it_outtab = gt_mara
      it_fieldcatalog = gt_fcat
  ).

  IF sy-subrc NE 0.
    MESSAGE |Structure or internal table error!| TYPE 'E'.
  ENDIF.

ENDMODULE.

*&---------------------------------------------------------------------*
*&  Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*&  PAI EVENTS
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.

  DATA okcode_200 TYPE sy-ucomm.

  IF okcode_200 EQ 'EXIT'.
    LEAVE PROGRAM.
  ENDIF.

ENDMODULE.