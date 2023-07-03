Class Good.VendorInfo [ ClassType = view, CompileAfter = (Good.SPMRMA, Good.TBL), DdlAllowed, Owner = {_SYSTEM}, Not ProcedureBlock, SqlTableName = VendorInfo, ViewQuery = { 
    
    SELECT S.VendorNum, S.num, T.VendorName
 	FROM Good.SPMRMA S JOIN Good.TBL T On S.VendorNum = T.VendorNum} ]
{

}
