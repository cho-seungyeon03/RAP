CLASS zcl_cho_m_travel_ve DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
  CONSTANTS:
      BEGIN OF C_CRITICALITY,
          negative TYPE int1 VALUE 1,
          critical TYPE int1 VALUE 2,
          positive TYPE int1 VALUE 3,
     END OF c_criticality.
ENDCLASS.



CLASS ZCL_CHO_M_TRAVEL_VE IMPLEMENTATION.


    METHOD if_sadl_exit_calc_element_read~get_calculation_info. "필요한 필드 알려주기 db조회 전 호출

    if it_requested_calc_elements is INITIAL.
    return.
    endif.

    DATA : lt_element TYPE table of string.

    LOOP AT it_requested_calc_elements into data(lv_element).
        case to_upper( lv_element ).
            when 'DAYSUNTILDEPARTURE' OR 'DEPARTURECRITICALITY'.
                APPEND 'BEGINDATE' TO LT_ELEMENT.
            ENDCASE.
    ENDLOOP.

    sort lt_element.
    delete ADJACENT DUPLICATES FROM lt_element.

    et_requested_orig_elements = lt_element.

    ENDMETHOD.


    METHOD if_sadl_exit_calc_element_read~calculate. "값 계산해서 채우기 화면에 표시 db 조회 후 호출

    DATA lt_travel TYPE STANDARD TABLE OF zcho_m_travel_p WITH EMPTY KEY.

    lt_travel = CORRESPONDING #( it_original_data ).

    data(lv_today) = cl_abap_context_info=>get_system_date(  ).

    loop at lt_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).

    "남은 일수 계산
    if <fs_travel>-BeginDate is INITIAL.
        <fs_travel>-DaysUntilDeparture = 0.
    else.
       <fs_travel>-DaysUntilDeparture = <fs_travel>-BeginDate - lv_today.
    endif.

    "남은 일수에 따른 색상 결정
    <fs_travel>-DepartureCriticality = cond #(
        when <fs_travel>-BeginDate is INITIAL    then c_criticality-negative
        when <fs_travel>-DaysUntilDeparture < 0  then c_criticality-negative
        when <fs_travel>-DaysUntilDeparture <= 7 then c_criticality-critical
        else c_criticality-positive ).

        "Booking 상태에 따라 숨김
        <fs_travel>-BookingHiddenFlag = cond #( when <fs_travel>-Status = 'B' THEN abap_true
                                                else abap_false ).

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_travel ).

    ENDMETHOD.
ENDCLASS.
