*&---------------------------------------------------------------------*
*& Report ZBAPI_EXTENSION
*&---------------------------------------------------------------------*
*& CUSTOM FIELD EXTENSION
*&---------------------------------------------------------------------*
REPORT zbapi_extension.

DATA p_ebeln LIKE bapimepoheader-po_number VALUE '4500000000'.

DATA: wa_mepoheader  LIKE bapi_te_mepoheader,       " purchase order h. - table extension
      wa_mepoheaderx LIKE bapi_te_mepoheaderx,      " whats being changed - table extension
      it_return      TYPE TABLE OF bapiret2 WITH HEADER LINE.

DATA: it_poitem  TYPE bapimepoitem_tp,
      it_poitemx TYPE bapimepoitemx_tp.

FIELD-SYMBOLS: <fs_poitem>  LIKE LINE OF it_poitem,
               <fs_poitemx> LIKE LINE OF it_poitemx.

DATA: wa_extensionin TYPE bapiparex OCCURS 0 WITH HEADER LINE.

*-----------------------------------------------------------*
* PURCHASE ORDER - HEADER
*-----------------------------------------------------------*
wa_mepoheader-po_number = p_ebeln.                          "4500000000
wa_mepoheader-zz1_nfnum = '12345ABCDE'.

wa_mepoheaderx-po_number = p_ebeln.
wa_mepoheaderx-zz1_nfnum = 'X'.

*-----------------------------------------------------------*
* PURCHASE ORDER - ITEM
*-----------------------------------------------------------*
APPEND INITIAL LINE TO it_poitem  ASSIGNING <fs_poitem>.
APPEND INITIAL LINE TO it_poitemx ASSIGNING <fs_poitemx>.

<fs_poitem>-po_item  = '00010'.           <fs_poitemx>-po_itemx   = 'X'.
<fs_poitem>-short_text = 'TESTE'.         <fs_poitemx>-short_text = 'X'.
<fs_poitem>-agreement  = '4600000783'.    <fs_poitemx>-agreement   = 'X'.
<fs_poitem>-agmt_item  = '00010'.         <fs_poitemx>-agmt_item   = 'X'.
<fs_poitem>-funds_res  = '5000000020'.    <fs_poitemx>-funds_res   = 'X'.
<fs_poitem>-res_item   = '001'.           <fs_poitemx>-res_item    = 'X'.

*-----------------------------------------------------------*
* FIELD EXTENSION
*-----------------------------------------------------------*
wa_extensionin-structure = 'BAPI_TE_MEPOHEADER'.
wa_extensionin-valuepart1 = wa_mepoheader.        " estrutura do pedido
APPEND wa_extensionin.

wa_extensionin-structure = 'BAPI_TE_MEPOHEADERX'.
wa_extensionin-valuepart1 = wa_mepoheaderx.
APPEND wa_extensionin.

*-----------------------------------------------------------*
* BAPI #BAPI_PO_CHANGE
*-----------------------------------------------------------*
CALL FUNCTION 'BAPI_PO_CHANGE'
  EXPORTING
    purchaseorder = p_ebeln
  TABLES
    poitem        = it_poitem
    poitemx       = it_poitemx
    return        = it_return
    extensionin   = wa_extensionin.

READ TABLE it_return WITH KEY type = 'E'.

IF sy-subrc NE 0.
  READ TABLE it_return WITH KEY type = 'A'.

  IF sy-subrc NE 0.
* Commit changes to database
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
    MESSAGE |P.O { p_ebeln } successfully changed!| TYPE 'S' DISPLAY LIKE 'S'.

  ELSE.
    WRITE: / it_return-message.

  ENDIF.

ENDIF.