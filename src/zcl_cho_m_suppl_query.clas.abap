CLASS zcl_cho_m_suppl_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CHO_M_SUPPL_QUERY IMPLEMENTATION.


METHOD if_rap_query_provider~select.

    data lt_result TYPE STANDARD TABLE OF zcho_m_supplement_c.

    try.
        data(lt_filter) = io_request->get_filter( )->get_as_ranges(  ).
    catch CX_RAP_QUERY_FILTER_NO_RANGE.
        CLEAR lt_filter.
    ENDTRY.

" [페이징] 앞에서부터 건너뛸 건수 (OData $skip)
" 예: 첫 페이지 = 0, 다음 페이지 = 20, 40 ...
DATA(lv_offset) = io_request->get_paging( )->get_offset( ).

" [페이징] 한 번에 가져올 건수 (OData $top)
" 제한이 없으면 -1 (if_rap_query_paging=>page_size_unlimited)
DATA(lv_size)   = io_request->get_paging( )->get_page_size( ).

" [정렬] 화면에서 요청한 정렬 조건 (OData $orderby)
" 각 행에 element_name(필드명, 대문자)과 descending(내림차순 여부)이 들어 있음
" 정렬 요청이 없으면 빈 테이블
DATA(lt_sort)   = io_request->get_sort_elements( ).


    data(lr_travel) = VALUE #( lt_filter[ name = 'TRAVELID' ]-range OPTIONAL ).

    SELECT TravelId
        FROM zcho_m_travel_i
       where TravelId in @lr_travel
        into table @data(lt_travel).

      if lt_travel is INITIAL.
      return.
      endif.

      data : lt_suppl TYPE /dmo/t_booking_supplement,
             lt_messages TYPE /dmo/t_message.

             loop AT lt_travel into data(ls_travel).

             clear : lt_suppl, lt_messages.

             call FUNCTION '/DMO/FLIGHT_TRAVEL_READ'
                EXPORTING
                   iv_travel_id = ls_travel-TravelId
                   iv_include_buffer = abap_true
                 IMPORTING
                   et_booking_supplement = lt_suppl
                   et_messages = lt_messages.

              loop at lt_suppl into data(ls_suppl).
                append VALUE #(
                  travelid = ls_suppl-travel_id
                  bookingid = ls_suppl-booking_id
                  bookingsupplid = ls_suppl-booking_supplement_id
                  supplementId = ls_suppl-supplement_id
                  price = ls_suppl-price
                  currencyCode = ls_suppl-currency_code
                ) to lt_result.

              ENDLOOP.

             ENDLOOP.

" 전체 건수 요청 시: 페이징으로 자르기 전의 전체 건수를 응답
IF io_request->is_total_numb_of_rec_requested( ).
  io_response->set_total_number_of_records( lines( lt_result ) ).
ENDIF.

" 데이터 요청 시: 요청된 페이지 구간만 잘라서 응답
IF io_request->is_data_requested( ).

  " [offset 처리] 앞에서부터 offset 건수만큼 건너뛰기
  IF lv_offset > 0.
    IF lv_offset >= lines( lt_result ).
      " 건너뛸 건수가 전체 건수 이상이면 남는 데이터 없음 → 전부 삭제
      CLEAR lt_result.
    ELSE.
      " 1번째 ~ offset번째 행 삭제 (예: offset 20 → 1~20행 삭제)
      DELETE lt_result TO lv_offset.
    ENDIF.
  ENDIF.

  " [page size 처리] 페이지 크기만큼만 남기기
  " lv_size = -1(page_size_unlimited)이면 제한 없음 → 처리 안 함
  IF lv_size >= 0 AND lines( lt_result ) > lv_size.
    " page size 초과분 삭제 (예: size 10 → 11번째 행부터 끝까지 삭제)
    DELETE lt_result FROM lv_size + 1.
  ENDIF.

  " 잘라낸 결과(요청된 페이지 분량)를 화면에 응답
  io_response->set_data( lt_result ).

ENDIF.




ENDMETHOD.
ENDCLASS.
