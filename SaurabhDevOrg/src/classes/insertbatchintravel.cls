global with sharing class insertbatchintravel implements database.Batchable<sObject>
	{
global insertbatchintravel()
{

}
	
	

   global Database.QueryLocator start(Database.BatchableContext BC){
       list<travel_booking__c> updatetravel= new list<travel_booking__c>();
     
       
        return Database.getQueryLocator('select id from borrower__c');
   }     
   global void execute(Database.BatchableContext info, 
                        List<borrower__c> scope){
        List<travel_booking__c> invsToUpdate = new  List<travel_booking__c>();
      
       for(borrower__c c:scope){ 
           for(integer i=0;i<100;i++)
       {
           travel_booking__c tr= new travel_booking__c();
           tr.bookedby__c=  c.id;
           tr.booking_date__c= Date.today()+i;
           tr.journey_date__c = Date.today()+7;
           invsToUpdate.add(tr);
           
       }
       } 
      insert invsToUpdate; 
   }     
   global void finish(Database.BatchableContext info){
   	system.debug('finished hit');
   } 


}