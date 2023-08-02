*&---------------------------------------------------------------------*
*& Report ZOO_03_METHOD_WITHIN_METHOD
*&---------------------------------------------------------------------*
*& Call a method within another method
*&---------------------------------------------------------------------*
REPORT zoo_03_method_within_method.

CLASS lcl_modularization_methods DEFINITION.

  PUBLIC SECTION.
    METHODS:
      get_customer_data IMPORTING i_kunnr TYPE kna1-kunnr.


  PROTECTED SECTION.
    METHODS:
      display_customer_data,

      get_vbak IMPORTING i_cust TYPE kna1-kunnr,

      display_vbak.

    TYPES: BEGIN OF ty_customer,
             name1 TYPE kna1-name1,
             ort01 TYPE kna1-ort01,
           END OF ty_customer.

    TYPES: BEGIN OF ty_vbak,
             vbeln TYPE vbak-vbeln,
             erdat TYPE vbak-erdat,
             erzet TYPE vbak-erzet,
             ernam TYPE vbak-ernam,
           END OF ty_vbak.

    DATA: wa_customer TYPE ty_customer.

    DATA: it_vbak TYPE TABLE OF ty_vbak,
          wa_vbak TYPE ty_vbak.

ENDCLASS.

CLASS lcl_modularization_methods IMPLEMENTATION.

  METHOD get_customer_data.
    SELECT SINGLE name1, ort01 FROM kna1 INTO @wa_customer WHERE kunnr = @i_kunnr.

    IF sy-subrc EQ 0.
      me->display_customer_data( ).   " Syntax 01
*      display_customer_data( ).       " Syntax 02

      get_vbak( EXPORTING i_cust = i_kunnr ).

    ENDIF.
  ENDMETHOD.

  METHOD display_customer_data.

    IF wa_customer IS NOT INITIAL.
      FORMAT COLOR 3.
      WRITE: / |Customer name = {  wa_customer-name1 }|,
             / |Customer city = {  wa_customer-ort01 }|.
      FORMAT COLOR OFF.
      ULINE.
    ELSE.
      MESSAGE |No customer found...| TYPE 'E'.
    ENDIF.

  ENDMETHOD.

  METHOD get_vbak.
    SELECT vbeln, erdat, erzet, ernam FROM vbak INTO TABLE @it_vbak WHERE kunnr = @i_cust. "0014100001
*     WHERE kunnr = @i_cust.

    IF sy-subrc EQ 0.
      display_vbak( ).
    ENDIF.

  ENDMETHOD.

  METHOD display_vbak.

    IF it_vbak IS NOT INITIAL.

      DATA(lv_lines) = lines( it_vbak ).

      FORMAT COLOR 1.
      WRITE: / |Number of sales orders: { lv_lines }|.
      FORMAT COLOR OFF.
      ULINE.

      LOOP AT it_vbak ASSIGNING FIELD-SYMBOL(<fs_vbak>).
        WRITE: / <fs_vbak>-vbeln,
                 <fs_vbak>-erdat,
                 <fs_vbak>-erzet,
                 <fs_vbak>-ernam.
      ENDLOOP.

    ELSE.
      MESSAGE |No document found...| TYPE 'I' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  PARAMETERS: p_kunnr TYPE kna1-kunnr DEFAULT '14100001'.

  DATA: lo_customer TYPE REF TO lcl_modularization_methods.

  lo_customer = NEW #( ).
  lo_customer->get_customer_data( EXPORTING i_kunnr = p_kunnr ).

*  lo_customer->display_customer_data( ).    " Syntax error! Protected method!