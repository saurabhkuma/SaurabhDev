global with sharing class studentschedular implements Schedulable 
{
	global void execute(SchedulableContext sc)
	{
		insertstudent inst= new insertstudent();
		database.executeBatch(inst);
		
	}
	
	

}