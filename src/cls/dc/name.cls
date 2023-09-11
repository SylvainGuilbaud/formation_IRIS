Class dc.name Extends %RegisteredObject
{

/// Description
ClassMethod test() As %Status
{
    Set sc = $$$OK
    SET ^client(4)="Vermont"
    SET ^client(4,1)="Brattleboro"
    SET ^client(4,1,1)="Yankee Ingenuity"
    SET ^client(4,1,2)="Vermonster Systems"
    WRITE !,$NAME(^client(4,1,1),1) ; returns 1 level
    WRITE !,$NAME(^client(4,1,1),2) ; returns 2 levels
    WRITE !,$NAME(^client(4,1,1),3) ; returns 3 levels
    WRITE !,$NAME(^client(4,1,1),4) ; returns all (3) levels
    WRITE !,$NAME(^client(4,1,1),0) ; returns array name
    WRITE !,$NAME(^client(4,1,1),"") ; returns array name
    WRITE !,$NAME(^client(4,1,1))    ; returns all (3) levels
    write !

    FOR var1=1 { 
     DO ..descend($NAME(^client(var1))) } 
    Return sc
}

/// Description
ClassMethod descend(ROOT) As %Status
{
    Set sc = $$$OK
    SET REF=ROOT
    IF ROOT'["(" {
        FOR {
        SET REF=$QUERY(@REF) 
        QUIT:REF="" 
        WRITE REF,! }
    }
    ELSE {
        SET $EXTRACT(ROOT,$LENGTH(ROOT))=","
        FOR {
        SET REF=$QUERY(@REF)
        QUIT:REF'[ROOT 
        WRITE REF,!   }
    }
    Return sc
}

}
