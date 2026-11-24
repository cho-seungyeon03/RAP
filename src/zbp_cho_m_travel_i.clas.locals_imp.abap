CLASS lsc_zcho_m_travel_i DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zcho_m_travel_i IMPLEMENTATION.

  METHOD save_modified.

    data : lt_travel_log TYPE table of zcho_travel_l,
           lt_booking_log type table of zcho_booking_l.

*- create
    if create-zcho_m_travel_i is not INITIAL.

    loop AT create-zcho_m_travel_i into data(ls_create_travel).
        APPEND INITIAL LINE TO lt_travel_log ASSIGNING FIELD-SYMBOL(<fs_travel_log>).
        <fs_travel_log>-operation    = 'CREATE'.
        <FS_TRAVEL_LOG>-TRAVEL_ID    = LS_CREATE_TRAVEL-TravelId.
       <FS_TRAVEL_LOG>-agency_id     = LS_CREATE_TRAVEL-AgencyId.
       <FS_TRAVEL_LOG>-customer_id   = LS_CREATE_TRAVEL-CustomerId.
       <FS_TRAVEL_LOG>-begin_date    = LS_CREATE_TRAVEL-BeginDate.
       <FS_TRAVEL_LOG>-end_date      = LS_CREATE_TRAVEL-EndDate.
       <FS_TRAVEL_LOG>-booking_fee   = LS_CREATE_TRAVEL-BookingFee.
       <FS_TRAVEL_LOG>-total_price   = LS_CREATE_TRAVEL-TotalPrice.
       <FS_TRAVEL_LOG>-currency_code = LS_CREATE_TRAVEL-CurrencyCode.
       <fs_travel_log>-description   = LS_CREATE_TRAVEL-Description.
       <FS_TRAVEL_LOG>-status        = LS_CREATE_TRAVEL-STATUS.
       <FS_TRAVEL_LOG>-createby      = cl_abap_context_info=>get_user_technical_name(  ).
       GET TIME STAMP FIELD <FS_TRAVEL_LOG>-createdat.
       TRY.
        <FS_TRAVEL_LOG>-LOG_ID = cl_system_uuid=>create_uuid_x16_static(  ).
       CATCH CX_UUID_ERROR.
       ENDTRY.
    ENDLOOP.

    endif.

    IF CREATE-zcho_m_booking_i IS NOT INITIAL.
        LOOP AT CREATE-zcho_m_booking_i INTO DATa(LS_CREATE_BOOKING).
           append INITIAL LINE TO lt_booking_log ASSIGNING FIELD-SYMBOL(<fs_booking_log>).
           <fs_booking_log>-operation     = 'CREATE'.
           <fs_booking_log>-travel_id     = ls_create_booking-TravelId.
           <fs_booking_log>-booking_id    = ls_create_booking-BookingId.
           <fs_booking_log>-booking_date  = ls_create_booking-BookingDate.
           <fs_booking_log>-customer_id   = ls_create_booking-CustomerId.
           <fs_booking_log>-carrier_id    = ls_create_booking-CarrierId.
           <fs_booking_log>-connection_id = ls_create_booking-ConnectionId.
           <fs_booking_log>-flight_date   = ls_create_booking-FlightDate.
           <fs_booking_log>-flight_price  = ls_create_booking-FlightPrice.
           <fs_booking_log>-currency_code = ls_create_booking-CurrencyCode.
           <fs_booking_log>-createby      = cl_abap_context_info=>get_user_technical_name(  ).
           GET TIME STAMP FIELD <fs_booking_log>-createdat.
           Try.
            <fs_booking_log>-log_id = cl_system_uuid=>create_uuid_x16_static(  ).
           CATCH cx_uuid_error.

           ENDTRY.
        ENDLOOP.
    ENDIF.

