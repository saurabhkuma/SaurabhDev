trigger uniqueemail on borrower__c (before insert) {
    for(borrower__c b: Trigger.New )
    {
        List<borrower__c> blist= [select email_id__c, Name from borrower__c];
        for(borrower__c b1:blist)
        {
            if(b1.email_id__c==b.email_id__c)
            {
                b.addError('this email id is already associated with   '+b1.Name);
            }
            
        }
        
    }

}