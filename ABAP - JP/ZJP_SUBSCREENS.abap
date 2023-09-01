*&---------------------------------------------------------------------*
*& Report ZJP_SUBSCREENS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zjp_subscreens.

TABLES: usr02,       "Logon data
        sscrfields.  "FIELDS ON SELECTION SCREENS
*---------------------------------------------------------------
* SUBSCREEN 1
*---------------------------------------------------------------
SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-010.
    SELECT-OPTIONS: username FOR usr02-bname.
  SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN END OF SCREEN 100.

*---------------------------------------------------------------
* SUBSCREEN 2
*---------------------------------------------------------------
SELECTION-SCREEN BEGIN OF SCREEN 200 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-020.
    SELECT-OPTIONS: lastlogi FOR usr02-trdat.
  SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF SCREEN 200.

*---------------------------------------------------------------
* SUBSCREEN 3
*---------------------------------------------------------------
SELECTION-SCREEN BEGIN OF SCREEN 300 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-030.
    SELECT-OPTIONS: classtyp FOR usr02-class.
  SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN END OF SCREEN 300.

* STANDARD SELECTION SCREEN FOR SCROLLING LEFT AND RIGHT
SELECTION-SCREEN:
FUNCTION KEY 1,
FUNCTION KEY 2.

SELECTION-SCREEN: BEGIN OF TABBED BLOCK sub FOR 15 LINES,
END OF BLOCK sub.

START-OF-SELECTION.
  SELECT * FROM usr02 WHERE bname IN username
                        AND erdat IN lastlogi
                        AND class IN classtyp.
    WRITE: / 'User ', usr02-bname,
             'Last Login Date ', usr02-trdat,
             'Last Login Time ', usr02-ltime,
             'CLASS ', usr02-class.
  ENDSELECT.

END-OF-SELECTION.

INITIALIZATION.
* SCREEN ICON LEFT AND RIGHT
  sscrfields-functxt_01 = '@0D@'.
  sscrfields-functxt_02 = '@0E@'.
  sub-prog = sy-repid.
  sub-dynnr = 100.

AT SELECTION-SCREEN.
  CASE sy-dynnr.

    WHEN 100.
      IF sscrfields-ucomm = 'FC01'.
        sub-dynnr = 300.
      ELSEIF sscrfields-ucomm = 'FC02'.
        sub-dynnr = 200.
      ENDIF.

    WHEN 200.
      IF sscrfields-ucomm = 'FC01'.
        sub-dynnr = 100.
      ELSEIF sscrfields-ucomm = 'FC02'.
        sub-dynnr = 300.
      ENDIF.

    WHEN 300.
      IF sscrfields-ucomm = 'FC01'.
        sub-dynnr = 200.
      ELSEIF sscrfields-ucomm = 'FC02'.
        sub-dynnr = 100.
      ENDIF.
  ENDCASE.