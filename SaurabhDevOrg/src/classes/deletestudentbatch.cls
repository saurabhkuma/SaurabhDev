global with sharing class deletestudentbatch  implements database.batchable<sObject>
{
	
	global database.Querylocator start(Database.batchableContext bc)
	{
		
		string query= 'select id from student__c limit 6';
		return database.getQueryLocator(query);
		
		
	}
	
	
	global void execute(database.BatchableContext bc, list<student__c> scope)
	{
		
		system.debug('in execute');
		delete scope;
		database.emptyRecycleBin(scope);
		system.debug('after execute');
	} 
	
	global void finish(database.BatchableContext bc)
	{
		
		system.debug('in finish');
	}

}