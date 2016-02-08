trigger startdateupdation on Opportunity (after update,after insert) {
    
    set<Id> allId = new set<Id>();
    
    
   //checking which opportunity closed date changes
    for(Opportunity o : Trigger.new)
    {
        if( o.CloseDate != trigger.oldMap.get(o.Id).CloseDate )
            allId.add(o.Id);
        
        }
     //retrived all oppertunityLineItem associated with every triggered opportunity whose close date changes 
    list<OpportunityLineItem>  opplItem = [select id, name,ServiceDate,time_period__c,Opportunity.CloseDate from opportunityLineItem where opportunity.id  IN :allId];
    
    for( OpportunityLineItem  ol : opplItem)
    {
        system.debug(ol.time_period__c);
        Integer timed = (Integer)ol.time_period__c; //updating  the product start date according to opportunity close date changes
        system.debug(timed);
        ol.serviceDate = ol.Opportunity.CloseDate.addDays(timed);
        
    }
    update opplItem;
}