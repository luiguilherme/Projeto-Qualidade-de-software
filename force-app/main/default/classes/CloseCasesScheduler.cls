public with sharing class CloseCasesScheduler implements Schedulable{	
	public void execute(SchedulableContext sc) {
		CloseCasesBatch.start();
	}
}