trigger deleteWithRest on Account (before delete) {
	
	List<Account> acList= [select name,extId__c from Account where id IN :Trigger.oldMap.KeySet()];
	
	for(Account acc: acList)
	{
		restCRUD.deleteAccount(acc.extId__c);
		
	}

}