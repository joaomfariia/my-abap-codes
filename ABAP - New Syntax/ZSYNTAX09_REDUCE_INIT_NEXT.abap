*&---------------------------------------------------------------------*
*& Report ZSYNTAX09_REDUCE_INIT_NEXT
*&---------------------------------------------------------------------*
*& Reduce Operator & Init, Next, For, Where Clauses
*&---------------------------------------------------------------------*
REPORT zsyntax09_reduce_init_next.

SELECT vbeln,
       matnr,
       netwr
FROM vbap
INTO TABLE @DATA(it_vbap) UP TO 20 ROWS.

cl_demo_output=>display( it_vbap ).

DATA(lv_count) = REDUCE i( INIT i = 0 FOR j IN it_vbap WHERE ( vbeln = '0000000003' )
                           NEXT i = i + 1 ).

cl_demo_output=>display( lv_count ).