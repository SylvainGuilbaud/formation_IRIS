Class data.commande Extends (%Persistent, %Populate)
{

/// order status
Property orderStatus As %String(MAXLEN = 128);

/// requested ship date
Property requestedShipDate As %TimeStamp [ InitialExpression = {$zdt($h+$r(21)+5,3)} ];

/// requested delivery date
Property requestedDeliveryDate As %TimeStamp [ InitialExpression = {$zdt($h+$r(21)+15,3)} ];

/// order placed date
Property orderPlacedDate As %TimeStamp [ InitialExpression = {$zdt($h+$r(21)+1,3)} ];

/// order value
Property orderValue As %Numeric;

/// order currency
Property orderCurrency As %String(VALUELIST = ",EUR,USD,GBP,YEN,TND,CNY,JPY,MAD,DZD,TRY");

Property items As array Of data.article;

/// Description
ClassMethod getItems(id As %Integer = 1) As %Status
{
    Set sc = $$$OK
    set a = ..%OpenId(id)
    if $ISOBJECT(a) {
        for i=1:1:a.items.Count() { write a.items.GetNext(.key).name,!}
    }
    Return sc
}

ClassMethod getItemsPy(id As %Integer = 1) As %Status [ Language = python ]
{
    import iris
    sc = 1
    #; a = iris.cls('data.commande')._OpenId(id)
    #; key=""
    #; for i in range(a.items.Count()):
    #;     key = a.items.Next(key)
    #;     item = a.items.GetAt(key)
    #;     print('item ',i,'  key: ', key, ' name:',item.name)

    commande = iris.cls('data.commande')._OpenId(id)
    print(f'id : {id}, ship date: {commande.requestedShipDate}')
    for key, article in commande.items.items():
        print(f'key:  {key},  name: {article.name}')
    
    # loop over items and key
    #; for key, article in commande.items.items():
    #;     print(f'key:  {key},  name: {article.name}')

    return sc
}

ClassMethod getItems3(id As %Integer = 1) As %Status [ Language = python ]
{
    import iris
    sc = 1
    print(id)
    a = iris.cls('data.commande')._OpenId(id)
    #; print(a)
    #; print(a.orderStatus)
    #; print(a.items)
    #; print(a.items.Count())
    key=""
    for i in range(a.items.Count()):
        item = a.items.GetNext(key)
        print('item ',i,'  key: ', key, ' name:',item.name)
    return sc
}

ClassMethod run(nb As %Integer = 1) As %Status [ Language = python ]
{
    import iris
    test = iris.cls('data.commande')
    test.getItems2(nb)
}

Storage Default
{
<Data name="commandeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>orderStatus</Value>
</Value>
<Value name="3">
<Value>requestedShipDate</Value>
</Value>
<Value name="4">
<Value>requestedDeliveryDate</Value>
</Value>
<Value name="5">
<Value>orderPlacedDate</Value>
</Value>
<Value name="6">
<Value>orderValue</Value>
</Value>
<Value name="7">
<Value>orderCurrency</Value>
</Value>
</Data>
<Data name="items">
<Attribute>items</Attribute>
<Structure>subnode</Structure>
<Subscript>"items"</Subscript>
</Data>
<DataLocation>^data.commandeD</DataLocation>
<DefaultData>commandeDefaultData</DefaultData>
<IdLocation>^data.commandeD</IdLocation>
<IndexLocation>^data.commandeI</IndexLocation>
<StreamLocation>^data.commandeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
