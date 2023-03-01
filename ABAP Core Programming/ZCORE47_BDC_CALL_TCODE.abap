*&---------------------------------------------------------------------*
*& Report ZCORE47_BDC_CALL_TCODE
*&---------------------------------------------------------------------*
*& Data Migration using Call Transaction
*&---------------------------------------------------------------------*
REPORT zcore47_bdc_call_tcode.

PARAMETERS: p_fname TYPE string.

TYPES: BEGIN OF ty_kna1,

         kunnr TYPE kna1-kunnr,
         land1 TYPE kna1-land1,
         name1 TYPE kna1-name1,

       END OF ty_kna1.

DATA: it_kna1 TYPE TABLE OF ty_kna1,
      wa_kna1 TYPE ty_kna1.

DATA: gv_path TYPE ibipparms-path.

DATA: it_temp TYPE TABLE OF string.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_fname.

  CALL FUNCTION 'F4_FILENAME'
    IMPORTING
      file_name = gv_path.

  IF gv_path IS NOT INITIAL.

    p_fname = gv_path.

  ENDIF.

START-OF-SELECTION.

  IF p_fname IS NOT INITIAL.

    CALL METHOD cl_gui_frontend_services=>gui_upload
      EXPORTING
        filename            = p_fname
        has_field_separator = space
      CHANGING
        data_tab            = it_temp.

    IF it_temp IS NOT INITIAL.

      LOOP AT it_temp INTO DATA(wa_temp).

        CLEAR wa_kna1.
        SPLIT wa_temp AT ',' INTO wa_kna1-kunnr
                                  wa_kna1-land1
                                  wa_kna1-name1.
        APPEND wa_kna1 TO it_kna1.

      ENDLOOP.

      IF it_kna1 IS NOT INITIAL.

        " Need to map the data into BDCDATA internal table
        DATA: it_bdcdata TYPE TABLE OF bdcdata,
              wa_bdcdata TYPE bdcdata.

        LOOP AT it_kna1 INTO wa_kna1.

          PERFORM map_program_info USING 'ZCORE46_BDC_MPP' '100'.
          PERFORM map_field_info USING 'KNA1-KUNNR' wa_kna1-kunnr.
          PERFORM map_field_info USING 'KNA1-LAND1' wa_kna1-land1.
          PERFORM map_field_info USING 'KNA1-NAME1' wa_kna1-name1.

          CALL TRANSACTION 'ZBDC' USING it_bdcdata.

        ENDLOOP.

      ELSE.

        MESSAGE 'KNA1 internal table not filled..' TYPE 'I' DISPLAY LIKE 'E'.

      ENDIF.

    ENDIF.

  ENDIF.

FORM map_program_info USING program dynpro.

  CLEAR it_bdcdata.
  CLEAR wa_bdcdata.
  wa_bdcdata-program  = program.
  wa_bdcdata-dynpro   = dynpro.
  wa_bdcdata-dynbegin = abap_true.
  APPEND wa_bdcdata TO it_bdcdata.

ENDFORM.

FORM map_field_info  USING fname fvalue.

  CLEAR wa_bdcdata.
  wa_bdcdata-fnam = fname.
  wa_bdcdata-fval = fvalue.
  APPEND wa_bdcdata TO it_bdcdata.

ENDFORM.