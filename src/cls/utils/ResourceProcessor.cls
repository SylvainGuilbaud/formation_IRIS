/*
Copyright (c) 2023 by InterSystems Corporation.
Cambridge, Massachusetts, U.S.A.  All rights reserved.
Confidential property of InterSystems Corporation.
*/

Class utils.ResourceProcessor Extends %ZPM.PackageManager.Developer.Processor.Default.Package
{

/// Subclasses may override to customize resource load behavior during the Reload phase. <br />
/// @Argument	pFullResourcePath			The absolute path to the resource present on the file system
/// @Argument	pVerbose					1: display output from loading files, 0: do not display output
/// @Argument	pCompile					1: compile files upon load, 0: do not compile files
/// @Argument	pLoadedList					Output: comma delimited list of files that have been loaded
Method OnLoad(pFullResourcePath As %String, pVerbose As %Boolean, pCompile As %Boolean = 0, Output pLoadedList As %String, ByRef pParams As %String) As %Status
{
	Set pLoadedList = ""
	Set sc = $$$OK
	Try {
        Set flags = $Select(pVerbose:"/display",1:"/nodisplay")_
            $Select(pCompile:"/compile",1:"/nocompile")_
            "/multicompile=0"

        // First pass: see what would be loaded
        $$$ThrowOnError($System.OBJ.ImportDir(pFullResourcePath, "*", flags, , 1, .toLoad, 1 /* List-Only */))

        // Prune things that already exist
        Set key = ""
        For {
            Set key = $Order(toLoad(key))
            Quit:key=""
            Set class = $Piece(key,".",1,*-1) // Strip trailing .cls
            If '$$$comClassDefined(class) {
                Set selectedList(key) = ""
            }
        }

        If '$Data(selectedList) {
            // Nothing to load.
            Quit
        }

        // Second pass: only load things that don't exist
        $$$ThrowOnError($System.OBJ.ImportDir(pFullResourcePath, "*", flags, , 1, .pLoadedList, 0, .selectedList))
    } Catch e {
        Set sc = e.AsStatus()
    }
    Quit sc
}

Method OnPhase(pPhase As %String, ByRef pParams, Output pResourceHandled As %Boolean = 0) As %Status
{
	If (pPhase = "Compile") {
        // Workaround: if we're using this, we *need* storage to be able to change during compilation.
        // Only solution is to turn off this check for all module compilation.
        If $Data($$$BuildFlag) {
            Kill $$$BuildFlag
        }
    }
    Quit ##super(pPhase,.pParams,.pResourceHandled)
}

}
