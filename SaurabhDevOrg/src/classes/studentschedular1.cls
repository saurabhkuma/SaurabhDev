global with sharing class studentschedular1 implements Schedulable 
{
	integer intervaltime;
	
	global studentschedular1(integer intervaltime1)
	{
		intervaltime= intervaltime1;
		
	}
	
	global void execute(SchedulableContext sc)
	{
		insertstudent inst= new insertstudent();
		database.executeBatch(inst);
		DateTime now  = DateTime.now();
        DateTime nextRunTime = now.addMinutes(intervaltime);
        String cronString = nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
            nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
            nextRunTime.month() + ' ? ' + nextRunTime.year(); 
        System.schedule( 'scheduleno-' + now.format(), cronString, new studentschedular1(1));
        system.debug('comlete');
        // Abort the current job
        Id jobId = sc.getTriggerId();
        System.abortJob(jobId);  
		
	}
	
	

}