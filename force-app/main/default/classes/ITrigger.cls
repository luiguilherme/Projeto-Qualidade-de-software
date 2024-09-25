/** 
* @author Ronaldo Garcia
* @company Everis do Brasil 
*/
public interface  ITrigger {
	void bulkBefore();
	void bulkAfter();
	void beforeInsert();
	void beforeUpdate();
	void beforeDelete();
	void afterInsert();
	void afterUpdate();
	void afterDelete();
	void andFinally();
}