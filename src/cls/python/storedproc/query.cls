Class python.storedproc.query Extends %RegisteredObject
{

/// Ref: Defining and Using Class Queries
/// https://docs.intersystems.com/iris20232/csp/docbook/DocBook.UI.Page.cls?...
/// <example>
/// do $SYSTEM.SQL.Shell()
/// call alwo.PyProcTest_GetNotes('D')
/// </example>
Query GetNotes(tabName As %String) As %Query(ROWSPEC = "Tab:%String,NoteId:%Integer,NoteText:%String") [ SqlName = PyProcTest_GetNotes, SqlProc ]
{
}

/// ObjectScript due to ByRef signature
ClassMethod GetNotesExecute(ByRef qHandle As %Binary, tabName As %String = "") As %Status
{
  set qHandle=##class(alwo.PyNote.GetNotes.qHandle).%New()
  // Note that an empty string passed from SQL statement may appear as the null character $C(0) instead of empty string ""
  set:tabName'=$C(0) qHandle.selectedTab=tabName // may be empty string
  Quit $$$OK
}

/// ObjectScript due to ByRef signature
ClassMethod GetNotesFetch(ByRef qHandle As %Binary, ByRef Row As %List, ByRef AtEnd As %Integer = 0) As %Status [ PlaceAfter = GetNotesExecute ]
{
  set refRow=##class(alwo.PyNote.GetNotes.Row).%New()
 
  set status=..GetNotesFetchPy(.qHandle,.refRow)
  if qHandle.atEnd {
    set AtEnd=1
  } else {
    // repack output row to $List format
    set Row=$ListBuild(refRow.Tab,+refRow.NoteId,refRow.NoteText)
  }
  Quit status
}

/// Access to tabular view of global 2 keys deep with data at level 2 nodes
/// <example>
/// zwrite ^alwo.IndexBook
/// 
/// ^alwo.IndexBook("A",1)="abc"
/// ^alwo.IndexBook("A",2)="def"
/// ^alwo.IndexBook("B")=""
/// ^alwo.IndexBook("C")=""
/// ^alwo.IndexBook("D",1)="gef"
/// ^alwo.IndexBook("E",1)="ijk"
/// ^alwo.IndexBook("E",2)="lmn"
/// <example>
/// 
/// Required output
/// <example>
/// | Tab | NoteId | NoteText
/// --------------------------
/// | A   | 1      | abc
/// | A   | 2      | def
/// | B   | 0      |
/// | C   | 0      |
/// | D   | 1      | gef
/// | E   | 1      | ijk
/// | E   | 2      | lmn
/// --------------------------
/// </example>
ClassMethod GetNotesFetchPy(qHandle As alwo.PyNote.GetNotes.qHandle, pRow As alwo.PyNote.GetNotes.Row) As %String [ Language = python ]
{
import iris
import traceback
ret=iris.cls('%SYSTEM.Status').OK()
try:
  # based on the existance of defined nodes then iterate
  gname="^alwo.IndexBook"
  gIterator=iris.gref(gname)
  # Iterate on Key1 "Tab name" when Key2 "NoteId" was previously set to empty
  if (None==qHandle.currentPage) or (""==qHandle.currentPage):
    qHandle.currentTab=gIterator.order([qHandle.currentTab])
    # change of tab context
    if (None==qHandle.currentTab) or (qHandle.currentTab==""):  # no records
      qHandle.atEnd=True
      return ret
    # default open first tab if has values
    if qHandle.selectedTab==None or qHandle.selectedTab=="":
      qHandle.selectedTab=qHandle.currentTab
  pRow.Tab=qHandle.currentTab
  #x=10/0 # uncomment to demonstrate ZeroDivisionError handling
  # Iterate on Key2 "NoteId"
  if (qHandle.selectedTab==qHandle.currentTab):
    qHandle.currentPage=gIterator.order([qHandle.currentTab, qHandle.currentPage])
    if (qHandle.currentPage!=None) and (qHandle.currentPage!=""):
      pRow.NoteId=qHandle.currentPage
      pRow.NoteText=gIterator.get([qHandle.currentTab, qHandle.currentPage])
      # checks if current record was the last one
      next=gIterator.order([qHandle.currentTab, qHandle.currentPage])
      if (None==next) or (""==next):
        qHandle.currentPage=None  # causes iterate on Key1 on next method invocation
except Exception:
 pErrorMessage='alwo.PyProcTest::GetNotesFetchPy:'+(traceback.format_exc())
 return iris.cls('%SYSTEM.Status').Error(2603,pErrorMessage)
return ret
}

/// ObjectScript due to ByRef signature
ClassMethod GetNotesClose(ByRef qHandle As %Binary) As %Status
{
  set qHandle=""
  Quit $$$OK
}
}




}
