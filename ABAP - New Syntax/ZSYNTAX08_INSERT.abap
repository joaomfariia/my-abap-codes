*&---------------------------------------------------------------------*
*& Report ZSYNTAX08_INSERT
*&---------------------------------------------------------------------*
*& Insert & Value Statement
*&---------------------------------------------------------------------*
REPORT zsyntax08_insert.

*==================================================================
* WAY 1
*==================================================================
DATA: wa_emp TYPE zemployee.

wa_emp-zempid = '8'.
wa_emp-zempname = 'NAME8'.
wa_emp-zemprole = 'ROLE8'.

INSERT INTO zemployee VALUES wa_emp.

*==================================================================
* WAY 2 - ABAP 7.4
*==================================================================
DATA(wa_emp2) = VALUE zemployee( zempid = '9'
                                 zempname = 'NAME9'
                                 zemprole = 'ROLE9' ).

INSERT INTO zemployee VALUES wa_emp2.

*==================================================================
* WAY 3 - ABAP 7.5
*==================================================================
INSERT INTO zemployee VALUES @( VALUE #( zempid = '10'
                                         zempname = 'NAME10'
                                         zemprole = 'ROLE10' ) ).

*==================================================================
* WAY 4 - From internal table
*==================================================================
DATA it_emp TYPE TABLE OF zemployee.

it_emp = VALUE #( ( zempid = '11'             " line 1
                    zempname = 'NAME11'
                    zemprole = 'ROLE11' )

                  ( zempid = '12'             " line 2
                    zempname = 'NAME12'
                    zemprole = 'ROLE12' )

                  ( zempid = '13'             " line 3
                    zempname = 'NAME13'
                    zemprole = 'ROLE13' ) ).

INSERT zemployee FROM TABLE it_emp.

*==================================================================
* WAY 5 - Directly from INSERT statement
*==================================================================
INSERT zemployee FROM TABLE @( VALUE #( ( zempid = '14'             " line 1
                                          zempname = 'NAME14'
                                          zemprole = 'ROLE14' )

                                        ( zempid = '15'             " line 2
                                          zempname = 'NAME15'
                                          zemprole = 'ROLE15' )

                                        ( zempid = '16'             " line 3
                                          zempname = 'NAME16'
                                          zemprole = 'ROLE16' ) ) ).