public with sharing class actionpollarcontroller {
  
   public Datetime currenttime{get;set;}
    public void changetime() {
      currenttime= system.now();
      
    }

}