public with sharing class ShowReportController {

    public PageReference showReport() {
         render = true;
        return null;
    }

 public boolean render {get; set;}
 public  Id reportId {get; set;}
 public map<id,report> allrep;
 
 public showreportcontroller()
 {
    allrep = new Map<id,report>([select name from report limit 100]);
    
 }

public List<report> getAllReport()
     {
                 
                  
                  return allrep.values();
     }

public  list<SelectOption> getAllId()
{
    list<selectoption> listso = new list<selectoption>();
    for(report rep : allrep.values())
    {
      selectoption so = new selectoption( rep.id, rep.name);
      listso.add(so);
    }
    return listso;
}
}