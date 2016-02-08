global class invoiceutility {
    
  webservice static string renumberLine(String invoice)
    {
      system.debug(invoice);
       // invoice__c c= [Select Name ,id from invoice__c where name=:invoice];
    //List<Line_Item__c> lineitem = [select j.Name   from Line_Item__c j  where   j.invoice__c= c.id];
      invoice__c inv= [select i.name ,(select name from Line_Items__r ORDER by name) from invoice__c i 
                      where i.name=:invoice];
        
        integer i1=100;
        
        
        for(Line_Item__c  l: inv.line_items__r)
        {
         l.name= String.valueOf(i1);
            System.debug(l.name);
            i1++;
        }
        
        try
        {
            Database.update(inv.line_items__r);
        }
        
        
        catch(DmlException e)
        {
            return e.getMessage();
        }
        
    return 'your invoice is successfully renumbered';
    
    }    
    
    

}