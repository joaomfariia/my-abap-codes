*&---------------------------------------------------------------------*
*& Include          ZCORE34_INT_REPORT_TOP
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ty_customers,  "customers

         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,

       END OF ty_customers.

TYPES: BEGIN OF ty_vbak,       "sales orders

         vbeln TYPE vbak-vbeln,
         erdat TYPE vbak-erdat,
         erzet TYPE vbak-erzet,
         ernam TYPE vbak-ernam,

       END OF ty_vbak.

TYPES: BEGIN OF ty_vbap,       "sales items

         vbeln TYPE vbap-vbeln,
         posnr TYPE vbap-posnr,
         matnr TYPE vbap-matnr,
         netwr TYPE vbap-netwr,

       END OF ty_vbap.

DATA: it_customers TYPE TABLE OF ty_customers,
      wa_customer  TYPE ty_customers,
      it_vbak      TYPE TABLE OF ty_vbak,
      wa_vbak      TYPE ty_vbak,
      it_vbap      TYPE TABLE OF ty_vbap,
      wa_vbap      TYPE ty_vbap,
      alv_table    TYPE REF TO cl_salv_table.

DATA: gv_kunnr TYPE kna1-kunnr,
      gv_vbeln TYPE vbak-vbeln,
      gv_matnr type vbap-matnr.

*SELECT-OPTIONS so_kunnr FOR gv_kunnr DEFAULT 'COG-01-01'.
SELECT-OPTIONS so_kunnr FOR gv_kunnr DEFAULT '3000119'.