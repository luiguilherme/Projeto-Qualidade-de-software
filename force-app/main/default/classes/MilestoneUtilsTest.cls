/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an organization are executed whenever Apex code is deployed
* to a production organization to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production organization. In addition, all triggers must have some code coverage.
*
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the organization size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest
private class MilestoneUtilsTest {

static testMethod void TestCompleteMilestoneCase(){

List<Account> acts = new List<Account>();
Account myAcc = new Account(Name='TestAct', phone='1001231234');
acts.add(myAcc);

Account busAcc = new Account(Name = 'TestForMS', phone='4567890999');
acts.add(busAcc);
insert acts;
Contact cont = new Contact(FirstName = 'Test', LastName = 'LastName', phone='4567890999', accountid = busAcc.id);
insert(cont);

Id contactId = cont.Id;

Entitlement entl = new Entitlement(Name='TestEntitlement', AccountId=busAcc.Id);
insert entl;

String entlId;
if (entl != null)
entlId = entl.Id; 

List<Case> cases = new List<Case>{};
if (entlId != null){
Case c = new Case(Subject = 'Test Case with Entitlement ', 
EntitlementId = entlId, ContactId = contactId);
cases.add(c);
}
if (cases.isEmpty()==false){
insert cases;
List<Id> caseIds = new List<Id>();
for (Case cL : cases){
caseIds.add(cL.Id);
}
milestoneUtils.completeMilestone(caseIds, 'Tempo de resolução', System.now());
}
}

static testMethod void testCompleteMilestoneViaCase(){

List<Account> acts = new List<Account>();
Account myAcc = new Account(Name='TestAct', phone='1001231234');
acts.add(myAcc);

Account busAcc = new Account(Name = 'TestForMS', phone='4567890999');
acts.add(busAcc);
insert acts;
Contact cont = new Contact(FirstName = 'Test', LastName = 'LastName', phone='4567890999', accountid = busAcc.id);
insert(cont);

Id contactId = cont.Id;

Entitlement entl = new Entitlement(Name='TestEntitlement', AccountId=busAcc.Id);
insert entl;

String entlId;
if (entl != null)
entlId = entl.Id; 

List<Case> cases = new List<Case>{};
for(Integer i = 0; i < 1; i++){
Case c = new Case(Subject = 'Test Case ' + i);
cases.add(c);
if (entlId != null){
c = new Case(Subject = 'Test Case with Entitlement ' + i, 
EntitlementId = entlId);
cases.add(c);
}
}
}
}