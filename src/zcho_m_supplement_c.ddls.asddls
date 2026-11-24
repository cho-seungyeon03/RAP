@EndUserText.label: 'Booking Supplement Customer View'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_CHO_M_SUPPL_QUERY'
@Metadata.allowExtensions: true
define custom entity zcho_m_supplement_c
{
  key TravelId  : /dmo/travel_id;
  key BookingId : /dmo/booking_id;
  key BookingSupplId : /dmo/booking_supplement_id;
      SupplementId : /dmo/supplement_id;
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price : /dmo/supplement_price;
      CurrencyCode : /dmo/currency_code; 
  
}
 