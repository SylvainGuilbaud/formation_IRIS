Class time.test
{

/// do ##class(Utils.Time).Test()
ClassMethod Test()
{
	do ..Main(1)
	do ..Main(1)
	do ..Main(1)
	do ..Main(2)
	do ..Main(3)
	do ..Main(5)
	do ..Main(10)
	do ..Main(100)
	do ..Main(1000)
	do ..Main(10000)
}

/// do ##class(Utils.Time).Main(100)
ClassMethod Main(count = 100)
{
	set od=$io
	set nul="\\.\nul" // /dev/null/ - UNIX
	open nul
	use nul
	
	s startA = $NOW()
	do ..JobA(count)
	s endA = $NOW()
	s timeA = $p(endA,",",*) - $p(startA,",",*)
	
	s startB = $NOW()
	do ..JobB(count)
	s endB = $NOW()
	s timeB = $p(endB,",",*) - $p(startB,",",*)
	
	use od
	close nul
	
	w "Iterations: ",count,!
	w "Time JobA: ",timeA,!
	w "Time JobB: ",timeB,!
	w "JobA takes ",$FN(timeA/timeB*100,"",2) _ "% of JobB time",!,!
}

ClassMethod JobA(count = 100) As %Status
{
	for i=1:1:count {
		set now = $now()
		set ts = $zdt(now,-2) _ "." _ $p(now, ".", 2)
	}
}

ClassMethod JobB(count = 100) As %Status
{
	set time = ##class(%SYS.Python).Import("time")
	for i=1:1:count {	
		set ts = time.time()
	}
}

}
