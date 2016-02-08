public with sharing class StudentReportController {

  

    public   boolean promoted{get; set;}
    public  string behaviour {get; set;}
    public  integer score {get; set;}
    public  integer leadershippoint{get; set;}
    public list<selectOption> behaviourallist {
    
    get{
      list<selectOption> behaviourallist = new list<selectOption>();
    behaviourallist.add(new selectOption('good','good'));
    behaviourallist.add(new selectOption('excellent','excellent'));
    behaviourallist.add(new selectOption('bad','bad'));
    behaviourallist.add(new selectOption('moderate','moderate'));
    
    return behaviourallist;
    }
    }
    public list<selectOption> scorelist {
    
    get{
     list<selectOption> scorelist = new list<selectOption>();
     scorelist.add(new selectOption('10','10'));
     scorelist.add(new selectOption('20','20'));
     scorelist.add(new selectOption('30','30'));

     scorelist.add(new selectOption('40','40'));

    scorelist.add(new selectOption('50','50'));
    scorelist.add(new selectOption('60','60'));
    scorelist.add(new selectOption('70','70'));
    scorelist.add(new selectOption('80','80'));
    scorelist.add(new selectOption('90','90'));
    scorelist.add(new selectOption('100','100'));
    return scorelist;
    }
   
     }
    
  public list<selectOption> leadershippoints {
    
    get{
     list<selectOption> scorelist = new list<selectOption>();
     scorelist.add(new selectOption('1','1'));
     scorelist.add(new selectOption('2','2'));
     scorelist.add(new selectOption('3','3'));

     scorelist.add(new selectOption('4','4'));

    scorelist.add(new selectOption('5','5'));
    scorelist.add(new selectOption('6','6'));
    scorelist.add(new selectOption('7','7'));
    scorelist.add(new selectOption('8','8'));
    scorelist.add(new selectOption('9','9'));
    scorelist.add(new selectOption('10','10'));
    return scorelist;
    }
   
     }


    
    
    
    public  student_remark__c remark{get; set;}
    
  

    public StudentReportController(ApexPages.StandardSetController controller) {

    }
    
    public StudentReportController()
    {
       remark = new student_remark__c();
    }
    
      @RemoteAction
      public static pageReference saveRecord( string name, string teachername,integer leadershippoint,string behaviour, integer score, boolean promoted  ){
      system.debug(promoted+''+score);
      student_remark__c newremark = new student_remark__c();
      newremark.Name= name;
      Account acc = [select id from Account where name= :teachername limit 1];
      newremark.classTeacher__c= acc.id;
      newremark.leadership_skill__c= leadershippoint;
      newremark.behavioural_remark__c=behaviour;
      newremark.score__c= score;
      newremark.Studentpramote__c= promoted;
      try
      {
      insert newremark;
       PageReference pageref = new PageReference('/');
       pageref.getParameters().put('id', newremark.id);
       pageref.setRedirect(true);
      return pageref;
      }
      catch(DmlException e )
      {
      return null;
       }
    }
    

}