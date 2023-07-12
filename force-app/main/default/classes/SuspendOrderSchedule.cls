public class SuspendOrderSchedule implements Schedulable {
	public void execute(SchedulableContext sc) {
      SuspendOrderBatch b = new SuspendOrderBatch('Suspensão Hab Remota', 'Timer Cadastro'); 
      Database.executeBatch(b, 10);
   }
}