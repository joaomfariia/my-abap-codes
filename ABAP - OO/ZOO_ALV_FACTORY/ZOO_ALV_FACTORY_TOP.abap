*&---------------------------------------------------------------------*
*& Include          ZOO_ALV_FACTORY_TOP
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_mara,

         matnr TYPE mara-matnr,
         ernam TYPE mara-ernam,
         mtart TYPE mara-mtart,
         matkl TYPE mara-matkl,

       END OF ty_mara.

DATA: it_mara TYPE TABLE OF ty_mara.

DATA: lo_alv TYPE REF TO cl_salv_table.