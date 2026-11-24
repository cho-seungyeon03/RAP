@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'travel projection view'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'TravelId' ]
define root view entity zcho_m_travel_p 
    provider contract transactional_query
    as projection on zcho_m_travel_i
{     
    key TravelId,
    @ObjectModel.text.element : [ 'AgencyName' ] 
    AgencyId,
    _AGENCY.Name as AgencyName,
    @ObjectModel.text.element: [ 'CustomerName' ]
    CustomerId,
    _CUSTOMER.LastName as CustomerName,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    @ObjectModel.text.element: [ 'StatusName' ]
    Status,
    _STATUS._Text.Text as StatusName : localized,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CHO_M_TRAVEL_VE'
    @EndUserText.label: 'Days Until Departure'
    virtual DaysUntilDeparture : abap.int4,
    
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CHO_M_TRAVEL_VE'
    virtual DepartureCriticality : abap.int1,
    
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CHO_M_TRAVEL_VE'
    virtual BookingHiddenFlag : abap_boolean, 
    
    
    _BOOKING : redirected to composition child zcho_m_booking_p,
    _AGENCY,
    _CUSTOMER,
    _STATUS,
    _SUPPLEMENT
}


