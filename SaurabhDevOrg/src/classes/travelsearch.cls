public with sharing class travelsearch {  
   public list <travel_booking__c> travel {get;set;}  
   public string searchstring {get;set;}  
    public Date  journeydate {get;set;}
    public string bustype {get;set;}
    public string type1 {get;set;}
    private boolean isEdit = false;
    
   public travelsearch(ApexPages.StandardController controller) {  
   type1=null;
   }  
   public pageReference search(){  
  string searchquery='select Name,id,bookedby__c,pic_up_venue__c from travel_booking__c where booking_status__c like \'%'+searchstring+'%\' and journey_date__c =:journeydate and bus_type__c like \'%'+bustype+'%\'  Limit 20';  
     travel= Database.query(searchquery); 
     type1=null; 
     isEdit=true;
     return null;
     
  
   }  
   
     
   public boolean getisEdit()
   {
   return isEdit;
   }  
   
   
   public void clear(){  
   travel.clear(); 
     isEdit=false;  
   } 
   
   
    
   public  pageReference genpdf()
    {
   
        PageReference pdf =  Page.search1;
        
        
        type1='pdf';
        return pdf;
        
    }
    public pageReference invoicesearch()
    {
    return page.search2;
    }
    public string getChooserender() {
    
    return type1;
       
  }
    
 }