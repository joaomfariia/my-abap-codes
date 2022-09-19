*&---------------------------------------------------------------------*
*& Report ZCORE13_TABBED_SUBSCREENS
*&---------------------------------------------------------------------*
*& Tabbed Block and Subscreens
*&---------------------------------------------------------------------*
REPORT zcore13_tabbed_subscreens.


*-------------------------------------------
*	Tabbed Block Syntax
*-------------------------------------------

SELECTION-SCREEN BEGIN OF TABBED BLOCK tb1 FOR 5 LINES.

  SELECTION-SCREEN TAB (15) t1 USER-COMMAND fc1.
  SELECTION-SCREEN TAB (15) t2 USER-COMMAND fc2.

SELECTION-SCREEN END OF BLOCK tb1.

*-------------------------------------------
*	Subscreens Syntax
*-------------------------------------------

SELECTION-SCREEN BEGIN OF SCREEN 100 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 8(30) lb1.   " label 1

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF SCREEN 100.


SELECTION-SCREEN BEGIN OF SCREEN 200 AS SUBSCREEN.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 8(30) lb2.   " label 2

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF SCREEN 200.

*-------------------------------------------
*	Naming Tabs, Tabbed Block And Subscreen
*-------------------------------------------

INITIALIZATION.

  t1 = 'Tab 1'.
  t2 = 'Tab 2'.
  tb1-activetab = 'FC2'.          " activetab is a property
  tb1-dynnr = '200'.              " following screen number
*  tb1-prog = 'zcore14_internal_table_part01'.  OR
  tb1-prog = sy-repid.            "sys variable for current program
  lb1 = 'Welcome to Subscreen 1'.
  lb2 = 'Welcome to Subscreen 2'.

AT SELECTION-SCREEN.

  CASE sy-ucomm.

    WHEN 'FC1'.
      tb1-activetab = 'FC1'.
      tb1-dynnr = '100'.
      tb1-prog = sy-repid.

    WHEN 'FC2'.
      tb1-activetab = 'FC2'.
      tb1-dynnr = '200'.
      tb1-prog = sy-repid.

   ENDCASE.