*- update

    if update-zcho_m_travel_i is not INITIAL.
       loop at update-zcho_m_travel_i into data(Ls_update_travel).
         append INITIAL LINE TO lt_travel_log ASSIGNING <fs_travel_log>.

         <fs_travel_log>-operation     = 'UPDATE'.
         <fs_travel_log>-travel_id     = ls_update_travel-TravelId.
         <fs_travel_log>-agency_id     = ls_update_travel-AgencyId.
         <fs_travel_log>-customer_id   = ls_update_travel-CustomerId.
         <fs_travel_log>-begin_date    = ls_update_travel-BeginDate.
         <fs_travel_log>-end_date      = ls_update_travel-EndDate.
         <fs_travel_log>-booking_fee   = ls_update_travel-BookingFee.
         <fs_travel_log>-total_price   = ls_update_travel-TotalPrice.
         <fs_travel_log>-currency_code = ls_update_travel-CurrencyCode.
         <fs_travel_log>-description   = ls_update_travel-Description.
         <fs_travel_log>-status        = ls_update_travel-status.
         <fs_travel_log>-createby      = cl_abap_context_info=>get_user_technical_name(  ).
         GET TIME STAMP FIELD <fs_travel_log>-createdat.
         try.
            <fs_travel_log>-log_id = cl_system_uuid=>create_uuid_x16_static(  ).

         CATCH cx_uuid_error.
         ENDTRY.
       ENDLOOP.
    endif.

    if update-zcho_m_booking_i is not INITIAL.
        loop at update-zcho_m_booking_i into data(ls_update_booking).
            APPEND INITIAL LINE TO lt_booking_log ASSIGNING <fs_booking_log>.
            <fs_booking_log>-operation    = 'UPDATE'.
            <fs_booking_log>-booking_id   = ls_update_booking-BookingId.
           <fs_booking_log>-booking_date  = ls_update_booking-BookingDate.
           <fs_booking_log>-customer_id   = ls_update_booking-CustomerId.
           <fs_booking_log>-carrier_id    = ls_update_booking-CarrierId.
           <fs_booking_log>-connection_id = ls_update_booking-ConnectionId.
           <fs_booking_log>-flight_date   = ls_update_booking-FlightDate.
           <fs_booking_log>-flight_price  = ls_update_booking-FlightPrice.
           <fs_booking_log>-currency_code = ls_update_booking-CurrencyCode.
           <fs_booking_log>-createby      = cl_abap_context_info=>get_user_technical_name(  ).
           GET TIME STAMP FIELD <fs_booking_log>-createdat.
           Try.
            <fs_booking_log>-log_id = cl_system_uuid=>create_uuid_x16_static(  ).
           CATCH cx_uuid_error.
           ENDTRY.
        ENDLOOP.
    ENDIF.

*- delete

  if delete-zcho_m_travel_i is NOT INITIAL.
     LOOP AT delete-zcho_m_travel_i into data(ls_delete_travel).
        APPEND INITIAL LINE TO lt_travel_log ASSIGNING <fs_travel_log>.
        <fs_travel_log>-operation = 'DELETE'.
        <fs_travel_log>-travel_id = ls_delete_travel-TravelId.
        <fs_travel_log>-createby = cl_abap_context_info=>get_user_technical_name(  ).
        get time STAMP FIELD <fs_travel_log>-createdat.
        try.
            <fs_travel_log>-log_id = cl_system_uuid=>create_uuid_x16_static(  ).
            CATCH cx_uuid_error.
        ENDTRY.
     endloop.
  endif.

  if delete-zcho_m_booking_i is not INITIAL.
    loop at delete-zcho_m_booking_i into data(ls_delete_booking).
     append INITIAL LINE TO lt_booking_log ASSIGNING <fs_booking_log>.
     <fs_booking_log>-operation = 'DELETE'.
     <fs_booking_log>-travel_id = ls_delete_booking-TravelId.
     <fs_booking_log>-booking_id = ls_delete_booking-BookingId.
     <fs_booking_log>-createby = cl_abap_context_info=>get_user_technical_name(  ).
     GET TIME STAMP FIELD <fs_booking_log>-createdat.
     try.
        <fs_booking_log>-log_id = cl_system_uuid=>create_uuid_x16_static(  ).
     CATCH cx_uuid_error.
     ENDTRY.

    endloop.
  ENDIF.

    if lt_travel_log is not INITIAL.
    modify zcho_travel_l FROM TABLE @lt_travel_log.
  endif.

  if lt_booking_log is not INITIAL.
    modify zcho_booking_l from table @lt_booking_log.
  endif.


*- UNMANAGED SAVE

  TYPES : ty_booking_create type /dmo/booking,
          ty_booking_update type /dmo/booking WITH INDICATORS control type abap_bool,
          ty_booking_delete type /dmo/booking.

   DATA : lt_booking_create type table of ty_booking_create,
          lt_booking_update type TABLE of ty_booking_update,
          lt_booking_delete type table of ty_booking_delete.

*- create

