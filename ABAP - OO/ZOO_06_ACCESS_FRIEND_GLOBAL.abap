*&---------------------------------------------------------------------*
*& Report ZOO_06_ACCESS_FRIEND_GLOBAL
*&---------------------------------------------------------------------*
*& Accessing Components of a Global Friend Class
*&---------------------------------------------------------------------*
REPORT zoo_06_access_friend_global.

DATA lo_obj_parent TYPE REF TO zcl_02_parent_class.

lo_obj_parent = NEW #( ).

lo_obj_parent->method01( ).