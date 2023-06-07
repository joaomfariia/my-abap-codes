*&---------------------------------------------------------------------*
*& Report ZSYNTAX13_COND_SWITCH
*&---------------------------------------------------------------------*
*& Cond & Switch Operators
*&---------------------------------------------------------------------*
REPORT zsyntax13_cond_switch.

WRITE:/ |COND OPERATOR|.
DO 3 TIMES.
  " Single condition only!
  DATA(lv_cond) = COND string( WHEN sy-index EQ 1 THEN 'Index value is 1!'
                               WHEN sy-index EQ 2 THEN 'Index value is 2!'
                               ELSE 'Greater than 2!' ).

  WRITE:/ lv_cond.
ENDDO.

SKIP.

WRITE:/ |SWITCH OPERATOR|.
DO 4 TIMES.
  " Multiple condition
  DATA(lv_switch) = SWITCH string( sy-index WHEN 1 OR 4 THEN 'Index value is 1 or 4!'
                                            WHEN 2 THEN 'Index value is 2!'
                                            ELSE 'Index greater than 2' ).

  WRITE:/ lv_switch.
ENDDO.