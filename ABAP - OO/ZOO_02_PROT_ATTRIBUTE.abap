*&---------------------------------------------------------------------*
*& Report ZOO_LOCAL_CLASS_PROT_ATTRIBUTE
*&---------------------------------------------------------------------*
*& Methods in Pub. Sec. & Attributes in Prot. Sec.
*&---------------------------------------------------------------------*
REPORT zoo_02_prot_attribute.

CLASS lcl_employee DEFINITION.

  PUBLIC SECTION.
    METHODS:
      get_employees,

      get_role
        IMPORTING empname TYPE c
                  emprole TYPE c,

      get_vacation.

  PROTECTED SECTION.
    DATA: empid    TYPE i,
          empname  TYPE c LENGTH 20,
          emprole  TYPE c LENGTH 20,
          vacation TYPE abap_bool.

    DATA: it_emp TYPE STANDARD TABLE OF zemployee.

ENDCLASS.

CLASS lcl_employee IMPLEMENTATION.

  METHOD get_employees.
    SELECT * FROM zemployee INTO TABLE @it_emp.

*    IF sy-subrc EQ 0.
*      cl_demo_output=>display( it_emp ).
*    ELSE.
*      MESSAGE |No employees data found.| TYPE 'E'.
*    ENDIF.

  ENDMETHOD.

  METHOD get_role.
    WRITE / |The employee { empname } works as { emprole }.|.
  ENDMETHOD.

  METHOD get_vacation.

    IF it_emp IS NOT INITIAL.

      LOOP AT it_emp INTO DATA(wa_emp).

        me->empname = wa_emp-zempname.
        me->empid = wa_emp-zempid.

        IF wa_emp-zempid MOD 2 EQ 0.
          WRITE / |The employee { me->empname } with ID { me->empid } is in vacation!!.|.
          SKIP.

        ELSE.
          WRITE / |The employee { me->empname } with ID { me->empid } is not in vacation...|.

        ENDIF.
      ENDLOOP.

    ELSE.
      MESSAGE |Employees table is empty...| TYPE 'E'.

    ENDIF.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: lo_emp TYPE REF TO lcl_employee. " Reference variable to class

  lo_emp = NEW #( ). " Instantiation of object

  lo_emp->get_employees( ).
  lo_emp->get_vacation( ).
  lo_emp->get_role( EXPORTING empname = `João`
                              emprole = `Developer` ).