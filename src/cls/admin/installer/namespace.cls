Include %occInclude

Class admin.installer.namespace
{

XData Install [ XMLNamespace = INSTALLER ]
{
<Manifest>
    <!-- <Log Text="Version d'IRIS ${VERSION}" Level="0"/> -->
    <!-- Check if NameSpace variable is valued -->
    <If Condition='$L("${NAMESPACE}")=0'>
        <Error Status="5001">
            <Arg Value="Le nom de l'espace de noms est obligatoire"/>
        </Error>
    </If>
    <If Condition='$L("${DATABASEDIR}")=0'>
        <Error Status="5001">
            <Arg Value="Le répertoire des bases de données est obligatoire"/>
        </Error>
    </If>
    <If Condition='$L("${INTEROP}")=0'>
        <Var Name="INTEROP" Value="0" />
    </If>
    <!-- If exist do nothing, else create namespace -->
    <If Condition='(##class(Config.Namespaces).Exists("${NAMESPACE}")=0)'>
        <!-- <Log Text="Creating namespace ${NAMESPACE}" Level="0"/> -->

        <!-- temp hack, our data database goes into pre-existing and persisted USER database -->
        <Namespace Name="${NAMESPACE}" Create="yes" Code="${NAMESPACE}_SRC" Ensemble="${INTEROP}" Data="${NAMESPACE}_DATA">
            <Configuration>
                <!-- sources are not presisted but kept in the container/image (done on purpose) -->
                <Database Name="${NAMESPACE}_SRC" Dir="${DATABASEDIR}${NAMESPACE}_SRC" Create="yes" Resource="%DB_${NAMESPACE}_SRC"/>
                <Database Name="${NAMESPACE}_DATA" Dir="${DATABASEDIR}${NAMESPACE}_DATA" Create="yes" Resource="%DB_${NAMESPACE}_DATA"/>
            
            </Configuration>
        
            <!-- Need to create equivalent value of Default application for [NAMESPACE]: /csp/healthshare/[namespace], see Edit Web application window in portal -->
            <CSPApplication Url="/csp/${NAMESPACE}" Directory="${CSPDIR}/${NAMESPACE}" AuthenticationMethods="64" IsNamespaceDefault="true" />
            <!--<Import File="/Users/guilbaud/git/training-iris/src/cls/training" Flags="ck-d" IgnoreErrors="true" Recurse="true"/>
            <Production Name="training.prod.NewProduction" AutoStart="true" >
                 <Setting Item="training.service.REST"
                          Target="Item"
                            Setting="PoolSize"
                            Value="0" />
                  <Setting Item="training.service.REST"
                          Target="Item"
                            Setting="Enabled"
                            Value="true" />  
                   <Setting Item="training.service.REST"
                          Target="Item"
                            Setting="Host"
                            Value="training.service.REST" />             
                            </Production>
                            --> 
        </Namespace>


    </If>


</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 0, pInstaller As %Installer.Installer) As %Status [ CodeMode = objectgenerator, Internal ]
{
	
     Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "Install")
}

}