if create-zcho_m_booking_i is not INITIAL.
    loop at create-zcho_m_booking_i into ls_create_booking.
        append INITIAL LINE TO lt_booking_create ASSIGNING FIELD-SYMBOL(<fs_booking_create>).
        <fs_booking_create>-travel_id     = ls_create_booking-TravelId.
        <fs_booking_create>-booking_id    = ls_create_booking-BookingId.
        <fs_booking_create>-booking_date  = ls_create_booking-BookingDate.
        <fs_booking_create>-customer_id   = ls_create_booking-CustomerId.
        <fs_booking_create>-carrier_id    = ls_create_booking-CarrierId.
        <fs_booking_create>-connection_id = ls_create_booking-ConnectionId.
        <fs_booking_create>-flight_date   = ls_create_booking-FlightDate.
        <fs_booking_create>-flight_price  = ls_create_booking-FlightPrice.
        <fs_booking_create>-currency_code = ls_create_booking-CurrencyCode.

    endloop.
endif.

*- update

if update-zcho_m_booking_i is not INITIAL.
   LOOP at update-zcho_m_booking_i into ls_update_booking.
    append INITIAL LINE TO lt_booking_update ASSIGNING FIELD-SYMBOL(<fs_booking_update>).
    <fs_booking_update>-travel_id     = ls_update_booking-TravelId.
    <fs_booking_update>-booking_id    = ls_update_booking-BookingId.
    <fs_booking_update>-booking_date  = ls_update_booking-bookingdate.
    <fs_booking_update>-customer_id   = ls_update_booking-CustomerId.
    <fs_booking_update>-carrier_id    = ls_update_booking-CarrierId.
    <fs_booking_update>-connection_id = ls_update_booking-ConnectionId.
    <fs_booking_update>-flight_date   = ls_update_booking-FlightDate.
    <fs_booking_update>-flight_price  = ls_update_booking-FlightPrice.
    <fs_booking_update>-currency_code = ls_update_booking-CurrencyCode.


<fs_booking_update>-control-booking_date  = cond #( when ls_update_booking-%control-BookingDate  = '01' then 'X' else space ).
<fs_booking_update>-control-customer_id   = cond #( when ls_update_booking-%control-CustomerId   = '01' then 'X' else space ).
<fs_booking_update>-control-carrier_id    = cond #( when ls_update_booking-%control-CarrierId    = '01' then 'X' else space ).
<fs_booking_update>-control-connection_id = cond #( when ls_update_booking-%control-connectionid = '01' then 'X' else space ).
<fs_booking_update>-control-flight_date   = cond #( when ls_update_booking-%control-flightdate   = '01' then 'X' else space ).
<fs_booking_update>-control-flight_price  = cond #( when ls_update_booking-%control-flightprice  = '01' then 'X' else space ).
<fs_booking_update>-control-currency_code = cond #( when ls_update_booking-%control-currencycode = '01' then 'X' else space ).


   endloop.
endif.

*- delete
if delete-zcho_m_booking_i is not INITIAL.
    LOOP AT delete-zcho_m_booking_i into ls_delete_booking.
    APPEND INITIAL LINE TO lt_booking_delete ASSIGNING FIELD-SYMBOL(<fs_booking_delete>).
    <fs_booking_delete>-travel_id  = ls_delete_booking-TravelId.
    <fs_booking_delete>-booking_id = ls_delete_booking-BookingId.
   endloop.
endif.

if lt_booking_create is not INITIAL.
    modify /dmo/booking FROM TABLE @lt_booking_create.
endif.

if lt_booking_update is not INITIAL.
    update /dmo/booking FROM TABLE @lt_booking_update INDICATORS SET STRUCTURE control.
endif.

if lt_booking_delete is NOT INITIAL.
    delete /dmo/booking from table @lt_booking_delete.
endif.



  ENDMETHOD.

ENDCLASS.

CLASS lhc_zcho_m_booking_i DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateCustomer FOR VALIDATE ON SAVE
     importing keys FOR zcho_m_booking_i~validateCustomer.
    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      keys FOR zcho_m_booking_i~calculateTotalPrice.

ENDCLASS.

