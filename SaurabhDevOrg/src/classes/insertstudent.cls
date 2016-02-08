global with sharing class insertstudent implements database.Batchable<student__c>
{
	//start method for creating a list of studet and returning as iterable
	global iterable<student__c> start( Database.BatchableContext bb)
	{
		list<student__c> lstudent = new list<student__c>();
		for(integer i=0;i<5;i++)
		 {
		 	student__c s = new student__c();
		    s.name__c='saurabh';
		    s.city__c='pune';
		    s.admission_date__c= date.today()+1;
		    lstudent.add(s);
		 }
		 
		 system.debug('in start');
		 return lstudent;
		
	}
	
	
	//execute method start  accepting student list as argument and inserting on database
	
	global void execute(Database.BatchableContext bb, list<student__c> scope)
	{
		system.debug('in execute');
		insert scope;
		
	}
	
	//finish method start
	global void finish(Database.BatchableContext bb)
	{
		system.debug('in finished');
	}
 	
	

}