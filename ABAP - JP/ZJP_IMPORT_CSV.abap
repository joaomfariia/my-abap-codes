*&---------------------------------------------------------------------*
*& Report ZJP_IMPORT_EXCEL
*&---------------------------------------------------------------------*
*& Import data from CSV file
*&---------------------------------------------------------------------*
REPORT zjp_import_csv.

TYPES: ty_file TYPE c LENGTH 2000,

       BEGIN OF ty_file_line,

         zid     TYPE c LENGTH 3,
         zdate   TYPE c LENGTH 8,
         zstore  TYPE c LENGTH 3,
         zcust   TYPE c LENGTH 20,
         zstatus TYPE c LENGTH 1,
         zuser   TYPE c LENGTH 20,
         netwr   TYPE c LENGTH 15,
         waerk   TYPE c LENGTH 5,

       END OF ty_file_line,

       BEGIN OF ty_data,

         zid     TYPE ztab_attendances-zid,
         zdate   TYPE dats,
         zstore  TYPE ztab_attendances-zstore,
         zcust   TYPE ztab_attendances-zcust,
         zstatus TYPE ztab_attendances-zstatus,
         zuser   TYPE ztab_attendances-zuser,
         netwr   TYPE netwr,
         waerk   TYPE waerk,

       END OF ty_data.

DATA: gt_data TYPE STANDARD TABLE OF ty_data,
      gt_file TYPE STANDARD TABLE OF ty_file.

DATA: gt_attend TYPE TABLE OF ztab_attendances.

PARAMETERS: p_file TYPE rlgrap-filename DEFAULT 'C:\Users\joaof\Desktop\csv.csv'.

PARAMETERS: p_header AS CHECKBOX DEFAULT abap_true.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  PERFORM f_open_file USING p_file.

START-OF-SELECTION.

  IF p_file IS NOT INITIAL.
    PERFORM f_upload_data.
    PERFORM f_process_data.

    IF sy-subrc EQ 0.
      MESSAGE 'Dados inseridos com sucesso!' TYPE 'I' DISPLAY LIKE 'I'.
    ENDIF.
  ENDIF.

END-OF-SELECTION.

*&---------------------------------------------------------------------*
*& Form f_open_file
*&---------------------------------------------------------------------*
FORM f_open_file USING p_file TYPE rlgrap-filename.

  DATA: lt_file TYPE filetable,
        ls_file TYPE file_table,
        lv_rc   TYPE sy-subrc.

  CALL METHOD cl_gui_frontend_services=>file_open_dialog
    EXPORTING
      window_title = 'Select a file'
    CHANGING
      file_table   = lt_file[]
      rc           = lv_rc.

  TRY.
      ls_file = lt_file[ 1 ].
    CATCH cx_sy_itab_line_not_found INTO DATA(lv_erro).
  ENDTRY.

  CHECK lv_erro IS INITIAL.
  p_file = ls_file.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_upload_data
*&---------------------------------------------------------------------*
FORM f_upload_data .

  DATA: lv_filename TYPE string.

  lv_filename = p_file.

  CALL METHOD cl_gui_frontend_services=>gui_upload
    EXPORTING
      filename = lv_filename
    CHANGING
      data_tab = gt_file.

  IF sy-subrc <> 0.
    MESSAGE 'Upload not possible...' TYPE 'E'.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form f_process_data
*&---------------------------------------------------------------------*
FORM f_process_data .

** Checks if header exists
  DATA(lv_start_line) = COND i( WHEN p_header = abap_true THEN 2 ELSE 1 ).

** Checks if file has entries
  IF ( lines( gt_file ) > lv_start_line - 1 ).

    LOOP AT gt_file ASSIGNING FIELD-SYMBOL(<fs_file>) .

      DATA(gs_file_line) = VALUE ty_data( ).

      CASE lv_start_line.

        WHEN 1. " no header
          SPLIT <fs_file> AT ';' INTO TABLE DATA(it_split).

          IF lines( it_split ) = 8.

            gs_file_line-zid     = it_split[ 1 ].
            gs_file_line-zdate   = it_split[ 2 ].

            " Data format conversion
            CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
              EXPORTING
                date_external            = gs_file_line-zdate
              IMPORTING
                date_internal            = gs_file_line-zdate
              EXCEPTIONS
                date_external_is_invalid = 1
                OTHERS                   = 2.

            IF sy-subrc EQ 1.
              MESSAGE 'Invalid date format!' TYPE 'E'.
            ENDIF.

            gs_file_line-zstore  = it_split[ 3 ].
            gs_file_line-zcust   = it_split[ 4 ].
            gs_file_line-zstatus = it_split[ 5 ].
            gs_file_line-zuser   = it_split[ 6 ].
            gs_file_line-netwr   = it_split[ 7 ].
            gs_file_line-waerk   = it_split[ 8 ].

            APPEND gs_file_line TO gt_data.

          ENDIF.

        WHEN 2. " header
          lv_start_line = lv_start_line - 1.
          CONTINUE.

      ENDCASE.

    ENDLOOP.

    MOVE-CORRESPONDING gt_data TO gt_attend.
    MODIFY ztab_attendances FROM TABLE @gt_attend.
    COMMIT WORK.

    cl_demo_output=>display_data( gt_attend ).

  ELSE.
    MESSAGE 'No entries in the file.' TYPE 'E'.
  ENDIF.

ENDFORM.