global with sharing class combocontroller {

public string obj{get; set;}

@RemoteAction
global static List<SelectOption> getallObj()
{
 List<Schema.SobjectType> aso = Schema.getGlobalDescribe().Values();
 List<SelectOption> allso = new List<SelectOption>();
 for(Schema.SObjectType  f : aso)
 {
 
 SelectOption so = new SelectOption( f.getDescribe().getLabel(),f.getDescribe().getLabel());
 allso.add(so);
 
 }

return allso;
}



}