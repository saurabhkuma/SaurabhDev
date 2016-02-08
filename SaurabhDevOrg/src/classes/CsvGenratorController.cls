public with sharing class CsvGenratorController {

    public PageReference getCsv() {
    
   
    PageReference demoPage = new pagereference('/apex/csvfile');
    demoPage.setRedirect(false);
    return demoPage;
        
         }

        
        
       public static  map<String, Schema.Sobjecttype> allSObjects = schema.getGlobalDescribe();
        public string selectedsobj{get; set;}
        public list<string> selectedfields {get; set;}
        public list<selectOption> allfields{get; set;}
        public list<WrapperSobject> allrecords {get; set;}
        public boolean showselectfield{get{
        if(showselectfield==true)
        return true;
        else
        return false;
        
        
        }  set;}
        public string contentType{get{
        if(contentType==''||contentType==null)
        return  '';
        else
        return contentType;
        
        }
        
        
         set;}
        public boolean showrecords{get; set;}
        
        
        public class LableAndValue {
        
         public string name {get; set;}
         public string value{get; set;}
        
        }
        
        public class WrapperSobject{
        
        
        public list<LableAndValue> fields{get; set;}
        }
        
        public list<selectOption> getAllObj ()
        {
        
                
                List<selectOption> listsobj = new list<selectOption>();
                for(string s: allSObjects.keyset())
                {
                        listsobj.add(new selectOption( s, s));
                }
                
                return listsobj;
        }
        
        public PageReference getAllfields()
        {
                allfields = new list<selectOption>();
                showselectfield = true;
                for( string s :(schema.describeSobjects(new string[]{''+selectedsobj+''})[0]).fields.getMap().keyset())
                {
                   allfields.add(new selectOption(s,s));
                }
                
                return null;
        }
        
    
       public PageReference getRecords()
       {
         contentType = 'application/vnd.ms-excel#'+selectedsobj+'.xls';
         showrecords = true;
         String query = 'select ';
         for(String s : selectedfields )
         {  
            
            query = query +''+s+'   ,';
         }
         query = query.removeEnd(',');
         query = query + 'from  ' + selectedsobj +'';
         system.debug(query);
         
         list<sobject> records = database.query(query);
         allrecords = new list<WrapperSobject>();
         /*WrapperSobject label = new WrapperSobject();
         label.fields= selectedfields;
         allrecords.add(label);*/
         
         
         
         
           WrapperSobject recordl = new WrapperSobject();
           recordl.fields = new list<LableAndValue>();
           for( integer i= 0; i<selectedfields.size(); i++)
           {
              LableAndValue lav = new LableAndValue();
              lav.name = selectedfields[i];
              lav.value = selectedfields[i];
              recordl.fields.add(lav);
             //record.fields.add( '' +sobj.get(''+selectedfields[i]+''));
           }
           
           allrecords.add(recordl);
         
         for( sObject sobj : records)
         { 
           WrapperSobject record = new WrapperSobject();
           record.fields = new list<LableAndValue>();
           for( integer i= 0; i<selectedfields.size(); i++)
           {
              LableAndValue lav = new LableAndValue();
              lav.name = selectedfields[i];
              lav.value = '' +sobj.get(''+selectedfields[i]+'');
              record.fields.add(lav);
             //record.fields.add( '' +sobj.get(''+selectedfields[i]+''));
           }
           
           allrecords.add(record);
         }
         return null;
       
       }
       
       //code for remote action
       @RemoteAction
       public static string getAllSobjects()
       {
        
              List<String> sObjectResult = new list<String>();
                for(string s: allSObjects.keyset())
                {
                       
                       sObjectResult.add(s);
                }
                
              String jsonsObjectResult = json.serialize(sObjectResult);
              
        return '{\"Records\":'+jsonsObjectResult+',\"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + sObjectResult.size() + '\"}';
        
       }
       
       @RemoteAction
       public static string getAllFields(string sobjectname)
       {
        
         List<LableAndValue> sObjectFieldsResult = new list<LableAndValue>();
        for( string s :(schema.describeSobjects(new string[]{sobjectname})[0]).fields.getMap().keyset())
                {
                      LableAndValue lav = new LableAndValue();
                       lav.name = s;
                       lav.value = s;
                       sObjectFieldsResult.add(lav);
                }
                
             String jsonssObjectFieldsResult = json.serialize(sObjectFieldsResult);
              
        return '{\"Records\":'+jsonssObjectFieldsResult+',\"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + sObjectFieldsResult.size() + '\"}';   
        
       }
       
       
        @RemoteAction
       public static string getAllRecords(list<string> fieldsname, string sobjectname)
       {
           String query = 'select ';
          for(String s : fieldsname )
         {  
            
            query = query +''+s+'   ,';
         }
         query = query.removeEnd(',');
         query = query + 'from  ' + sobjectname +'';
          system.debug(query);
         
          list<sobject> records = database.query(query);
        
                
             String jsonsrecords = json.serialize(records);
              
        return '{\"Records\":'+jsonsrecords+',\"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + records.size() + '\"}';   
        
       }
  
}