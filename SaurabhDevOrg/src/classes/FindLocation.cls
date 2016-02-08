global with sharing class FindLocation {
         
         public static string companyId {get; set;}
         public Static List<company_location__c> clist{get;set;}
         public static Decimal latitude {get; set;}
         public static Decimal longitude {get; set;}

    public FindLocation(ApexPages.StandardController controller) {
    
    if(controller ==null)
    return ;
    
    company_location__c comploc = (company_location__c)(controller.getrecord());
    if(comploc==null ||comploc.id==null)
    return;
    companyId = comploc.id;
    company_location__c controllercompanyobj = [select id,name,cybagelocation__Latitude__s,cybagelocation__Longitude__s from company_location__c where id = :companyId];
    latitude = controllercompanyobj.cybagelocation__Latitude__s;
    longitude = controllercompanyobj.cybagelocation__Longitude__s;

    }

        
        
        
        /*@RemoteAction
        global static List<company_location__c>  findAll()
        {
                return [select id,name,cybagelocation__Latitude__s,cybagelocation__Longitude__s from company_location__c];
        }
        
        
        */
      
        @RemoteAction
        global static List<company_location__c>  findAll(string companyId1)
        {
                system.debug(companyId1);
                if(companyId1==null ||companyId1=='')
                return [select id,name,cybagelocation__Latitude__s,cybagelocation__Longitude__s from company_location__c ];
                else
                {
                list<company_location__c>  complist = new list<company_location__c>();
                company_location__c com = [select id,name,cybagelocation__Latitude__s,cybagelocation__Longitude__s from company_location__c where id = :companyId1];
                complist.add(com);
                return complist;
                
                }
        }

}