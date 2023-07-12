/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.Data.Shipment Extends SC.Core.Data.TimeStampedData [ Abstract, NoExtent ]
{

/// requested time of arrival
Property requestedTimeOfArrival As %DateTime;

/// committed time of arrival
Property committedTimeOfArrival As %DateTime;

/// actual ship date
Property actualShipDate As %DateTime;

/// estimated time of arrival (ETA)
Property estimatedTimeOfArrival As %DateTime;

/// Updated ETA (latest)
Property updatedEta As %DateTime;

/// predicted time of arrival
Property predictedTimeOfArrival As %DateTime;

/// actual time of arrival
Property actualTimeOfArrival As %DateTime;

/// delivered date time. Can be different from actual time of arrival if additional steps are needed for delivery to complete.
Property deliveredDateTime As %DateTime;

/// shipment created date time
Property shipmentCreatedDateTime As %DateTime;

/// recipient name
Property recipientName As %String(MAXLEN = 128);

/// purchase order
Property purchaseOrder As %String(MAXLEN = 128);

/// Order create source
Property orderCreatedSource As %String(MAXLEN = 128);

/// cancel date time
Property cancelledDateTime As %DateTime;

/// latest coordinate
Property latestCoordinate As %String(MAXLEN = 128);

/// latest coordinate time
Property latestCoordinateTime As %DateTime;

/// In transit location, typically a stop.
Property inTransitLocation As %String(MAXLEN = 128);

/// shipper account number.
Property shipperAccountNumber As %String(MAXLEN = 128);

/// shipper name.
Property shipperName As %String(MAXLEN = 128);

/// shipping cost
Property shippingCost As %Numeric;

/// shipping cost currency
Property shippingCostCurrency As %String(MAXLEN = 128);

/// transport mode
Property transportMode As %String(MAXLEN = 128);

/// status
Property status As %String(MAXLEN = 128);

/// substatus
Property substatus As %String(MAXLEN = 128);

/// type
Property type As %String(MAXLEN = 128);

/// weight
Property weight As %Numeric;

// weight unit of measure

Property weightUom As %String(MAXLEN = 32);

/// hours delayed
Property hoursDelayed As %Numeric;

/// when tracking starts
Property trackStartDateTime As %DateTime;

/// current status city name
Property currentStatusCityName As %String(MAXLEN = 128);

/// carrier notified (boolean) 0 is false
Property notifyCarrier As %Integer(MAXVAL = 1, MINVAL = 0);

/// freight forwarder
Property freightForwarder As %String(MAXLEN = 128);

/// carrier container
Property carrierContainer As %String(MAXLEN = 128);

/// house airway bill
Property houseAirwayBill As %String(MAXLEN = 128);

/// parcel tracking number
Property parcelTrackingNumber As %String(MAXLEN = 128);

/// bill of lading number (BOL)
Property billOfLadingNumber As %String(MAXLEN = 128);

/// shipment category
Property shipmentCategory As %String(MAXLEN = 128);

/// carrier booking number
Property carrierBookingNumber As %String(MAXLEN = 128);

/// master airway bill number
Property masterAirWaybillNumber As %String(MAXLEN = 128);

/// shipment ID assigned externally
Property externalShipmentID As %String(MAXLEN = 128);

}
