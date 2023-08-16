Class utils.try
{

/// Description
ClassMethod sequence() As %Status
{
  Set sc = $$$OK


  TRY {
  SET rand=$RANDOM(2)
  SET $SEQUENCE(^bignum)=9.223372036854775800E18
    IF rand=0 {  WRITE "slow increments:",!
    FOR x=1:1:10 {WRITE $SEQUENCE(^bignum)," increment #",x,!
                HANG .5 }
    }
    IF rand=1 {WRITE "fast increments:",!
    FOR i=1:1:10 {WRITE $SEQUENCE(^bignum)," increment #",i,!}
    }
  }
  CATCH exp { WRITE !,"In the CATCH block",!
                IF 1=exp.%IsA("%Exception.SystemException") {
                  WRITE "System exception",!
                  WRITE "Name: ",exp.Name,!
                  WRITE "Location: ",exp.Location,!
                }
                ELSE { WRITE "unknown error",! }
  }
  return sc
}

ClassMethod increment() As %Status
{
  Set sc = $$$OK


  TRY {
  SET rand=$RANDOM(2)
  SET ^bignum=9.223372036854775800E18
    IF rand=0 {  WRITE "slow increments:",!
    FOR x=1:1:10 {WRITE $INCREMENT(^bignum)," increment #",x,!
                HANG .5 }
    }
    IF rand=1 {WRITE "fast increments:",!
    FOR i=1:1:10 {WRITE $INCREMENT(^bignum)," increment #",i,!}
    }
  }
  CATCH exp { WRITE !,"In the CATCH block",!
                IF 1=exp.%IsA("%Exception.SystemException") {
                  WRITE "System exception",!
                  WRITE "Name: ",exp.Name,!
                  WRITE "Location: ",exp.Location,!
                }
                ELSE { WRITE "unknown error",! }
  }
  return sc
}

}
