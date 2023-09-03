CLASS zjp_01_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun . " executes an ABAP program without SAP GUI
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZJP_01_HELLO_WORLD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'Hello, World!' ).
  ENDMETHOD.
ENDCLASS.