/// Web Terminal version 4.9.5 WebSocket handlers class.
/// This class describes handlers for WebSocket client. Each handler method takes WS client instance
/// as a first argument, and a given data as second. For example, handler for "execute"
/// command will be names as "HandleExecute". Note that all the processing is synchronous and it
/// blocks the WebSocket input while processing.
/// This class is inherited by WebTerminal.Engine class.
/// Methods must return positive status or an error if one happened.
/// Method must take two arguments, the first is the WebTerminal.Engine instance, and data as second
Class WebTerminal.Handlers
{

/// data can be either string or %ZEN.proxyObject. In case of proxyObject, the command is hold in
/// data.command property, and it may have some other control properties.
ClassMethod Execute(client As WebTerminal.Engine, data, bareStart As %Boolean = 0) As %Status
{
    if (bareStart) goto loop
    if $IsObject(data) {
        set command = data.command
        if (data.echo = 0) {
            set client.echo = 0
        }
        if (data.bufferOutput = 1) {
            set client.bufferOutput = 1
        }
    } else {
        set command = data
    }
    do client.Send("o", $CHAR(13, 10))
    do client.SendChunk(client.corePID, "m", command)
loop
    for {
        set message = client.ReceiveChunk(0, 1) // read from WebSocket as well: timeout = 0
        if ($LISTGET(message, 3) < 0) {
            return $$$ERROR($$$GeneralError, "%cpTerm")
        }
        set flag = $LISTGET(message, 1)
        if (flag = "") { // if there is no messages from the child process executing the task,
            set mes = client.GetMessage(0) // look at the incoming WebSocket messages
            if (mes '= "") && (mes.h = "Interrupt") { // and if the interrupt has been sent
                do $System.Util.SendInterrupt(client.corePID) // interrupt the child process
            } else { // else hang for a while to prevent "waiting" process from loading CPU
                hang 0.05
            }
            continue
        }
        set chunk = $LISTGET(message, 2)
        if (flag = "o") {
            do client.Send("o", chunk)
        } elseif (flag = "r") {
            set obj = ##class(%ZEN.proxyObject).%New()
            set obj.length = $LISTGET(chunk, 1)
            set obj.timeout = $LISTGET(chunk, 2)
            do client.Send("readString", obj)
            set mes = client.GetMessage()
            if (mes.h = "Interrupt") {
                do $System.Util.SendInterrupt(client.corePID)
            } else {
                do client.SendChunk(client.corePID, "m", mes.d)
            }
        } elseif (flag = "c") {
            set obj = ##class(%ZEN.proxyObject).%New()
            set obj.timeout = chunk
            do client.Send("readChar", obj)
            set mes = client.GetMessage()
            if (mes.h = "Interrupt") {
                do $System.Util.SendInterrupt(client.corePID)
            } else {
                do client.SendChunk(client.corePID, "m", mes.d)
            }
        } elseif (flag = "e") {
            set err = ""
            if $ListValid(chunk) {
                if ($LISTGET(chunk, 1) '= "") {
                    set client.childNamespace = $LISTGET(chunk, 1)
                }
                if ($LISTGET(chunk, 2) '= "") {
                    set err = $LISTGET(chunk, 2)
                }
            }
            if $IsObject(data) && (data.bufferOutput = 1) {
                do client.outputBuffer.Write(err)
                quit // break for loop
            }
            if (err '= "") {
                do client.Send(
                    "execError",
                    ##class(ErrorDecomposer).DecomposeError(err, client.childNamespace)
                )
            }
            quit // break for loop
        } else { // unknown response - just send it to the client
            do client.Send("o", chunk)
        }
    }
    do client.Send("o", $CHAR(13, 10))
    if $IsObject(data) {
        if (data.echo = 0) {
            set client.echo = 1
        }
        if (data.bufferOutput = 1) {
            set client.bufferOutput = 0
            set str = ""
            while ('client.outputBuffer.AtEnd) {
                set str = str _ client.outputBuffer.Read()
            }
            do client.Send("promptCallback", str)
            do client.outputBuffer.Clear()
        }
    }
    do:('($IsObject(data) && (data.prompt = 0)) && '(bareStart = 1)) client.Send("prompt", client.childNamespace)
    return $$$OK
}

ClassMethod Update(client As WebTerminal.Engine, URL As %String)
{
    set st = ##class(WebTerminal.Updater).Update(client, URL)
    do:($$$ISERR(st)) ##class(WebTerminal.Analytics).ReportInstallStatus(st)
    return st
}

ClassMethod LocalAutocomplete(client As WebTerminal.Engine, data)
{
	do client.SendChunk(client.corePID, "a")
	set list = $LISTGET(client.ReceiveChunk(, 1), 2)
	set obj = ##class(%ZEN.proxyObject).%New()
	for i=3:3:$LISTLENGTH(list) {
		set obj2 = ##class(%ZEN.proxyObject).%New()
		set obj2.isOref = $LISTGET(list, i - 1)
		set obj2.value = $LISTGET(list, i)
		set $PROPERTY(obj, $LISTGET(list, i - 2)) = obj2
	}
    do client.Send("ac", obj)
	return $$$OK
}

ClassMethod GlobalAutocomplete(client As WebTerminal.Engine, part As %String) As %Status
{
    do client.Send(, ##class(WebTerminal.Autocomplete).GetGlobals(client.childNamespace, part))
    return $$$OK
}

ClassMethod ClassAutocomplete(client As WebTerminal.Engine, part As %String) As %Status
{
    do client.Send(, ##class(WebTerminal.Autocomplete).GetClass(client.childNamespace, part))
    return $$$OK
}

ClassMethod RoutineAutocomplete(client As WebTerminal.Engine, part As %String) As %Status
{
    do client.Send(, ##class(WebTerminal.Autocomplete).GetRoutines(client.childNamespace, part))
    return $$$OK
}

ClassMethod ClassMemberAutocomplete(client As WebTerminal.Engine, data As %ZEN.proxyObject) As %Status
{
    do client.Send(, ##class(WebTerminal.Autocomplete).GetPublicClassMembers(client.childNamespace, data.className, data.part))
    return $$$OK
}

ClassMethod MemberAutocomplete(client As WebTerminal.Engine, data As %ZEN.proxyObject) As %Status
{
    do client.SendChunk(client.corePID, "a")
    set list = $LISTGET(client.ReceiveChunk(, 1), 2)
    set isOref = 0
    set value = ""
    for i=3:3:$LISTLENGTH(list) {
        if $LISTGET(list, i - 2) = data.variable {
            set isOref = $LISTGET(list, i - 1)
            set value = $LISTGET(list, i)
            quit
        }
    }
    if isOref {
        do client.Send(, ##class(WebTerminal.Autocomplete).GetClassMembers(
            client.childNamespace, $PIECE(value, "@", 2), data.part, data.methodsOnly
        ))
    } else {
        do client.Send(, 0)
    }
    return $$$OK
}

ClassMethod ParameterAutocomplete(client As WebTerminal.Engine, data As %ZEN.proxyObject) As %Status
{
    do client.Send(, ##class(WebTerminal.Autocomplete).GetParameters(client.childNamespace, data.className, data.part))
    return $$$OK
}

ClassMethod serverNameConfigSet(client As WebTerminal.Engine, value As %String = "") As %Status
{
    set ^WebTerminal("Name") = value
    do client.Send(, 1)
    return $$$OK
}

ClassMethod SQL(client As WebTerminal.Engine, data As %ZEN.proxyObject = "") As %Status
{
    new $Namespace
    set $Namespace = client.childNamespace
    set sql = data.sql
    set max = $case(data.max = "", 1: 777, :data.max)
    set obj = ##class(%ZEN.proxyObject).%New()
    
    SET tStatement = ##class(%SQL.Statement).%New()
    SET st = tStatement.%Prepare(sql)
    if (st '= $$$OK) {
        set obj.error = "%badSQL("_$System.Status.GetErrorText(st)_")"
        return client.Send(, obj)
    }
    SET rset = tStatement.%Execute()
    if (rset.%SQLCODE '= 0) {
    	set obj.error = "%sqlErr(SQLCODE="_rset.%SQLCODE_"; "_rset.%Message_")"
    	return client.Send(, obj)
    }

	set headers = ##class(%ListOfDataTypes).%New()
	for i=1:1:tStatement.%Metadata.columns.Count() {
		do headers.Insert(tStatement.%Metadata.columns.GetAt(i).colName)
	}

	set dt = ##class(%ListOfDataTypes).%New()
	while rset.%Next() {
		if (rset.%ROWCOUNT > max) quit
		set line = ##class(%ListOfDataTypes).%New()
		for i=1:1:headers.Count() {
			do line.Insert(rset.%GetData(i))
		}
		do dt.Insert(line)
	}

	set:(dt.Count() > 0) obj.data = dt
	set:(headers.Count() > 0) obj.headers = headers
	
    do client.Send(, obj)
    return $$$OK
}

ClassMethod Trace(client As WebTerminal.Engine, data As %ZEN.proxyObject = "") As %Status
{
    set obj = ##class(%ZEN.proxyObject).%New()
    set obj.OK = 1
    set obj.started = client.Trace(data)
    if (obj.started '= 1) {
        set obj.stopped = client.StopTracing(data)
        if (obj.stopped '= 1) {
            set obj.OK = 0
        }
    }
    do client.Send(, obj)
    return $$$OK
}

ClassMethod StopTracing(client As WebTerminal.Engine, data As %ZEN.proxyObject = "") As %Status
{
    set obj = ##class(%ZEN.proxyObject).%New()
    set obj.OK = $LISTLENGTH(client.Watches) > 0
    while ($LISTLENGTH(client.Watches) > 0) {
        set stopped = client.StopTracing($LIST(client.Watches, 1))
    }
    do client.Send(, obj)
    return $$$OK
}

ClassMethod TracingStatus(client As WebTerminal.Engine, data As %ZEN.proxyObject = "") As %Status
{
    set obj = ##class(%ZEN.proxyObject).%New()
    set oldWatch = client.Watches
    set obj.changes = client.CheckTracing()
    set obj.stop = ##class(%ZEN.proxyObject).%New()
    if ($LENGTH(oldWatch) > $LENGTH(client.Watches)) {
        for i=1:1:$LISTLENGTH(oldWatch) {
            if ($LISTFIND(client.Watches, $LISTGET(oldWatch, i)) = 0) {
                set $PROPERTY(obj.stop, $LISTGET(oldWatch, i)) = 1
            }
        }
    }
    do client.Send(, obj)
    return $$$OK
}

ClassMethod Auth(client As WebTerminal.Engine, data As %ZEN.proxyObject = "") As %Status
{
    // This method is implemented in Engine class. In case of auth is off, this method handles
    // the auth request and never respond (like when you send something to /dev/null).
    return $$$OK
}

ClassMethod Interrupt(client As WebTerminal.Engine, data As %ZEN.proxyObject = "") As %Status
{
    // The interrupt behavior is implemented in Execute class method. When the user presses Ctrl+C
    // in normal mode, we will do *nothing*.
    return $$$OK
}

}
