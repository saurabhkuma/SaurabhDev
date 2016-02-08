public with sharing class AngularForm1Controller {
	 private Account a;

    public String accountJson {get;set;}
    public String AccountList { get; set; }
    
    //Subclass : Wrapper Class 
    public class Accountwrap {
        //Static Variables 
        public string id;
        public string name;
        public string Phone;
        
        //Wrapper  Class Controller
        Accountwrap() {
            Phone = '';
        }
        
    }
    
       

    public  AngularForm1Controller(ApexPages.StandardController controller) {

        a = (Account) controller.getRecord();

        accountJson = JSON.serializePretty(a);

    }

     

    public void save() 

    {

        a = (Account)JSON.deserialize(accountJson, Account.class);

        upsert a;

    }
	
	
	//Method to bring the list of Account and Serialize Wrapper Object as JSON
    public  static String getlstAccount() {
        List < Accountwrap > lstwrap = new List < Accountwrap > ();
        List < account > lstacc = [SELECT Id, Name, Phone
                                   FROM Account limit 100
                                  ];
        for (Account a: lstacc) {
            Accountwrap awrap = new Accountwrap();
            awrap.id = a.id;
            awrap.name = a.name;
            if (a.Phone != null) {
                awrap.Phone = a.Phone;
            }
            lstwrap.add(awrap);
        }
        return JSON.serialize(lstwrap);
     }
     
     @RemoteAction
     public static string saveStudent(String name)
     {
       	
     	student__c stud= new student__c();
     	stud.name__c = name;
     	string result = '';
     	try{
     		insert stud;
     		result = 'success';
     	}
     	catch(DmlException d)
     	{
     		result = 'failure';
     	}
     	return result;
     }

}