CLASS lhc_zcho_m_booking_i IMPLEMENTATION.

  METHOD validateCustomer.

  READ ENTITIES OF zcho_m_travel_i IN LOCAL MODE
  ENTITY ZCHO_M_TRAVEL_I BY \_booking
  ALL FIELDS WITH CORRESPONDING #( KEYS )
  RESULT DATA(LT_RESULT)
  FAILED DATA(LT_FAILED)
  REPORTED DATA(LT_REPORTED).

  IF LT_RESULT IS NOT INITIAL.
    SELECT A~CUSTOMER_ID
    FROM /DMO/CUSTOMER AS A  INNER JOIN @LT_RESULT AS B
                             ON A~customer_id = B~CustomerId
    ORDER BY A~CUSTOMER_ID
    INTO TABLE @DATA(LT_CUSTOMER).
  ENDIF.

  LOOP AT LT_RESULT INTO DATA(LS_RESULT).

  APPEND INITIAL LINE TO REPORTED-zcho_m_booking_i ASSIGNING FIELD-SYMBOL(<FS_REPORTED>).
  <FS_REPORTED>-%tky = LS_rESULT-%tky.
  <FS_REPORTED>-%state_area = 'VALIDATE_BOOKING_CUSTOMER'.

  IF LS_RESULT-CustomerId IS NOT INITIAL.

    READ TABLE LT_CUSTOMER INTO DATA(LS_CUSTOMER) WITH KEY CUSTOMER_ID = LS_RESULT-CustomerId BINARY SEARCH.
    IF SY-SUBRC <> 0.
        APPEND INITIAL LINE TO FAILED-zcho_m_booking_i ASSIGNING FIELD-SYMBOL(<FS_FAILED>).
        <FS_FAILED>-%tky = LS_rESULT-%tky.
       APPEND INITIAL LINE TO REPORTED-zcho_m_booking_i ASSIGNING <FS_REPORTED>.
       <FS_rEPORTED>-%tky = LS_rESULT-%tky.
       <FS_REPORTED>-%element-customerid = if_abap_behv=>mk-ON.
       <FS_REPORTED>-%PATH-zcho_m_travel_i-%tky = CORRESPONDING #( LS_RESULT-%tky ).
       <FS_REPORTED>-%state_area = 'VALIDATE_BOOKING_CUSTOMER'.
       <FS_REPORTED>-%MSG = new_message( severity = if_abap_behv_message=>severity-ERROR
                                         ID       = 'ZCHO_M'
                                         NUMBER   = '000'
                                         V1       = TEXT-M01 ).



    ENDIF.

  ENDIF.

  ENDLOOP.

  ENDMETHOD.

  METHOD calculateTotalPrice.

   modify ENTITIES OF zcho_m_travel_i in local mode
   entity zcho_m_travel_i
   execute recalTotPrice
   FROM CORRESPONDING #(  keys ).

*  READ ENTITIES OF zcho_m_travel_i IN LOCAL MODE
*  entity zcho_m_travel_i
*  ALL FIELDS with CORRESPONDING #( keys )
*  result data(lt_travel)
*
*  entity zcho_m_travel_i by \_booking
*  all FIELDS with CORRESPONDING #( keys )
*  result data(lt_booking).
*
*  loop at lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).
*
*    <fs_travel>-totalprice = <fs_travel>-bookingfee.
*
*    loop at lt_booking USING key entity into data(ls_booking) where travelid = <fs_travel>-travelid.
*        <fs_travel>-totalprice = <fs_travel>-totalprice + ls_booking-flightprice.
*    endloop.
*
*  endloop.
*
*
*  modify entities of zcho_m_travel_i in local mode
*  entity zcho_M_TRAVEL_I
*  UPDATE FIELDS ( TOTALPRICE )
*  WITH CORRESPONDING #( LT_TRAVEL )
*  FAILED DATA(LT_FAILED)
*  REPORTED DATA(LT_REPORTED).

  ENDMETHOD.

ENDCLASS.



CLASS lhc_zcho_m_travel_i DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zcho_m_travel_i RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zcho_m_travel_i RESULT result.

    METHODS Activate FOR MODIFY
       keys FOR ACTION zcho_m_travel_i~Activate.

    METHODS Discard FOR MODIFY
       keys FOR ACTION zcho_m_travel_i~Discard.

    METHODS Edit FOR MODIFY
       keys FOR ACTION zcho_m_travel_i~Edit.

    METHODS Resume FOR MODIFY
       keys FOR ACTION zcho_m_travel_i~Resume.
    METHODS validateCustomer FOR VALIDATE ON SAVE
      keys FOR zcho_m_travel_i~validateCustomer.
    METHODS validateAgency FOR VALIDATE ON SAVE
      keys FOR zcho_m_travel_i~validateAgency.
    METHODS setBooked FOR MODIFY
      keys FOR ACTION zcho_m_travel_i~setBooked RESULT result.
    METHODS setDiscount FOR MODIFY
      keys FOR ACTION zcho_m_travel_i~setDiscount RESULT result.
    METHODS lineCopy FOR MODIFY
      keys FOR ACTION zcho_m_travel_i~lineCopy.
    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR zcho_m_travel_i RESULT result.
    METHODS calculatetotalprice FOR DETERMINE ON MODIFY
      keys FOR zcho_m_travel_i~calculatetotalprice.
    METHODS recaltotprice FOR MODIFY
      keys FOR ACTION zcho_m_travel_i~recaltotprice.
    METHODS earlynumbering_cba_Booking FOR NUMBERING
      entities FOR CREATE zcho_m_travel_i\_Booking.

    METHODS earlynumbering_create FOR NUMBERING
      entities FOR CREATE zcho_m_travel_i.

