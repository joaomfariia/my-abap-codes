*&---------------------------------------------------------------------*
*& Report zcore34_int_report
*&---------------------------------------------------------------------*
*& At Line-Selection | Get Cursor Field | Conversion Exit Alpha Input
*&---------------------------------------------------------------------*
REPORT zcore35_interactive_report NO STANDARD PAGE HEADING LINE-COUNT 10(3).

INCLUDE zcore35_int_report_top.
INCLUDE zcore35_int_report_forms.
INCLUDE zcore35_int_report_alv_forms.

*--------------------------------------------------------------------*
* START-OF-SELECTION                                                 *
*--------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM get_customers.

  IF it_customers IS NOT INITIAL.

    PERFORM display_customers.

  ELSE.

    MESSAGE 'Customer not found..' TYPE 'I' DISPLAY LIKE 'E'.

  ENDIF.

*--------------------------------------------------------------------*
* TOP-OF-PAGE and END-OF-PAGE                                        *
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

END-OF-PAGE.

  WRITE: / 'ABAP CORE PROGRAMMING COURSE' COLOR 5.

*--------------------------------------------------------------------*
* AT LINE-SELECTION                                                  *
*--------------------------------------------------------------------*

AT LINE-SELECTION.

*  WRITE:/ 'Selected line is', sy-lisel. "selects all line content

  CASE sy-lsind. "list index

    WHEN 1.

* Get the field name/value where user has done the interaction.
      GET CURSOR FIELD gv_fname VALUE gv_fvalue.

      IF gv_fname = 'WA_CUSTOMER-KUNNR'.

        PERFORM get_sales_orders.

        IF it_vbak IS NOT INITIAL.
          PERFORM display_sales_orders.    "jumps to next report index
        ELSE.
          MESSAGE 'No sales orders for the selected customer..' TYPE 'I' DISPLAY LIKE 'E'.
        ENDIF.

      ELSE.

        MESSAGE 'Please, select CUSTOMER only.' TYPE 'I' DISPLAY LIKE 'W'.

      ENDIF.

    WHEN 2.

* Get the field name/value where user has done the interaction.
      GET CURSOR FIELD gv_fname VALUE gv_fvalue.

      IF gv_fname = 'WA_VBAK-VBELN'.

        PERFORM get_sales_items.

        IF it_vbap IS NOT INITIAL.
          PERFORM display_sales_items.     "jumps to next report index
        ELSE.
          MESSAGE 'No sales items for the selected doc. number' TYPE 'I' DISPLAY LIKE 'E'.
        ENDIF.

      ELSE.

        MESSAGE 'Please, select SALES DOCUMENT only.' TYPE 'I' DISPLAY LIKE 'W'.

      ENDIF.

    WHEN 3.

* Get the field name/value where user has done the interaction.
      GET CURSOR FIELD gv_fname VALUE gv_fvalue.

      IF gv_fname EQ 'WA_VBAP-MATNR'.

        gv_matnr = gv_fvalue.                     "string to (N)

        SET PARAMETER ID 'MAT' FIELD gv_matnr.    "do not accept string
        CALL TRANSACTION 'MM03'.

      ELSE.

        MESSAGE 'Please, select MATERIAL only.' TYPE 'I' DISPLAY LIKE 'W'.

      ENDIF.

  ENDCASE.