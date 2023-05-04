*&---------------------------------------------------------------------*
*& Report ZBAPI_PO_CHANGE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbapi_po_change.

DATA: l_ponumber   LIKE bapimepoheader-po_number,
      lc_po_number TYPE bapimepoheader-po_number,
      i_po_items   TYPE TABLE OF bapimepoitem WITH HEADER LINE,
      i_po_itemsx  TYPE TABLE OF bapimepoitemx WITH HEADER LINE,
      i_return     TYPE TABLE OF bapiret2 WITH HEADER LINE.

CLEAR: i_po_items, i_po_items[],
       i_po_itemsx, i_po_itemsx[],
       i_return, i_return[].

l_ponumber = '4500000000'.

i_po_items-po_item = '00010'.
i_po_items-agreement = '4600000782'.      "Actual value (deletion flag)i_po_itemsx-agr
i_po_items-agmt_item = '00010'.           "Actual value (deletion flag)
i_po_items-funds_res = '5000000019'.      "Actual value (deletion flag)
i_po_items-res_item = '001'.              "Actual value (deletion flag)

i_po_itemsx-po_item = '00010'.
i_po_itemsx-agreement = 'X'.
i_po_itemsx-agmt_item = 'X'.
i_po_itemsx-funds_res = 'X'.
i_po_itemsx-res_item = 'X'.

APPEND: i_po_items, i_po_itemsx.

* Call BAPI to change PO, the change is setting the deletion indicator.
CALL FUNCTION 'BAPI_PO_CHANGE'
  EXPORTING
    purchaseorder = l_ponumber
    testrun       = space
  TABLES
    poitem        = i_po_items
    poitemx       = i_po_itemsx
    return        = i_return.

READ TABLE i_return WITH KEY type = 'E'.
IF sy-subrc EQ 0.
  MESSAGE |BAPI ERROR!| TYPE 'E' DISPLAY LIKE 'E'.
ELSE.
  CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
  MESSAGE |BAPI COMMITTED!| TYPE 'S' DISPLAY LIKE 'S'.
ENDIF.