ENDCLASS.

CLASS lhc_zcho_m_travel_i IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD Activate.
  ENDMETHOD.

  METHOD Discard.
  ENDMETHOD.

  METHOD Edit.
  ENDMETHOD.

  METHOD Resume.
  ENDMETHOD.

  METHOD earlynumbering_create.

    LOOP AT ENTITIES INTO DATA(LS_ENTITIES).

    if ls_entities-TravelId is INITIAL.

    try.

        cl_numberrange_runtime=>number_get(

        EXPORTING
        nr_range_nr = '01'
        object      = '/DMO/TRV_M'
        IMPORTING
        number  = DATA(lv_number)

         ).



    CATCH cx_nr_object_not_found into data(lo_error).
        failed-zcho_m_travel_i = VALUE #(  BASE failed-zcho_m_travel_i ( %cId = ls_entities-%cid
                                                                         %is_draft = ls_entities-%is_draft ) ).

        reported-zcho_m_travel_i = VALUE #( BASE reported-zcho_m_travel_i ( %CID = ls_entities-%cid
                                                                            %is_draft = ls_entities-%is_draft
                                                                            %msg = lo_error

         ) ).

        CONTINUE.

            CATCH cx_number_ranges into data(lo_error2).
        failed-zcho_m_travel_i = VALUE #(  BASE failed-zcho_m_travel_i ( %cId = ls_entities-%cid
                                                                         %is_draft = ls_entities-%is_draft ) ).

        reported-zcho_m_travel_i = VALUE #( BASE reported-zcho_m_travel_i ( %CID = ls_entities-%cid
                                                                            %is_draft = ls_entities-%is_draft
                                                                            %msg = lo_error2

         ) ).

         CONTINUE.

      ENDTRY.

      else.

        lv_number = ls_entities-TravelId.

      endif.

      mapped-zcho_m_travel_i = VALUE #(  base mapped-zcho_m_travel_i (  %cid = ls_entities-%cid
                                                                        %is_draft = ls_entities-%is_draft
                                                                        TravelId = lv_number ) ).


    ENDLOOP.

  ENDMETHOD.

  METHOD earlynumbering_cba_Booking.

    DATA : lv_max_booking TYPE zcho_m_booking_i-BookingId.

    READ ENTITIES OF zcho_m_travel_i IN LOCAL MODE
    ENTITY zcho_m_travel_i by \_booking
    FROM CORRESPONDING #( entities )
    RESULT data(lt_booking).

    sort lt_booking by TravelId BookingId DESCENDING.

    loop at entities into data(ls_entities).

    read TABLE lt_booking into data(ls_booking) with key TravelId = ls_entities-TravelId BINARY SEARCH.
    if sy-subrc = 0.
        lv_max_booking = ls_booking-BookingId.
    endif.

    loop at ls_entities-%target into data(ls_target).
        if ls_target-BookingId is INITIAL.
           lv_max_booking = lv_max_booking + 10.
        else.
            lv_max_booking = ls_target-BookingId.
        endif.

        append INITIAL LINE TO mapped-zcho_m_booking_i ASSIGNING FIELD-SYMBOL(<fs_mapped>).
        <fs_mapped> = CORRESPONDING #( ls_target ).
        <fs_mapped>-BookingId = lv_max_booking.

    ENDLOOP.

    ENDLOOP.




  ENDMETHOD.

  METHOD validatecustomer.


