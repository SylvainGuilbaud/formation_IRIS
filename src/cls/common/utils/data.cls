Class common.utils.data
{

ClassMethod Connect(serverIP = "192.168.0.9", serverPORT = 1972, namespace = "USER", username = "_SYSTEM", password = "SYS") As %Net.DB.Iris
{
  try {
    set con=##class(%Net.DB.DataSource).CreateConnection(serverIP
                           ,serverPORT
                           ,namespace,username,password)
                           
    set rem=con.CreateIris()
    }
  catch { zw  b  }
  set %rccdb=rem
  quit rem
}

ClassMethod Copy(global As %String = "", fromsubscript As %List = "", tosubscript As %List = "", rename As %String = "")
{
#dim %rccdb as %Net.DB.Iris
 set subs=..Args(fromsubscript)
 set stop=..Args(tosubscript)
 set:'$l(rename) rename=global 
loop w global_subs,! 
 set x1="(global,subs) quit %rccdb.IsDefined(global"_subs_")"
  , dd=$xecute(x1,global,subs)
 if dd#10 {
   set x2="(global,subs) quit %rccdb.Get(global"_subs_")"
    , val=$xecute(x2,global,subs)
    , x3="(val) set "_rename_"=val q 1 "
   if $l(subs) set x3="(val) set "_rename_"("_$e(subs,2,*)_")=val q 1 "
   if $xecute(x3,val) 
   }
up
 set down=subs_$s(dd\10:",""""",1:"")
 set x4="(global,down) quit %rccdb.GetNext(1,0,0,global"_down_")" 
   , nxsub=$xecute(x4,global,down)  
 if nxsub="" {
   set subs=$p(subs,",",1,*-1),dd=0
   goto up
   } 
 if '$isvalidnum(nxsub) set nxsub=""""_nxsub_""""
 set $p(subs,",",*+(dd\10))=nxsub   
 if $l(subs,",")<2 quit 1
 if subs]]stop quit 1
 goto loop
}

ClassMethod Args(list As %List = "") As %String
{
  set ll=$ll(list),subs=""
  for i=1:1:ll {
    set sub=$li(list,i)
      , subs=subs_","_$s($isvalidnum(sub):sub,1:""""_sub_"""")
  }
  quit subs
}

}
