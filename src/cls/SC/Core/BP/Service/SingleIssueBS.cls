/*
Copyright (c) 2022 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class SC.Core.BP.Service.SingleIssueBS Extends Ens.BusinessService
{

Method OnProcessInput(pInput As SC.Core.BP.Message.IssueAnalysisRequest, Output pOutput As Ens.Response) As %Status
{
    set sc = $$$OK
    set sc = ..SendRequestSync(pInput.targetProcess, pInput, pOutput,5)
    return sc
}

}
