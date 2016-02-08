global with sharing class DeleteSchedular implements Schedulable 
{
	integer intervaltime;
	
	global DeleteSchedular(integer intervaltime1)
	{
		intervaltime= intervaltime1;
		
	}
	
	global void execute(SchedulableContext sc)
	{
		deletestudentbatch dels= new deletestudentbatch();
		database.executeBatch(dels);
		DateTime now  = DateTime.now();
        DateTime nextRunTime = now.addMinutes(intervaltime);
        String cronString = nextRunTime.second() + ' ' + nextRunTime.minute() + ' ' + 
            nextRunTime.hour() + ' ' + nextRunTime.day() + ' ' + 
            nextRunTime.month() + ' ? ' + nextRunTime.year(); 
        System.schedule( 'Deletescheduleno-' + now.format(), cronString, new Deleteschedular(1));
        system.debug('comlete deletion');
        // Abort the current job
        Id jobId = sc.getTriggerId();
        System.abortJob(jobId);  
		
	}
	
	

}