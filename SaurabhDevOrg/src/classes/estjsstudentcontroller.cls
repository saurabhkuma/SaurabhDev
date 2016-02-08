global with sharing class estjsstudentcontroller {

        global static list<student__c> studlist = new list<student__c>();
        
        @RemoteAction
        global static void savestudent(String name1,String city ,String date1)
                 {
                    Student__c st = new Student__c();
                    st.city__c = city;
                    st.name__c = name1;
                    st.admission_date__c = Date.parse(date1);
                    insert st;
        
                 }
        
        @RemoteAction
        global static string updatestudent(String Id1, String name,String city ,String date1)
                 {
                     if(id1 != null)
                           {
                                 Student__c upt = [select name__c,city__c from student__c where id =:id1];
                                 upt.city__c =city;
                                 upt.name__c = name;
                                 system.debug(date1); 
                                 upt.admission_date__c = Date.parse(date1);
                                  
                                 update upt;
                                 return 'success';
                            }
                        
                        else
                        return 'mention id if you want to update';
                }
        
        @RemoteAction
        global static string searchstudent()
                    {
                    
                         studlist = [select name__c,city__c ,Id from student__c ];
                        
                        String  jsonstudlist = JSON.serialize(studlist);
                        return '{\"Records\":'+jsonstudlist+',\"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + studlist.size() + '\"}';
                    
                    }
        @RemoteAction
        global static string searchPerticualrStudent(string id1)
                    {
                    
                    
                        Student__c st = [select name__c,city__c,admission_date__c from student__c where id =:id1];
                        string stjson = JSON.serialize(st);
                        return '{\"Records\":'+stjson+',\"error\": \"null\", \"status\":\"SUCCESS\"}';
                    
                    
                    }
        @RemoteAction
        global static string searchText(string text1,string objectNames)   
        {
        	system.debug(text1);
        	list<list<sobject>> lobj = new list<list<sobject>>();
        	integer first = objectNames.indexOf('[', 0);
        	integer second = objectNames.indexOf(']');
        	system.debug(first+''+second);
        	string objectNames1 = objectNames.substring(first+1, second);
        	string objectNames2 = objectNames1.replace(',', '(id,name),');
        	system.debug(objectNames2);
        	string search1 = 'FIND \''+text1+'*\' IN All FIELDS RETURNING '+objectNames2+'(id,name)';
        	lobj = search.query(search1);
        	system.debug(lobj);
        	integer size1 = lobj.size();
        	string jsonlobj = JSON.serialize(lobj);
        	return '{\"Records\":'+jsonlobj+',\"error\": \"null\", \"status\": \"success\",\"length\":'+size1+'}';
        	
        }     

}