ROUTINE FCE [Type=INC]
#; helpful macros for FCE application	

/// does class exist?
#define ClassExists(%class) ##class(%Dictionary.ClassDefinition).%ExistsId(##quote(%class))

/// does property exist?
#define PropertyExists(%class,%property) ##class(%Dictionary.PropertyDefinition).%ExistsId(##quote(%class||%property))

/// does method exist?
#define MethodExists(%class,%method) ##class(%Dictionary.MethodDefinition).%ExistsId(##quote(%class||%method))

/// does trigger exist?
#define TriggerExists(%class,%trigger) ##class(%Dictionary.TriggerDefinition).%ExistsId(##quote(%class||%trigger))