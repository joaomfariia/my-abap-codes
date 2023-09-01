*&---------------------------------------------------------------------*
*& Report ZOO_17_ABSTRACT_CLASS
*&---------------------------------------------------------------------*
*& Abstract Class and Method
*&---------------------------------------------------------------------*
REPORT zoo_17_abstract_class.

CLASS lcl_abstract DEFINITION ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      shopping,
      display,
      payment ABSTRACT.

*    CLASS-METHODS:
*      payment_2 ABSTRACT. "Static methods cannot be redefined, so it may not be declared as abstract

  PROTECTED SECTION.
    DATA: order_no       TYPE i,
          attendant      TYPE string.

  PRIVATE SECTION.
*    METHODS:
*      private_abstract ABSTRACT. "Private methods cannot be redefined, so it may not be declared as abstract


ENDCLASS.

CLASS lcl_abstract IMPLEMENTATION.

  METHOD shopping.
    order_no = 25.
    attendant = `João`.
  ENDMETHOD.

  METHOD display.
    WRITE:/ |Table number: { order_no }|,
          / |Attendant: { attendant }|.
  ENDMETHOD.

*  METHOD payment.                      "Since its an abstract method, it must be implemented as a redefinition
*    WRITE:/ |Payment: { order_no }|,
*            |Attendant { attendant }|.
*  ENDMETHOD.

ENDCLASS.

CLASS lcl_abstract_inheritance DEFINITION INHERITING FROM lcl_abstract.

  PUBLIC SECTION.
    METHODS:
      payment REDEFINITION, "Needs to be redefined! (inheriting from abstract class)
      display REDEFINITION,
      hello .

*  PROTECTED SECTION.        "When redefing a method, we cannot change its visibility!
*    METHODS:
*      payment REDEFINITION.

  PROTECTED SECTION.
    DATA: debit_card_no    TYPE i,
          transaction_date TYPE d,
          bank_name        TYPE string,
          amount           TYPE i.

ENDCLASS.

CLASS lcl_abstract_inheritance IMPLEMENTATION.

  METHOD payment.
    debit_card_no = 12345678.
    transaction_date = sy-datum.
    bank_name = `JP BANK`.
    amount = 4899.
  ENDMETHOD.

  METHOD display.
    WRITE:/ |Super class (abstract) display method:|.
    super->display( ).
    SKIP 1.
    WRITE:/ |Child class (inheritance) display method:|.
    WRITE:/ |Table number: { order_no }|,
          / |Attendant: { attendant }|,
          / |Debit card number: { debit_card_no }|,
          / |Transaction date: { transaction_date }|,
          / |Bank name: { bank_name }|,
          / |Amount: { amount }|.
  ENDMETHOD.

  METHOD hello.
    WRITE:/ |This is a child class exclusive method!|.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_abstract             TYPE REF TO lcl_abstract,
        go_abstract_inheritance TYPE REF TO lcl_abstract_inheritance.

*  go_abstract = NEW #( ).             "Abstract classes cannot be instatiated
  go_abstract_inheritance = NEW #( ).
  go_abstract_inheritance->shopping( ).
  go_abstract_inheritance->payment( ).
  go_abstract_inheritance->display( ).
  ULINE.
  go_abstract = go_abstract_inheritance. "Narrow casting (inherited -> super)
  go_abstract->shopping( ).
  go_abstract->payment( ).
  go_abstract->display( ).
  ULINE.
*  go_abstract->hello( ).               "Hello method cannot be called from the super class
  CALL METHOD go_abstract->('HELLO').   "Dynamic calling a child method from the super class