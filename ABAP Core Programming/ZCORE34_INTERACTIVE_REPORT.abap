*&---------------------------------------------------------------------*
*& Report zcore34_int_report
*&---------------------------------------------------------------------*
*& At Line-Selection | sy-lise | Set Parameter ID | HIDE
*&---------------------------------------------------------------------*
REPORT zcore34_interactive_report NO STANDARD PAGE HEADING.

INCLUDE zcore34_int_report_top.
INCLUDE zcore34_int_report_forms.
INCLUDE zcore34_int_report_alv_forms.

*--------------------------------------------------------------------*
* START-OF-SELECTION                                                        *
*--------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_customers.

  IF it_customers IS NOT INITIAL.

    PERFORM display_customers.

  ELSE.

    MESSAGE 'Customer not found..' TYPE 'I' DISPLAY LIKE 'E'.

  ENDIF.

*--------------------------------------------------------------------*
* TOP-OF-PAGE                                                        *
*--------------------------------------------------------------------*

TOP-OF-PAGE.

  WRITE: /20 'CUSTOMER MASTER DATA' COLOR 1.

TOP-OF-PAGE DURING LINE-SELECTION.

  CASE sy-lsind.

    WHEN 1.

      WRITE: /25 'SALES ORDERS' COLOR 7.

    WHEN 2.

      WRITE: /20 'SALES ITEMS' COLOR 6.

  ENDCASE.

*--------------------------------------------------------------------*
* AT LINE-SELECTION                                                  *
*--------------------------------------------------------------------*

AT LINE-SELECTION.

*  WRITE:/ 'Selected line is', sy-lisel. "selects all line content

  CASE sy-lsind. "list index

    WHEN 1.

      CLEAR gv_kunnr.
      gv_kunnr = sy-lisel+0(20).    "offset logic

      IF gv_kunnr IS NOT INITIAL.   "customer number

        PERFORM get_sales_orders.

        IF it_vbak IS NOT INITIAL.  "sales order internal table

          PERFORM display_sales_orders.

        ELSE.

          MESSAGE 'No sales orders for the selected customer..' TYPE 'I' DISPLAY LIKE 'E'.

        ENDIF.

      ENDIF.

    WHEN 2.

      CLEAR gv_vbeln.
      gv_vbeln = sy-lisel+0(10).

      IF gv_vbeln IS NOT INITIAL.

        PERFORM get_sales_items.

        IF it_vbap IS NOT INITIAL.

          PERFORM display_sales_items.

        ELSE.

          MESSAGE 'No sales items for the selected doc number.' TYPE 'I' DISPLAY LIKE 'E'.

        ENDIF.

      ENDIF.

    WHEN 3.

      CLEAR gv_matnr.
      gv_matnr = sy-lisel+61(18).

      IF gv_matnr IS NOT INITIAL.

        SET PARAMETER ID 'MAT' FIELD gv_matnr.
        CALL TRANSACTION 'MM03'.

      ENDIF.

  ENDCASE.