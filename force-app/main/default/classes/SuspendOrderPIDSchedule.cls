public class SuspendOrderPIDSchedule implements Schedulable {
	public void execute(SchedulableContext sc) {
      SuspendOrderBatch b = new SuspendOrderBatch('Suspensão Hab Remota', 'Timer PID'); 
      Database.executeBatch(b, 10);
   }
}