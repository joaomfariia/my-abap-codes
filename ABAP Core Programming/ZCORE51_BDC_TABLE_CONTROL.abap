REPORT zcore51_bdc_table_control
       NO STANDARD PAGE HEADING LINE-SIZE 255.

* Include bdcrecx1_s:
* The call transaction using is called WITH AUTHORITY-CHECK!
* If you have own auth.-checks you can use include bdcrecx1 instead.
INCLUDE bdcrecx1_s.

PARAMETERS: dataset(132) LOWER CASE.
***    DO NOT CHANGE - the generated data section - DO NOT CHANGE    ***
*
*   If it is nessesary to change the data section use the rules:
*   1.) Each definition of a field exists of two lines
*   2.) The first line shows exactly the comment
*       '* data element: ' followed with the data element
*       which describes the field.
*       If you don't have a data element use the
*       comment without a data element name
*   3.) The second line shows the fieldname of the
*       structure, the fieldname must consist of
*       a fieldname and optional the character '_' and
*       three numbers and the field length in brackets
*   4.) Each field must be type C.
*
*** Generated data section with specific formatting - DO NOT CHANGE  ***
DATA: BEGIN OF record,
* data element: BU_LOCATOR_DIALOG_SEARCH_TYPE
        search_type_001(014),
* data element: BU_LOCATOR_DIALOG_SEARCH_ID
        search_id_002(002),
* data element: BU_PARTNER
        partner_number_003(016),
* data element: BU_MAXSEL
        maxhit_004(004),
* data element: BU_ROLE_SCREEN
        partner_role_005(007),
* data element: BU_TIMEDEP_SCREEN
        partner_timedep_006(007),
* data element: BU_NAMEOR1
        name_org1_007(040),
* data element: LAND1
        country_008(003),
* data element: REGIO
        region_009(003),
* data element: BU_ROLE_SCREEN
        partner_role_010(007),
* data element: BU_TIMEDEP_SCREEN
        partner_timedep_011(007),
* data element: BU_NAMEOR1
        name_org1_012(040),
* data element: LAND1
        country_013(003),
* data element: REGIO
        region_014(003),
* data element: AD_TZONE
        time_zone_015(006),
* data element: AD_TXJCD
        taxjurcode_016(015),
* data element: BU_ADDR_VALID_FROM_STR
        addr_valid_from_017(010),
* data element: BU_ADDR_VALID_TO_STR
        addr_valid_to_018(010),
      END OF record.

*** End generated data section ***

**********************************************************************
* BEGIN OF CUSTOM CHANGES
**********************************************************************

TYPES: BEGIN OF ty_legacy,

         string TYPE string,

       END OF ty_legacy.

DATA: it_legacy TYPE TABLE OF ty_legacy,
      wa_legacy TYPE ty_legacy.

TYPES: BEGIN OF ty_bp,

         name_org1 TYPE but000-name_org1,
         country   TYPE addr1_data-country,
         region    TYPE addr1_data-region,

       END OF ty_bp.

DATA: it_bp TYPE TABLE OF ty_bp,
      wa_bp TYPE ty_bp.

**********************************************************************
* END OF CUSTOM CHANGES
**********************************************************************

START-OF-SELECTION.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename = 'C:\Users\joaof\Documents\BP.txt'
    TABLES
      data_tab = it_legacy.

  IF it_legacy IS NOT INITIAL.

    LOOP AT it_legacy INTO wa_legacy.

      CLEAR wa_bp.
      SPLIT wa_legacy-string AT ',' INTO wa_bp-name_org1
                                         wa_bp-country
                                         wa_bp-region.
      APPEND wa_bp TO it_bp.

    ENDLOOP.

  ENDIF.

**  PERFORM open_dataset USING dataset.
  PERFORM open_group.

**  DO.

  IF it_bp IS NOT INITIAL.

    LOOP AT it_bp INTO wa_bp.

**    READ DATASET dataset INTO record.
**    IF sy-subrc <> 0. EXIT. ENDIF.

      PERFORM bdc_dynpro      USING 'SAPLBUS_LOCATOR' '3000'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=SCREEN_1000_CRE_ORGA'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'BUS_LOCA_SRCH01-SEARCH_TYPE'.
      PERFORM bdc_field       USING 'BUS_LOCA_SRCH01-SEARCH_TYPE'
                                    record-search_type_001.
      PERFORM bdc_field       USING 'BUS_LOCA_SRCH01-SEARCH_ID'
                                    record-search_id_002.
      PERFORM bdc_field       USING 'BUS_JOEL_SEARCH-PARTNER_NUMBER'
                                    record-partner_number_003.
      PERFORM bdc_field       USING 'BUS_LOCA_SRCH01-MAXHIT'
                                    record-maxhit_004.

      PERFORM bdc_dynpro      USING 'SAPLBUS_LOCATOR' '3000'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=BUS_MAIN_ENTER'.
      PERFORM bdc_field       USING 'BUS_JOEL_MAIN-PARTNER_ROLE'
                                    record-partner_role_005.
      PERFORM bdc_field       USING 'BUS_JOEL_MAIN-PARTNER_TIMEDEP'
                                    record-partner_timedep_006.
      PERFORM bdc_field       USING 'BUT000-NAME_ORG1' wa_bp-name_org1.
**                                  record-name_org1_007. " change this
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'ADDR1_DATA-REGION'.
      PERFORM bdc_field       USING 'ADDR1_DATA-COUNTRY' wa_bp-country.
**                                  record-country_008. " change this
      PERFORM bdc_field       USING 'ADDR1_DATA-REGION' wa_bp-region.
**                                  record-region_009. " change this

      PERFORM bdc_dynpro      USING 'SAPLBUS_LOCATOR' '3000'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=BUS_MAIN_SAVE'.
      PERFORM bdc_field       USING 'BUS_JOEL_MAIN-PARTNER_ROLE'
                                    record-partner_role_010.
      PERFORM bdc_field       USING 'BUS_JOEL_MAIN-PARTNER_TIMEDEP'
                                    record-partner_timedep_011.
      PERFORM bdc_field       USING 'BUT000-NAME_ORG1'
                                    record-name_org1_012.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'ADDR1_DATA-REGION'.
      PERFORM bdc_field       USING 'ADDR1_DATA-COUNTRY'
                                    record-country_013.  " ???
      PERFORM bdc_field       USING 'ADDR1_DATA-REGION'
                                    record-region_014. " ???
      PERFORM bdc_field       USING 'ADDR1_DATA-TIME_ZONE'
                                    record-time_zone_015. " after???
      PERFORM bdc_field       USING 'ADDR1_DATA-TAXJURCODE'
                                    record-taxjurcode_016. " after???
      PERFORM bdc_field       USING 'BUS000FLDS-ADDR_VALID_FROM'
                                    record-addr_valid_from_017.
      PERFORM bdc_field       USING 'BUS000FLDS-ADDR_VALID_TO'
                                    record-addr_valid_to_018.
      PERFORM bdc_transaction USING 'BP'.

    ENDLOOP.

  ENDIF.

**  ENDDO.

  PERFORM close_group.
**  PERFORM close_dataset USING dataset.