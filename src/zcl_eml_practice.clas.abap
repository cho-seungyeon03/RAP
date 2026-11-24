CLASS zcl_eml_practice DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EML_PRACTICE IMPLEMENTATION.


method if_oo_adt_classrun~main.

** update 구문
*
*MODIFY ENTITIES OF ZCHO_M_TRAVEL_I
*ENTITY ZCHO_M_TRAVEL_I
*UPDATE FIELDS ( BEGINDATE ENDDATE )
*WITH VALUE #( ( %KEY-TravelId = '00000001'
*                %DATA-BeginDate = '20261105'
*                %DATA-EndDate   = '20261231') )
*ENTITY zcho_m_travel_i
*CREATE FROM VALUE #( ( %CID = 'CID' ) )
*
*FAILED DATA(LT_FAILED)
*MAPPED DATA(LT_MAPPED)
*REPORTED DATA(LT_REPORTED).
*
*IF lt_failed IS NOT INITIAL.
*    OUT->write( 'ERROR' ).
*ELSE.
*    OUT->WRITE( LT_MAPPED ).
*ENDIF.

*MODIFY ENTITY ZCHO_M_TRAVEL_I
*UPDATE FIELDS ( AgencyId CustomerId )
*WITH VALUE #( ( %KEY-TravelId    = '00000001'
*                %DATA-AgencyId   = '070010'
*                %DATA-CustomerId = '000010' ) )
*FAILED DATA(LT_FAILED)
*MAPPED DATA(LT_MAPPED)
*REPORTED DATA(LT_REPORTED).
*
*IF LT_FAILED IS NOT INITIAL.
*    OUT->write( LT_MAPPED ).
*ELSE.
*   OUT->write( lt_reported ).
*ENDIF.



* delete 구문

*MODIFY entity zcho_m_travel_i
*DELETE FROM VALUE #( ( %key-TravelId = '00004480' ) )
*FAILED data(lt_failed)
*MAPPED data(lt_mapped)
*REPORTED data(lt_reported).
*
*if lt_failed is NOT INITIAL.
*    out->write( 'ERROR' ).
*else.
*    COMMIT ENTITIES.
*    OUT->write( LT_MAPPED ).
*endif.


* create 구문

*MODIFY entity zcho_m_travel_i
*CREATE from value #( ( %cid = 'CID1' "임시 키 역할. 값을 넣어야함
*                       %data-BeginDate = '20261104' "KEY 이외의 필드 %DATA에 값을 넣어주기
*                       %data-EndDate   = '20261231'
*                       %control-BeginDate = '01'
*                       %control-EndDate   = '01' )
**                       ( %cid = 'CID2'
**                       %data-BeginDate = '20261104'
**                       %data-EndDate   = '20261231'
**                       %control-BeginDate = '01'     "%CONTROL은 저장할 필드에 01을 넣어줘야함
**                       %control-EndDate   = '01' )
*                     )
*
* CREATE BY \_BOOKING "하위 BOOKING 정보도 TRAVEL 정보와 동시에 생성 가능
*        FROM VALUE #( ( %CID_REF = 'CID_T1'
*                        %TARGET  = VALUE #( ( %CID = 'CID_B1'
*                                              %DATA-BookingDate = '20261104'
*                                              %CONTROL-BookingDate = '01'  ) ) ) )
*
*FAILED data(lt_failed)
*MAPPED data(lt_mapped)
*REPORTED data(lt_reported).
*
*if lt_failed is not INITIAL.
*    out->write(  'ERROR' ).
*else.
*    COMMIT ENTITIES.
*    OUT->WRITE(  LT_MAPPED ).
*endif.



* read 구문

*READ ENTITIES OF zcho_m_travel_i
*
*entity zcho_m_travel_i
*all FIELDS
*WITH VALUE #( ( travelid = '00000005' ) )
*RESULT data(lt_result)
*
*ENTITY zcho_m_booking_i
*all fields
*with value #( ( TravelId = '00000005'
*                BookingId  = '0001') )
*RESULT DATA(lt_booking)
*
*FAILED DATA(lt_failed)
*REPORTED DATA(lt_reported).
*
*IF lt_result IS INITIAL.
*  out->write( 'NO DATA' ).
*ELSE.
*  out->write( lt_result ).
*  out->write( lt_booking ).
*ENDIF.


*READ entity zcho_m_travel_i
*FIELDS ( TravelId AgencyId BeginDate EndDate BookingFee TotalPrice )
**all fields
*with VALUE #( ( travelid = '00000005' ) )
*RESULT data(lt_result)
*FAILED data(lt_failed)
*REPORTED data(lt_reported).
*
*if lt_result is INITIAL.
*out->write( 'NO DATA' ).
*else.
*out->write( lt_result ).
*ENDIF.

ENDMETHOD.
ENDCLASS.
