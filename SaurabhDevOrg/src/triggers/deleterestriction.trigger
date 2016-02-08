trigger deleterestriction on invoice__c (before delete) {
    
    
    set<id> id1= trigger.oldMap.keyset();
    list<invoice__c>  ll= [select i.name,(select name from line_items__r) from invoice__c i where i.id IN: id1];    
    for(invoice__c  inv :ll)
    {
        if(!inv.line_items__r.isEmpty())
        {
            
            trigger.oldMap.get(inv.id).addError('invoice name'+inv.Name+'can not be deleted as it has some line item atttached with it');
            
        }
        
    }
    
}