READ ENTITIES OF zcho_m_travel_i IN LOCAL MODE
    ENTITY zcho_m_travel_i
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result)
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

    IF lt_result IS NOT INITIAL.
      SELECT a~customer_id
        FROM /dmo/customer AS a INNER JOIN @lt_result AS b ON a~customer_id = b~customerid
       ORDER BY a~customer_id
        INTO TABLE @DATA(lt_customer).
    ENDIF.


    LOOP AT lt_result INTO DATA(ls_result).

    append INITIAL LINE TO reported-zcho_m_travel_i ASSIGNING FIELD-SYMBOL(<fs_reported>).
    <fs_reported>-%tky = ls_result-%tky.
    <fs_reported>-%state_area = 'VALIDATE_CUSTOMER'.

      IF ls_result-customerid IS NOT INITIAL.
        READ TABLE lt_customer INTO DATA(ls_customer) WITH KEY customer_id = ls_result-customerid BINARY SEARCH.
        IF sy-subrc <> 0.
          APPEND INITIAL LINE TO failed-zcho_m_travel_i ASSIGNING FIELD-SYMBOL(<fs_failed>).
          <fs_failed>-%tky = ls_result-%tky.
          APPEND INITIAL LINE TO reported-zcho_m_travel_i ASSIGNING <fs_reported>.
          <fs_reported>-%tky = ls_result-%tky.
          <fs_reported>-%msg = new_message( severity = if_abap_behv_message=>severity-error
                                            id       = 'ZCHO_M'
                                            number   = '000'
                                            v1       = TEXT-m01 ).
        ENDIF.

        ELSEIF ls_result-CustomerId is INITIAL.
          append INITIAL LINE TO failed-zcho_m_travel_i ASSIGNING <fs_failed>.
          <fs_failed>-%tky = ls_result-%tky.
          append INITIAL LINE TO reported-zcho_m_travel_i ASSIGNING <fs_reported>.
          <Fs_reported>-%tky = ls_result-%tky.
          append INITIAL LINE TO reported-zcho_m_travel_i ASSIGNING <fs_reported>.
          <fs_reported>-%tky = ls_result-%tky.
          <fs_reported>-%element-customerid = if_abap_behv=>mk-on.
          <fs_reported>-%state_area = 'VALIDATE_CUSTOMER'.
          <FS_REPORTED>-%MSG = NEW_MESSAGE( SEVERITY = IF_ABAP_BEHV_MESSAGE=>severity-ERROR
                                            ID       = 'ZCHO_M'
                                            NUMBER   = '000'
                                            V1       = TEXT-M03 ).

      ENDIF.
    ENDLOOP.



  ENDMETHOD.

  METHOD validateAgency.
    READ ENTITIES OF ZCHO_M_TRAVEL_I IN LOCAL MODE
    ENTITY zcho_m_travel_i
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT data(lt_result)
    FAILED data(lt_failed)
    REPORTED data(lt_reported).

    if lt_result is NOT INITIAL.

    select a~agency_id
    from /dmo/agency as a
    INNER join @lt_result as b
    on a~agency_id = b~AgencyId
    order by a~agency_id
    into TABLE @data(lt_agency).

    endif.

    loop at lt_result into data(ls_result).

    append INITIAL LINE TO reported-zcho_m_travel_i ASSIGNING FIELD-SYMBOL(<fs_reported>).
    <fs_reported>-%tky = ls_result-%tky.
    <fs_reported>-%state_area = 'VALIDATE_AGENCY'.

    IF ls_result-AgencyId is not INITIAL.
        READ TABLE lt_agency into data(ls_agency)
                             with key
                             agency_id = ls_result-AgencyId
                             BINARY SEARCH.
        if sy-subrc <> 0.

            APPEND INITIAL LINE TO failed-zcho_m_travel_i ASSIGNING FIELD-SYMBOL(<fs_failed>).
            <fs_failed>-%tky = ls_Result-%tky.
            append INITIAL LINE TO reported-zcho_m_travel_i ASSIGNING <fs_reported>.
            <fs_reported>-%tky = ls_result-%tky.
            <fs_reported>-%element-agencyid = if_abap_behv=>mk-on.
            <fs_reported>-%state_area = 'VALIDATE_AGENCY'.
            <fs_reported>-%msg = new_message( severity = if_abap_behv_message=>severity-error
                                              id       = 'ZCHO_M'
                                              number   = '000'
                                              v1       = text-m02 ).

        endif.

     elseif ls_result-AgencyId is  INITIAL.
     append INITIAL LINE TO failed-zcho_m_travel_i ASSIGNING <fs_failed>.
     <fs_failed>-%tky = ls_result-%tky.
     append INITIAL LINE TO reported-zcho_m_travel_i ASSIGNING <fs_reported>.
     <fs_reported>-%tky = ls_result-%tky.
     <fs_reported>-%element-agencyid = if_abap_behv=>mk-on.
     <fs_reported>-%state_area = 'VALIDATE_AGENCY'.
     <fs_reported>-%msg = new_message( severity = if_abap_behv_message=>severity-error
                                       id       = 'ZCHO_M'
                                       number   = '000'
                                       v1       = text-m04  ).



    endif.

    endloop.

  ENDMETHOD.

  METHOD setBooked.

    LOOP AT keys INTO DATA(ls_keys).

        MODIFY ENTITIES OF ZCHO_M_TRAVEL_I IN LOCAL MODE
        ENTITY ZCHO_M_TRAVEL_I
        UPDATE FIELDS ( STATUS )
        WITH VALUE #( ( %tky = LS_KEYS-%tky
                        %data-status = 'B') ).

    ENDLOOP.

    READ ENTITIES OF ZCHO_M_TRAVEL_I IN LOCAL MODE
    ENTITY ZCHO_M_TRAVEL_I
    ALL FIELDS WITH CORRESPONDING #( KEYS )
    RESULT DATA(LT_TRAVEL).

    LOOP AT LT_TRAVEL INTO DATA(LS_TRAVEL).
        RESULT = VALUE #( ( %TKY = LS_travel-%tky
                            %param = CORRESPONDING #( LS_TRAVEL ) ) ).
    ENDLOOP.


  ENDMETHOD.

  METHOD setDiscount.

    SELECT TravelId
    FROM zcho_m_travel_i
    into TABLE @data(lt_travel).

    READ ENTITIES OF zcho_m_travel_i IN LOCAL MODE
    ENTITY zcho_m_travel_i
    all FIELDS WITH CORRESPONDING #( lt_travel )
    RESULT data(lt_travel_entity).

    LOOP AT lt_travel_entity ASSIGNING FIELD-SYMBOL(<fs_travel_entity>).
       <fs_travel_entity>-BookingFee = <fs_travel_entity>-BookingFee * '0.9'.
    ENDLOOP.

    MODIFY ENTITIES OF zcho_m_travel_i in local mode
    ENTITY zcho_m_travel_i
    UPDATE FIELDS ( BookingFee ) WITH CORRESPONDING #(  lt_travel_entity )
    FAILED data(lt_failed).

    RESULT = VALUE #( FOR wa IN LT_TRAVEL_ENTITY
                     ( %CID = VALUE #( KEYS[ 1 ]-%CID OPTIONAL )
                       %PARAM = WA ) ).




  ENDMETHOD.

  METHOD lineCopy.

  READ ENTITIES OF ZCHO_M_TRAVEL_I IN LOCAL MODE
  ENTITY ZCHO_M_TRAVEL_I
  ALL FIELDS WITH CORRESPONDING #( KEYS )
  RESULT DATA(LT_TRAVEL).

  READ ENTITIES OF ZCHO_M_TRAVEL_I IN LOCAL MODE
  ENTITY ZCHO_M_TRAVEL_I BY \_booking
  ALL FIELDS WITH CORRESPONDING #( KEYS )
  RESULT DATA(LT_BOOKING).

  DATA : LT_TRAVEL_CREATE TYPE TABLE FOR CREATE ZCHO_M_TRAVEL_I,
         LT_BOOKING_CREATE TYPE TABLE FOR CREATE zcho_m_travel_i\_booking.


  LOOP AT LT_TRAVEL INTO DATA(LS_TRAVEL).

    APPEND INITIAL LINE TO LT_TRAVEL_CREATE ASSIGNING FIELD-SYMBOL(<FS_TRAVEL_CREATE>).
    <fS_TRAVEL_CREATE>-%CID = VALUE #( KEYS[ 1 ]-%CID OPTIONAL ).
    <fS_TRAVEL_CREATE>-%is_draft = LS_TRAVEL-%is_draft.
    <FS_TRAVEL_CREATE>-%DATA = CORRESPONDING #( LS_TRAVEL-%DATA EXCEPT TRAVELID ).
    CLEAR <FS_TRAVEL_CREATE>-%DATA-TravelId.

    LOOP AT LT_BOOKING USING KEY ENTITY INTO DATA(LS_BOOKING) WHERE TRAVELID = LS_TRAVEL-TRAVELID.

    APPEND INITIAL LINE TO LT_BOOKING_CREATE ASSIGNING FIELD-SYMBOL(<FS_BOOKING_CREATE>).
    <FS_BOOKING_CREATE>-%cid_ref = VALUE #( KEYS[ 1 ]-%cid OPTIONAL ).
    <fs_booking_create>-%is_draft = LS_BOOKING-%is_draft.
    <FS_BOOKING_CREATE>-%target = VALUE #( ( VALUE #( BASE CORRESPONDING #( LS_BOOKING EXCEPT TRAVELID )
                                                      %CID = <FS_TRAVEL_CREATE>-%cid && LS_BOOKING-BookingId  ) ) ).

    ENDLOOP.

  ENDLOOP.

  MODIFY ENTITIES OF ZCHO_M_TRAVEL_I IN LOCAL MODE
  ENTITY ZCHO_M_TRAVEL_I
  CREATE FIELDS ( AgencyID CustomerId BeginDate EndDate BookingFee TotalPrice CurrencyCode Description Status )
  with lt_travel_create

  ENTITY zcho_m_travel_i CREATE BY \_booking
  FIELDS ( BookingId BookingDate CustomerId CarrierId ConnectionId FlightDate FlightPrice CurrencyCode )
  with lt_booking_create
  MAPPED data(lt_mapped)
  FAILED data(lt_failed).

  if lt_failed is INITIAL.

    mapped-zcho_m_travel_i = lt_mapped-zcho_m_travel_i.
    reported-zcho_m_travel_i = VALUE #( (  %tky = lt_mapped-zcho_m_travel_i[ 1 ]-%tky
                                           %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information
                                                                         text     = 'Coping Completed') ) ).

  endif.


  ENDMETHOD.

  METHOD get_instance_features.

  READ ENTITIES OF zcho_m_travel_i IN LOCAL MODE
  entity zcho_m_travel_i
  fields ( TravelId Status )
  with CORRESPONDING #( keys )
  result data(lt_travel).

  result = VALUE #( for ls_travel in lt_travel
                  ( %tky = ls_travel-%tky
                    %features-%delete = cond #( when ls_travel-Status = 'B'
                                                then if_abap_behv=>fc-o-disabled else if_abap_behv=>fc-o-enabled )

                    %features-%action-lineCopy = cond #(  when ls_travel-Status = 'B'
                                                          then if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled ) ) ).



  ENDMETHOD.

  METHOD calculateTotalPrice.

   modify ENTITIES OF zcho_m_travel_i in local mode
   entity zcho_m_travel_i
   execute recalTotPrice
   FROM CORRESPONDING #(  keys ).

