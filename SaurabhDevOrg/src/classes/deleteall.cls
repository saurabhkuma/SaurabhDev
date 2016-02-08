global class deleteall {

    
    webservice static string del(String invoice)
    {
         SObject ss= [select name  from invoice__c where name=:invoice];
        
       
        try
        {
            delete ss;
        }
        
        
        catch(DmlException e)
        {
            return e.getMessage();
        }
        
    return 'your invoice is successfully deleted';
    
    }    
    
    

}