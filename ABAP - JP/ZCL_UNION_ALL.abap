CLASS zcl_union_all DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_union_all IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT FROM /DMO/I_Carrier
        FIELDS 'Airline' AS Type, AirlineID AS Id, Name
        WHERE CurrencyCode = 'GBP'

    UNION ALL

    SELECT FROM /DMO/I_Airport
        FIELDS 'Airport' AS Type, AirportID AS Id, Name
        WHERE city = 'London'
    INTO TABLE @DATA(lt_union).

    out->write( lt_union ).
  ENDMETHOD.

ENDCLASS.