*  READ ENTITIES OF zcho_m_travel_i IN LOCAL MODE
*  entity zcho_m_travel_i
*  all FIELDS WITH CORRESPONDING #(  keys )
*  RESULT DATA(lt_travel)
*
*  entity zcho_m_travel_i by \_booking
*  all fields with corresponding #( keys )
*  result data(lt_booking).
*
*  loop at lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).
*
*    <fs_travel>-totalprice = <fs_travel>-bookingfee.
*
*    loop at lt_booking using key entity into data(ls_booking) where TravelId = <fs_travel>-TravelId.
*        <fs_travel>-TotalPrice = <fs_travel>-TotalPrice + ls_booking-FlightPrice.
*    ENDLOOP.
*
*  endloop.
*
*  modify ENTITIES OF zcho_m_travel_i in LOCAL MODE
*  entity zcho_m_travel_i
*  UPDATE FIELDS ( TotalPrice )
*  with corresponding #( lt_travel )
*  failed data(lt_failed)
*  reported data(lt_reported).

  ENDMETHOD.

  METHOD recalTotPrice.

  READ ENTITIES OF zcho_m_travel_i in LOCAL MODE
  entity zcho_m_travel_i
  all FIELDS WITH CORRESPONDING #(  keys )
  result data(lt_travel)

  entity zcho_m_travel_i by \_booking
  all FIELDS WITH CORRESPONDING #( keys )
  result data(lt_booking).

  loop at lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).

    <fs_travel>-TotalPrice = <fs_travel>-BookingFee.

    loop at lt_booking using key entity into data(ls_booking) where travelid = <fs_travel>-travelid.
        <fs_travel>-totalprice = <fs_travel>-TotalPrice + ls_booking-FlightPrice.
    ENDLOOP.

  endloop.

  MODIFY ENTITIES OF zcho_m_travel_i IN LOCAL MODE
  entity zcho_M_travel_i
  update FIELDS ( totalprice )
  with CORRESPONDING #( lt_travel )
  FAILED data(lt_failed)
  REPORTED data(lt_reported).

  ENDMETHOD.

ENDCLASS.
