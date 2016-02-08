global with sharing class deletetravel implements database.Batchable<sObject>
	{
		
		
		
	 global Database.QueryLocator start(Database.BatchableContext BC)
	 {  
	 	return Database.getQueryLocator('select name,id from travel_booking__c where day_in_month(journey_date__c)=26');
     }     
   
   
   
   
     global void execute(Database.BatchableContext info,List<travel_booking__c> scope)
     {
       
       delete scope;
       system.debug('in delete');
       database.emptyRecycleBin(scope);
     }     
    global void finish(Database.BatchableContext info)
     {
    	system.debug('finished hit');
     } 


}