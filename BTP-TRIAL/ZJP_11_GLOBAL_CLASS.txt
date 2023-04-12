CLASS zjp_11_global_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZJP_11_GLOBAL_CLASS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: connection  TYPE REF TO lcl_connections,
          connection2 TYPE REF TO lcl_connections,
          connections TYPE TABLE OF REF TO lcl_connections.

* Instanciating the class lcl_connections
    connection = NEW #(  ).

* Static atribute declaration
    lcl_connections=>conn_counter = 123.

* Declaring the instance atributes
    connection->carrier_id = 'ABC'.
    connection->connection_id = '100'.

* Connection2 now points to connection!
    connection2 = connection.

    connection2->carrier_id = 'XYZ'.
    connection2->connection_id = '200'.

* Appending object to a table
    APPEND connection TO connections.

    CLEAR connection.

    connection = NEW #(  ).

    connection->carrier_id = 'SAP'.
    connection->connection_id = '999'.
    APPEND connection TO connections.

  ENDMETHOD.
ENDCLASS.