trigger onOpportunityWon on Opportunity (after update) {
Set<Id> relevantIds = new Set<Id>();
    // select relevant opportunities which stageName is changing to Closed won
    for(Opportunity o : trigger.new)
    {
        if(o.StageName == 'Closed Won' )
        {
            relevantIds.add(o.Id);
            system.debug(o.id);
        }
    }

    // Line Items
    list<OpportunityLineItem> oliall  = [SELECT ID, WonWhen__c, OpportunityId FROM OpportunityLineItem WHERE OpportunityId IN :relevantIds];
    for(OpportunityLineItem oli :oliall )
    {
         
        oli.WonWhen__c = system.today(); // putting today date in wonwhen_c field of opplineitem
        
    }

if (oliall.size()>0)
    update oliall;
}