*&---------------------------------------------------------------------*
*& Report ZCORE29_FETCH_DATA_PART04
*&---------------------------------------------------------------------*
*& Selection Screen - Retrieving Data to Blocks
*&---------------------------------------------------------------------*
REPORT zjp_mara_data.

*--------------------------------------------------------------------*
* SELECTION-SCREEN DESIGN                                            *
*--------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE TEXT-000. "text-000 ??

  PARAMETERS: p_matnr TYPE mara-matnr MODIF ID id1. "data field definition

SELECTION-SCREEN END OF BLOCK bk1.
SELECTION-SCREEN SKIP 1.

SELECTION-SCREEN BEGIN OF BLOCK bk2 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_mtart TYPE mara-mtart MODIF ID id2, "material type
              p_mbrsh TYPE mara-mbrsh MODIF ID id2, "industry sector
              p_matkl TYPE mara-matkl MODIF ID id2. "material group

SELECTION-SCREEN END OF BLOCK bk2.
SELECTION-SCREEN SKIP 2.

SELECTION-SCREEN PUSHBUTTON 3(17) but1 USER-COMMAND fc1 MODIF ID pb1 .

SELECTION-SCREEN PUSHBUTTON 22(6) but2 USER-COMMAND fc2 MODIF ID pb2.
SELECTION-SCREEN SKIP 1.

SELECTION-SCREEN PUSHBUTTON /3(17) but3 USER-COMMAND fc3 MODIF ID pb3.

*--------------------------------------------------------------------*
* INITIALIZATION                                                     *
*--------------------------------------------------------------------*

INITIALIZATION.

  but1 = 'Get Material Data'.
  but2 = 'Clear'.
  but3 = 'Exit'.

  PERFORM invisible_block2.

*--------------------------------------------------------------------*
* STRUCTURE AND DATA DEFINITION                                      *
*--------------------------------------------------------------------*

  TYPES: BEGIN OF ty_mat,

           matnr TYPE mara-matnr,
           mtart TYPE mara-mtart,
           mbrsh TYPE mara-mbrsh,
           matkl TYPE mara-matkl,

         END OF ty_mat.

  DATA: wa_mat TYPE ty_mat.

*--------------------------------------------------------------------*
* AT SELECTION-SCREEN                                                *
*--------------------------------------------------------------------*

AT SELECTION-SCREEN.

  CASE sy-ucomm.

      "pushbutton get material data
    WHEN 'FC1'.

      IF p_matnr IS INITIAL.

        MESSAGE 'Please, enter a material number.' TYPE 'I'.

      ELSE.

        PERFORM get_material_data.

        IF sy-subrc EQ 0.

          MESSAGE 'Material Information Found!!' TYPE 'I' DISPLAY LIKE 'S'.

          p_mtart = wa_mat-mtart.
          p_mbrsh = wa_mat-mbrsh.
          p_matkl = wa_mat-matkl.

        ELSE.

          MESSAGE 'This material does not exist...' TYPE 'I' DISPLAY LIKE 'E'.

          CLEAR: p_matnr.

        ENDIF.

      ENDIF.

      "pushbutton clear
    WHEN 'FC2'.
      CLEAR: p_matnr,
             p_mtart,
             p_mbrsh,
             p_matkl.

      "pushbutton exit
    WHEN 'FC3'.
      LEAVE PROGRAM.

    WHEN OTHERS.
      MESSAGE 'Please, select a button!' TYPE 'I' DISPLAY LIKE 'W'.

  ENDCASE.


*--------------------------------------------------------------------*
* AT SELECTION-SCREEN OUTPUT                                         *
*--------------------------------------------------------------------*

AT SELECTION-SCREEN OUTPUT.

  IF p_matnr IS NOT INITIAL.

    PERFORM invisible_block2.

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

ENDFORM.

FORM invisible_block2.

  LOOP AT SCREEN.

    IF screen-group1 = 'ID2'.

      screen-invisible = 1.   "makes invisible
      screen-input = 0.       "disable input
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM visible_block2.

  LOOP AT SCREEN.

    IF screen-group1 = 'ID2'.

      screen-invisible = 0.
      screen-input = 0.
      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.

*--------------------------------------------------------------------*
* F1 HELP REQUEST                                                    *
*--------------------------------------------------------------------*

AT SELECTION-SCREEN ON HELP-REQUEST FOR p_matnr.  "F1 key

  CALL FUNCTION 'POPUP_TO_INFORM'
    EXPORTING
      titel = 'HOW TO USE THIS PROGRAM'
      txt1  = '1) Insert the material number'
      txt2  = '2) Press the "GET MATERIAL DATA" button.'.