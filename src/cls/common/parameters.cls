Class common.parameters
{

ClassMethod Get(param As %String = "name") As %String
{
        return $get(^GLOBAL(param))
}

/// Description

}
