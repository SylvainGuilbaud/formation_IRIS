Class pagination.sample Extends (%Persistent, %Populate)
{

Property code As %String(VALUELIST = ",C1,C2,C3");

Property name As %String(VALUELIST = ",P1,P2,P3");

Property quantity As %Integer(MAXVAL = 100, MINVAL = 1);

Property ts As %TimeStamp [ InitialExpression = {$zdt($now(),3,,6)} ];

/// init
/// w ##class(pagination.sample).init()
ClassMethod init(nb As %Integer = 1000000, reset As %Boolean = 1) As %Status
{
   
    set sc=$$$OK
    set start=$zh
    do:reset ..%KillExtent()
    set nb =..Populate(nb)
    set elapse = $zh-start
    write nb," inserted in ",elapse," seconds",!
    Return sc
}

/// get
Query get(min As %Integer, max As %Integer) As %SQLQuery [ SqlProc ]
{
    select TOP 10 %ID,code,name,quantity,ts
    from pagination.sample 
    where %ID in (
        SELECT * FROM (
            SELECT %ID FROM pagination.sample
            WHERE code='C1' 
            AND name='P2'
            AND quantity between 80 and 100
            ) 
        WHERE %VID BETWEEN :min AND :max)
}

/// Description
Query top(min As %Integer = 1, max As %Integer = 5) As %SQLQuery [ SqlProc ]
{
  SELECT *
   FROM (SELECT TOP 10 *
         FROM pagination.sample
        WHERE code='C1' 
        AND name='P2'
        AND quantity between 80 and 100
        ORDER BY ts)
   WHERE %VID BETWEEN :min AND :max
}

/// test
/// w ##class(pagination.sample).test()
/// w ##class(pagination.sample).test(1,5)
/// w ##class(pagination.sample).test(6,10)
/// w ##class(pagination.sample).test(11,15)
ClassMethod test(min As %Integer = 1, max As %Integer = 5) As %Status
{
    Try {
        set sc = $$$OK,start=$zh
        set tStatement = ##class(%SQL.Statement).%New()
        set sc=tStatement.%PrepareClassQuery("pagination.sample","top")
        if 'sc {
            do $System.Status.DisplayError(sc)
            quit
        } else {
            set rset=tStatement.%Execute(min,max)
            do rset.%Display()  
            set elapse = $zh-start
            write !,"rows ",min," and ",max," retrieved in ",elapse," seconds",!
        }
    }
    Catch ex {
        set sc=ex.AsStatus()
        do $System.Status.DisplayError(sc)
    }

    Return sc
}

/// run
/// w ##class(pagination.sample).run()
/// w ##class(pagination.sample).run(10)
/// w ##class(pagination.sample).run(50)
ClassMethod run(nb As %Integer = 10, pagesize As %Integer = 10) As %Status
{
    set sc = $$$OK
    for i=1:1:nb {
        set min = i-1+pagesize,max = min-1+pagesize
        do ..test(min,max)
    }
    write !,$zv,!
    Return sc
}

Storage Default
{
<Data name="sampleDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>code</Value>
</Value>
<Value name="3">
<Value>name</Value>
</Value>
<Value name="4">
<Value>quantity</Value>
</Value>
<Value name="5">
<Value>ts</Value>
</Value>
</Data>
<DataLocation>^pagination.sampleD</DataLocation>
<DefaultData>sampleDefaultData</DefaultData>
<IdLocation>^pagination.sampleD</IdLocation>
<IndexLocation>^pagination.sampleI</IndexLocation>
<StreamLocation>^pagination.sampleS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
