public with sharing class invoicesearch {
    
    public  list<invoice__c> allinvoice ;
    public  list<line_item__c> lineitem {get; set;}
    public  string  invname {get; set;}
    
    public invoicesearch(Apexpages.StandardController controller)
    {
      string query1= 'select name, id  from invoice__c';
        allinvoice= database.query(query1);
    }
    public invoicesearch()
    {
      string query1= 'select name, id  from invoice__c';
        allinvoice= database.query(query1);  
    }
    
    public void  fetch ()
    {
         system.debug(invname);
        string query2= 'select name, quantity__c from line_item__c where invoice__c=:invname';
        lineitem= database.query(query2);
    }
    
    public  list<SelectOption> getinvoicelist()
    {
    list<selectoption> opt= new list<selectoption>();
    for(invoice__c c:allinvoice)
    {
        system.debug(c.name);
    opt.add(new SelectOption(c.id,c.name));
    }
    return opt;
    }
}