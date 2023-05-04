*&---------------------------------------------------------------------*
*& Include          ZOO_ALV_REPORT_TOP
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ty_mara,

         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         ernam TYPE mara-ernam,

       END OF ty_mara.

DATA: lo_cust_cont TYPE REF TO cl_gui_custom_container,
      lo_alv       TYPE REF TO cl_gui_alv_grid.

DATA: gt_mara    TYPE TABLE OF ty_mara,

      gt_fcat    TYPE lvc_t_fcat,       " field catalog
      gs_fcat    TYPE LINE OF lvc_t_fcat,

      gt_exclude TYPE ui_functions,
      gs_exclude TYPE LINE OF ui_functions,

      gt_f4help  TYPE lvc_t_f4,
      gs_f4help  TYPE LINE OF lvc_t_f4.

data  gs_f4help_2 type lvc_s_f4.