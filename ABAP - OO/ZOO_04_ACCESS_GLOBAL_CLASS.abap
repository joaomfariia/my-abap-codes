*&---------------------------------------------------------------------*
*& Report ZOO_04_ACCESS_GLOBAL_CLASS
*&---------------------------------------------------------------------*
*& Accessing a global class
*&---------------------------------------------------------------------*
REPORT zoo_04_access_global_class.

PARAMETERS p_kunnr TYPE kna1-kunnr DEFAULT '0014100001'.

DATA lo_obj TYPE REF TO zcl_01_global_class.

lo_obj = NEW #( ).

lo_obj->get_customer_data(
  EXPORTING
    i_kunnr = p_kunnr ).