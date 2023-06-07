*&---------------------------------------------------------------------*
*& Report ZSYNTAX07_SELECT_CASE
*&---------------------------------------------------------------------*
*& Select + Case Statements
*&---------------------------------------------------------------------*
REPORT zsyntax07_select_case.

*==================================================================
* Old Approach
*==================================================================
*TYPES: BEGIN OF ty_kna1,
*         kunnr TYPE kna1-kunnr,
*         land1 TYPE kna1-land1,
*         name1 TYPE kna1-name1,
*       END OF ty_kna1.
*
*DATA: it_kna1 TYPE TABLE OF ty_kna1,
*      wa_kna1 TYPE ty_kna1.
*
*SELECT kunnr,
*       land1,
*       name1
*FROM kna1
*INTO TABLE @it_kna1.

*==================================================================
* New Syntax
*==================================================================
SELECT kunnr AS Customer_Number,
       land1 AS Country,

       CASE land1
       WHEN 'BR'
       THEN 'Brazil' END AS Full_Name,

       name1 AS Customer_Name
FROM kna1
INTO TABLE @DATA(it_kna1).

cl_demo_output=>display( it_kna1 ).