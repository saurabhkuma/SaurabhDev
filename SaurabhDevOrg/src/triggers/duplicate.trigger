trigger duplicate on Books__c (before insert,before update) {
    for(Books__c bb: Trigger.new)
    {
        if(bb.bookname__c !=null)
        {
            List<Books__c>  b = [select writername__c from Books__c where bookname__c=:bb.bookname__c];
            for(Books__c b1: b)
            {
                if(b1.writername__c==bb.writername__c)
                    
                   // String  error = 'you are entering dubplicate book';
                bb.addError('you are entering dubplicate book');
                
            }
           
        }
    }

}