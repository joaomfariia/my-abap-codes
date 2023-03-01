*&---------------------------------------------------------------------*
*& Report ZCORE49_BDC_EXCEL
*&---------------------------------------------------------------------*
*& Data Migration from Excel to SAP using Call Transaction
*&---------------------------------------------------------------------*
REPORT zcore49_bdc_excel_and_log.

TYPES: BEGIN OF ty_kna1,

         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,

       END OF ty_kna1.

DATA: it_kna1 TYPE TABLE OF ty_kna1,
      wa_kna1 TYPE ty_kna1.

" F.M. TEXT_CONVERT_XLS_TO_SAP table type
DATA: it_truxs TYPE truxs_t_text_data.

DATA: it_bdcdata TYPE TABLE OF bdcdata,
      wa_bdcdata TYPE bdcdata.

" BDC Message log internal table
DATA: it_bdcmsgcoll TYPE TABLE OF bdcmsgcoll,
      wa_bdcmsgcoll TYPE bdcmsgcoll.

TYPES: BEGIN OF ty_log,

         recno TYPE n,
         msg   TYPE string,

       END OF ty_log.

DATA: it_log TYPE TABLE OF ty_log,
      wa_log TYPE ty_log.

" Read data from local excel file to internal table.
DATA: gv_fname TYPE rlgrap-filename VALUE 'C:\Users\joaof\Documents\customer_xls.xls'.

CALL FUNCTION 'TEXT_CONVERT_XLS_TO_SAP'
  EXPORTING
    i_tab_raw_data       = it_truxs
    i_filename           = gv_fname
  TABLES
    i_tab_converted_data = it_kna1.

IF sy-subrc NE 0.

  MESSAGE 'Convertion Failed...' TYPE 'E' DISPLAY LIKE 'I'.

ENDIF.

IF it_kna1 IS NOT INITIAL.

  " Map the final data to BDCDATA internal table
  LOOP AT it_kna1 INTO wa_kna1.

    PERFORM map_program_info USING 'ZCORE46_BDC_MPP' '100'.
    PERFORM map_field_info USING 'KNA1-KUNNR' wa_kna1-kunnr.
    PERFORM map_field_info USING 'KNA1-LAND1' wa_kna1-land1.
    PERFORM map_field_info USING 'KNA1-NAME1' wa_kna1-name1.

    " Send the data to the MPP tcode and the messages to an internal table
    CALL TRANSACTION 'ZBDC' USING it_bdcdata MESSAGES INTO it_bdcmsgcoll.

  ENDLOOP.

ENDIF.

IF it_bdcmsgcoll IS NOT INITIAL.

  " Populated by the BDC in CALL TRANSACTION
  LOOP AT it_bdcmsgcoll INTO wa_bdcmsgcoll.

    CLEAR wa_log.

    " Union the BDC messages to wa_log
    CALL FUNCTION 'FORMAT_MESSAGE'
      EXPORTING
        id   = wa_bdcmsgcoll-msgid
        lang = sy-langu
        no   = wa_bdcmsgcoll-msgnr
        v1   = wa_bdcmsgcoll-msgv1
        v2   = wa_bdcmsgcoll-msgv2
        v3   = wa_bdcmsgcoll-msgv3
        v4   = wa_bdcmsgcoll-msgv4
      IMPORTING
        msg  = wa_log-msg.

    IF sy-subrc NE 0.

      MESSAGE 'Log creation failed...' TYPE 'I' DISPLAY LIKE 'E'.

    ENDIF.

    wa_log-recno = sy-tabix.
    APPEND wa_log TO it_log.

  ENDLOOP.

ENDIF.

IF it_log IS NOT INITIAL.

  " Write the log to a text file
  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename              = 'C:\Users\joaof\Documents\bdclog.txt'
      write_field_separator = 'X'
    TABLES
      data_tab              = it_log.

  " Write the log to the application server
*  DATA: gv_path TYPE string VALUE '\\172.26.99.189\c\bdclog_app_server.txt',
*        gv_msg  TYPE string.
*
*  OPEN DATASET gv_path FOR OUTPUT IN TEXT MODE ENCODING DEFAULT MESSAGE gv_msg.
*
*  IF sy-subrc EQ 0.
*
*    CLEAR gv_msg.
*
*    LOOP AT it_log INTO wa_log.
*
*      CONCATENATE wa_log-recno wa_log-msg into gv_msg SEPARATED BY space.
*      TRANSFER gv_msg TO gv_path.
*
*    ENDLOOP.
*
*    CLOSE DATASET gv_path.
*
*  ENDIF.

ENDIF.

FORM map_program_info USING program dynpro.

  CLEAR it_bdcdata.
  CLEAR wa_bdcdata.
  wa_bdcdata-program = program.
  wa_bdcdata-dynpro = dynpro.
  wa_bdcdata-dynbegin = abap_true.
  APPEND wa_bdcdata TO it_bdcdata.

ENDFORM.

FORM map_field_info USING fnam fval.

  CLEAR wa_bdcdata.
  wa_bdcdata-fnam = fnam.
  wa_bdcdata-fval = fval.
  APPEND wa_bdcdata TO it_bdcdata.

ENDFORM.