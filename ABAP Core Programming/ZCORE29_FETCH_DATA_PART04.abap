*&---------------------------------------------------------------------*
*& Report ZCORE29_FETCH_DATA_PART04
*&---------------------------------------------------------------------*
*& Custom F4 Help
*&---------------------------------------------------------------------*
REPORT zcore29_fetch_data_part04.

*--------------------------------------------------------------------*
* SELECTION-SCREEN DESIGN                                            *
*--------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE t1. "text-000 ??

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 3(15) lb0.
    PARAMETERS: p_matnr TYPE mara-matnr. "data field definition

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK bk1.
SELECTION-SCREEN SKIP 1.

SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE t2.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 3(15) lb1 MODIF ID id1.
    PARAMETERS: p_mtart TYPE mara-mtart MODIF ID id1. "material type

  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 3(15) lb2 MODIF ID id1.
    PARAMETERS: p_mbrsh TYPE mara-mbrsh MODIF ID id1. "industry sector

  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 3(15) lb3 MODIF ID id1.
    PARAMETERS: p_matkl TYPE mara-matkl MODIF ID id1. "material group

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK bk2.
SELECTION-SCREEN SKIP 2.

SELECTION-SCREEN PUSHBUTTON 3(17) but1 USER-COMMAND fc1 MODIF ID pb1 .

*--------------------------------------------------------------------*
* STRUCTURE AND DATA DEFINITION                                      *
*--------------------------------------------------------------------*

TYPES: BEGIN OF ty_mat,

         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         mbrsh TYPE mara-mbrsh,
         matkl TYPE mara-matkl,

       END OF ty_mat,


       BEGIN OF ty_f4values,

         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,

       END OF ty_f4values.

DATA: it_mat      TYPE TABLE OF ty_mat,
      wa_mat      TYPE ty_mat,
      it_f4values TYPE TABLE OF ty_f4values.

*--------------------------------------------------------------------*
* INITIALIZATION                                                     *
*--------------------------------------------------------------------*

INITIALIZATION.

  t1 = 'Input Block'.
  t2 = 'Material Data'.

  lb0 = 'Material'.
  lb1 = 'Material Type'.
  lb2 = 'Industry Sector'.
  lb3 = 'Material Group'.

  but1 = 'Get Material Data'.

  PERFORM invisible_block2.

*--------------------------------------------------------------------*
* ON VALUE-REQUEST                                                   *
*--------------------------------------------------------------------*

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_matnr.

  MESSAGE 'Custom F4 help for material number.' TYPE 'I' DISPLAY LIKE 'I'.
  PERFORM get_f4values.

  IF it_f4values IS NOT INITIAL.

    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield        = 'MATNR'   "return field
        dynpprog        = sy-repid  "actual program
        dynpnr          = sy-dynnr  "screen number
        dynprofield     = 'P_MATNR' "f4 append field
        value_org       = 'S'      "value return -> C: cell by cell | S: structured
      TABLES
        value_tab       = it_f4values
      EXCEPTIONS
        parameter_error = 1
        no_values_found = 2
        OTHERS          = 3.

  ENDIF.

*--------------------------------------------------------------------*
* AT SELECTION-SCREEN                                                *
*--------------------------------------------------------------------*

AT SELECTION-SCREEN.

  CASE sy-ucomm.

      "pushbutton get material
    WHEN 'FC1'.

      PERFORM get_material_data.

      IF sy-subrc EQ 0.

        MESSAGE 'Material Information Found!!' TYPE 'I'.

      ELSE.

        MESSAGE 'This material does not exist..' TYPE 'W'.
        CLEAR: p_matnr.

      ENDIF.

      p_mtart = wa_mat-mtart.
      p_mbrsh = wa_mat-mbrsh.
      p_matkl = wa_mat-matkl.

  ENDCASE.

*--------------------------------------------------------------------*
* AT SELECTION-SCREEN OUTPUT                                         *
*--------------------------------------------------------------------*

AT SELECTION-SCREEN OUTPUT.

  IF p_matnr IS NOT INITIAL.

    IF p_mtart IS NOT INITIAL OR p_mbrsh IS NOT INITIAL
                              OR p_matkl IS NOT INITIAL.

      PERFORM visible_block2.

    ENDIF.

  ELSE.

    PERFORM invisible_block2.

  ENDIF.

*--------------------------------------------------------------------*
* FORMS                                                              *
*--------------------------------------------------------------------*

FORM get_material_data.

  SELECT SINGLE matnr,
                mtart,
                mbrsh,
                matkl
    FROM mara
    INTO @wa_mat
    WHERE matnr = @p_matnr.

  APPEND wa_mat TO it_mat.

ENDFORM.

FORM invisible_block2.

  LOOP AT SCREEN.

    IF screen-group1 = 'ID1'. "block 2

      screen-invisible = 1.   "makes invisible
      screen-input = 0.       "makes input field invisible
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM visible_block2.

  LOOP AT SCREEN.

    IF screen-group1 = 'ID1'.

      screen-invisible = 0.
      screen-input = 0.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM get_f4values.

  SELECT matnr
         mtart
    FROM mara
    INTO TABLE it_f4values
    WHERE mtart IN ('SERV', 'NLAG', 'ROH').

ENDFORM.

*--------------------------------------------------------------------*
* F1 HELP REQUEST                                                    *
*--------------------------------------------------------------------*

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_matnr.  "F1 key

  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'HOW TO USE THIS PROGRAM'
      txt1  = '1) Insert the material number'
      txt2  = '2) Press the "GET MATERIAL" button.'.