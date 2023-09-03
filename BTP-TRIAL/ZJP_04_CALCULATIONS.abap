CLASS zjp_04_calculations DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZJP_04_CALCULATIONS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


* Declarations
**********************************************************************

    " comment/uncomment these line for different result types
    TYPES t_result TYPE p LENGTH 8 DECIMALS 2.
*    TYPES t_result TYPE p LENGTH 8 DECIMALS 0.
*    TYPES t_result TYPE i.

    DATA result TYPE t_result.

* Calculations
**********************************************************************
    " comment/uncomment these lines for different calculations

    result = 2 + 3.
    out->write( result ).

    result = 2 - 3.
    out->write( result ).

    result = 2 * 3.
    out->write( result ).

    result = 2 / 3.
    out->write( result ).
*
    result = sqrt( 2 ).
    out->write( result ).

    result = ipow( base = 2 exp = 3 ).
    out->write( result ).

    result = ( 8 * 7 - 6 ) / ( 5 + 4 ).
    out->write( result ).

    result = 8 * 7 - 6 / 5 + 4.
    out->write( result ).

* Output
**********************************************************************

    out->write( result ).

  ENDMETHOD.
ENDCLASS.