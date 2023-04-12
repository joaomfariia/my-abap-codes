*&---------------------------------------------------------------------*
*& Report ZCORE48_BDC_SECTION_METHOD
*&---------------------------------------------------------------------*
*& Data Migration using Section Method
*&---------------------------------------------------------------------*
REPORT zcore48_bdc_section_method.

TYPES: BEGIN OF ty_legacy,

         string TYPE string,

       END OF ty_legacy.

DATA: it_legacy TYPE TABLE OF ty_legacy,
      wa_legacy TYPE ty_legacy.

TYPES: BEGIN OF ty_final,

         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,

       END OF ty_final.

DATA: it_final TYPE TABLE OF ty_final,
      wa_final TYPE ty_final.

DATA: it_bdcdata TYPE TABLE OF bdcdata,
      wa_bdcdata TYPE bdcdata.

" File path problem(??) -- No path is accepted
DATA: gv_path TYPE string VALUE 'C:\Users\joaof\Downloads\customer.txt',
      gv_msg  TYPE string.

" Open the file in input mode for reading
OPEN DATASET gv_path FOR OUTPUT IN TEXT MODE ENCODING DEFAULT MESSAGE gv_msg.

IF sy-subrc EQ 0.

  " Transfer the data from the application server to the internal table
  DO.

    CLEAR wa_legacy.
    READ DATASET gv_path INTO wa_legacy-string.

    IF sy-subrc EQ 0.
      APPEND wa_legacy TO it_legacy.

    ELSE.
      EXIT.

    ENDIF.

  ENDDO.
  " Close the file
  CLOSE DATASET gv_path.

ELSE.
  WRITE: gv_msg.

ENDIF.

IF it_legacy IS NOT INITIAL.

  LOOP AT it_legacy INTO wa_legacy.

    CLEAR wa_legacy.
    SPLIT wa_legacy-string AT ',' INTO wa_final-kunnr
                                       wa_final-land1
                                       wa_final-name1.
    APPEND wa_final TO it_final.

  ENDLOOP.

ENDIF.

IF it_final IS NOT INITIAL.

  " Create the session object
  CALL FUNCTION 'BDC_OPEN_GROUP'
    EXPORTING
      client   = sy-mandt
      group    = 'S1'
      holddate = '20221131'
      keep     = 'X'
      user     = sy-uname.

  " Map the final data into the BDCDATA internal table
  LOOP AT it_final INTO wa_final.

    PERFORM map_program_info USING 'ZCORE46_BDC_MPP' '100'.
    PERFORM map_field_info   USING 'KNA1-KUNNR' wa_final-kunnr.
    PERFORM map_field_info   USING 'KNA1-LAND1' wa_final-land1.
    PERFORM map_field_info   USING 'KNA1-NAME1' wa_final-name1.

    " Map the BDCDATA internal table data to session object
    CALL FUNCTION 'BDC_INSERT'
      EXPORTING
        tcode     = 'ZBDC'
      TABLES
        dynprotab = it_bdcdata.

  ENDLOOP.

  CALL FUNCTION 'BDC_CLOSE_GROUP'.

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