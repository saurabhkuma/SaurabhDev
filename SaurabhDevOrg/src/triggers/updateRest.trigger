trigger updateRest on Account (after update) {
	
	List<Account> accforupdate= [select id,extId__c from Account where id IN :Trigger.oldMap.KeySet()];
	for(Account a: accforupdate)
	{
		restCRUD.updateAccount(a.extId__c,a.id);
	}

}