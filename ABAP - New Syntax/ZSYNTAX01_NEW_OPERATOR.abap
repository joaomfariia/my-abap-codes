*&---------------------------------------------------------------------*
*& Report ZSYNTAX01_NEW_OPERATOR
*&---------------------------------------------------------------------*
*& New Operator
*&---------------------------------------------------------------------*
REPORT zsyntax01_new_operator.

CLASS lcl_animal DEFINITION.

  PUBLIC SECTION.

    DATA: name TYPE char10,
          race TYPE char10.

    METHODS: constructor IMPORTING im_name TYPE char10
                                   im_race TYPE char10.

    METHODS: eat.

ENDCLASS.

CLASS lcl_animal IMPLEMENTATION.

  METHOD constructor.
    me->name = im_name.
    me->race = im_race.
  ENDMETHOD.

  METHOD eat.
    WRITE:/ |The { me->race } { me->name } is eating!|.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

*  " Instantiating the class (alias) -> NO MEMORY ALLOCATED!
*  DATA: animal_1 TYPE REF TO lcl_animal.
*
*  " Creating the object -> MEMORY ALLOCATED!
*  CREATE OBJECT animal_1.

  DATA(animal_1) = NEW lcl_animal( im_name = 'Josh' im_race = 'Dog' ).
  DATA(animal_2) = NEW lcl_animal( im_name = 'Lina' im_race = 'Cat' ).

  animal_1->eat(  ).
  animal_2->eat(  ).