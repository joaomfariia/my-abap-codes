*&---------------------------------------------------------------------*
*& Report ZCORE45_BDC_GUI_UPLOAD
*&---------------------------------------------------------------------*
*& Data Migration from Local Text File to SAP
*&---------------------------------------------------------------------*
REPORT zcore45_bdc_gui_upload.

PARAMETERS: p_fname TYPE string.

DATA: gv_path TYPE ibipparms-path.

DATA: it_temp TYPE TABLE OF string.

TYPES: BEGIN OF ty_final,

         mandt    TYPE zemployee-mandt,
         zempid   TYPE zemployee-zempid,
         zempname TYPE zemployee-zempname,
         zemprole TYPE zemployee-zemprole,

       END OF ty_final.

DATA: it_final TYPE TABLE OF ty_final,
      wa_final TYPE ty_final.

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
        filename = p_fname
        " do not need it_temp
*       has_field_separator = 'X'
      CHANGING
        data_tab = it_temp.

    IF it_temp IS NOT INITIAL.

      LOOP AT it_temp INTO DATA(wa_temp).

        CLEAR wa_final.
        SPLIT wa_temp AT ',' INTO wa_final-zempid
                                  wa_final-zempname
                                  wa_final-zemprole.
        APPEND wa_final TO it_final.

      ENDLOOP.

      IF it_final IS NOT INITIAL.

        MODIFY zemployee FROM TABLE it_final.

        IF sy-subrc EQ 0.
          MESSAGE 'Final internal table filled!' TYPE 'I' DISPLAY LIKE 'S'.

        ELSE.
          MESSAGE 'Final internal table could not be filled!' TYPE 'I' DISPLAY LIKE 'S'.

        ENDIF.

      ENDIF.

    ELSE.
      MESSAGE 'Data migration failed...' TYPE 'I' DISPLAY LIKE 'E'.

    ENDIF.

  ELSE.
    MESSAGE 'Please, select a file pressing F4.' TYPE 'I' DISPLAY LIKE 'W'.

  ENDIF.