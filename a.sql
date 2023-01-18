SELECT commande,
    ID,
    element_key,
    items_code,
    items_description,
    items_name,
    items_unitPrice,
    items_valid,
    commande->orderCurrency,
    commande->orderPlacedDate,
    commande->orderStatus,
    commande->orderValue,
    commande->requestedDeliveryDate,
    commande->requestedShipDate
FROM data.commande_items
where commande = 1