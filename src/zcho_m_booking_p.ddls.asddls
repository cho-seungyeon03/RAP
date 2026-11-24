@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'booking projection view'
@Metadata.allowExtensions: true
define view entity zcho_m_booking_p 
    as projection on zcho_m_booking_i
{
    key TravelId,
    key BookingId,
    BookingDate,
    @ObjectModel.text.element: [ 'CustomerName' ]
    CustomerId,
    _CUSTOMER.LastName as CustomerName,
    @ObjectModel.text.element: [ 'CarrierName' ]
    CarrierId,
    _CARRIER.Name as CarrierName,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    
    _TRAVEL : redirected to parent zcho_m_travel_p,
    _CUSTOMER,
    _CARRIER,
    _CONNECTION
}
