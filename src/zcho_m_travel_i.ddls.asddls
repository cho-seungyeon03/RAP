@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'travel interface view'
@Metadata.ignorePropagatedAnnotations: true

define root view entity zcho_m_travel_i 
    as select from /dmo/travel
    composition [1..*] of zcho_m_booking_i as _BOOKING
    association [0..1] to /DMO/I_Agency    as _AGENCY  on $projection.AgencyId       = _AGENCY.AgencyID
    association [0..1] to /DMO/I_Customer  as _CUSTOMER on $projection.CustomerId    = _CUSTOMER.CustomerID
    association [0..1] to /DMO/I_Travel_Status_VH as _STATUS on $projection.Status   = _STATUS.TravelStatus   
    association [0..*] to zcho_m_supplement_c as _SUPPLEMENT on $projection.TravelId = _SUPPLEMENT.TravelId
{
    key travel_id as TravelId,
    agency_id as AgencyId,
    customer_id as CustomerId,
    begin_date as BeginDate,
    end_date as EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    booking_fee as BookingFee,
     @Semantics.amount.currencyCode: 'CurrencyCode'
    total_price as TotalPrice,
    currency_code as CurrencyCode,
    description as Description,  
    status as Status,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdat as Createdat,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedat as Lastchangedat,
    
    _BOOKING,
    _AGENCY,
    _CUSTOMER,
    _STATUS,
    _SUPPLEMENT
    
}
