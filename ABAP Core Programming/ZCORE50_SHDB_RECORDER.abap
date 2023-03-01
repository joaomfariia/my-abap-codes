REPORT zcore50_shdb_recorder
       NO STANDARD PAGE HEADING LINE-SIZE 255.

* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
INCLUDE bdcrecx1_s.

PARAMETERS: dataset(132) LOWER CASE.
***    DO NOT CHANGE - the generated data section - DO NOT CHANGE    ***
*
*   If it is nessesary to change the data section use the rules:
*   1.) Each definition of a field exists of two lines
*   2.) The first line shows exactly the comment
*       '* data element: ' followed with the data element
*       which describes the field.
*       If you don't have a data element use the
*       comment without a data element name
*   3.) The second line shows the fieldname of the
*       structure, the fieldname must consist of
*       a fieldname and optional the character '_' and
*       three numbers and the field length in brackets
*   4.) Each field must be type C.
*
*** Generated data section with specific formatting - DO NOT CHANGE  ***
DATA: BEGIN OF record,
* data element: MATNR
        matnr_001(040),
* data element: MBRSH
        mbrsh_002(001),
* data element: MTART
        mtart_003(004),
* data element: XFELD
        kzsel_01_004(001),
* data element: MAKTX
        maktx_005(040),
* data element: MEINS
        meins_006(003),
* data element: MTPOS_MARA
        mtpos_mara_007(004),
      END OF record.

*** End generated data section ***

**********************************************************************
* BEGIN OF CUSTOM CHANGES
**********************************************************************

TYPES: BEGIN OF ty_legacy,

         string TYPE string,

       END OF ty_legacy.

DATA: it_legacy TYPE TABLE OF ty_legacy,
      wa_legacy TYPE ty_legacy.

TYPES: BEGIN OF ty_final,

         matnr TYPE rmmg1-matnr,
         mbrsh TYPE rmmg1-mbrsh,
         mtart TYPE rmmg1-mtart,
         maktx TYPE makt-maktx,
         meins TYPE mara-meins,

       END OF ty_final.

DATA: it_final TYPE TABLE OF ty_final,
      wa_final TYPE ty_final.


START-OF-SELECTION.

  " Read data from local text file
  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename = 'C:\Users\joaof\Documents\material.txt'
    TABLES
      data_tab = it_legacy.

  IF it_legacy IS NOT INITIAL.

    LOOP AT it_legacy INTO wa_legacy.

      CLEAR wa_final.
      SPLIT wa_legacy-string AT ',' INTO wa_final-matnr
                                         wa_final-mbrsh
                                         wa_final-mtart
                                         wa_final-maktx
                                         wa_final-meins.
      APPEND wa_final TO it_final.

    ENDLOOP.

  ENDIF.


  " Read the data from the application server(!)
*  PERFORM open_dataset USING dataset.


**********************************************************************
* END OF CUSTOM CHANGES
**********************************************************************

  PERFORM open_group.

**  DO.

  IF it_final IS NOT INITIAL.

    LOOP AT it_final INTO wa_final.

**    READ DATASET dataset INTO record.
**    IF sy-subrc <> 0. EXIT. ENDIF.

      PERFORM bdc_dynpro      USING 'SAPLMGMM' '0060'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'RMMG1-MATNR'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=ENTR'.
      PERFORM bdc_field       USING 'RMMG1-MATNR' wa_final-matnr.
**                                  record-matnr_001.
      PERFORM bdc_field       USING 'RMMG1-MBRSH' wa_final-mbrsh.
**                                  record-mbrsh_002.
      PERFORM bdc_field       USING 'RMMG1-MTART' wa_final-mtart.
**                                  record-mtart_003.
      PERFORM bdc_dynpro      USING 'SAPLMGMM' '0070'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'MSICHTAUSW-DYTXT(01)'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=ENTR'.
      PERFORM bdc_field       USING 'MSICHTAUSW-KZSEL(01)' 'X'.
**                                    record-kzsel_01_004. "selection field
      PERFORM bdc_dynpro      USING 'SAPLMGMM' '4004'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=BU'.
      PERFORM bdc_field       USING 'MAKT-MAKTX' wa_final-maktx.
**                                  record-maktx_005.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'MARA-MEINS'.
      PERFORM bdc_field       USING 'MARA-MEINS' wa_final-meins.
**                                  record-meins_006.
      PERFORM bdc_field       USING 'MARA-MTPOS_MARA'
                                    record-mtpos_mara_007. "selection field
      PERFORM bdc_transaction USING 'MM01'.

    ENDLOOP.

  ENDIF.

**  ENDDO.

  PERFORM close_group.
**  PERFORM close_dataset USING dataset.