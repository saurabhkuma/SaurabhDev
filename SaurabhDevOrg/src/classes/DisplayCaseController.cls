global Class DisplayCaseController{

@AuraEnabled
Public static list<Case> getCaseRecord(){
   List<Case> AllRecord;
   AllRecord = [select id,Subject,Description,Status from Case ];
 return AllRecord;

}  


@AuraEnabled
Public static Case getSingleCaseRecord(){
 
case  Record = [select id,Subject,Description,Status from Case limit 1 ];
return Record;

}  

@AuraEnabled
public static  Case  getCaseFromId(String  caseId)
{
    system.debug('case id is :'+caseId);
 // list<case> recordtoreturn = new list<case>();
   case record;
  if(caseId==null)
  {
     record =  [select id,Subject,Description,Status from Case limit 1 ];
  }
  else {
    record = [select id,Subject,Description,Status from Case where id = :caseId];
    if(record ==null)
    {
      record =  [select id,Subject,Description,Status from Case limit 1 ];
    }
  }
  
  //recordtoreturn.add(record);
  return record;
  }
    
  @AuraEnabled
   public static list<case>  getCaseNames()
   {
     
       return  [select id,CaseNumber from case];
       
       
   }


}