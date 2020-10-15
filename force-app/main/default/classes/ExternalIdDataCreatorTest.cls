/**
 * @description       : Test class of ExternalIdDataCreator
 * @author            : vpoddar@fonteva.com
 * @group             : 
 * @last modified on  : 09-30-2020
 * @last modified by  : vpoddar@fonteva.com
 * Modifications Log 
 * Ver   Date         Author                Modification
 * 1.0   09-30-2020   vpoddar@fonteva.com   Initial Version
**/
@isTest
public class ExternalIdDataCreatorTest {
	@testSetup
    private static void testSetup(){
        List<Account> accList = new List<Account>();
        
        for(Integer i = 1; i <= 5; i++){
            accList.add(new Account(Name = 'Test Account ' + i));
        }
        
        insert accList;
    }
    @isTest
    private static void testBatchPositive(){
        Test.startTest();
        
        String batchId = Database.executeBatch(new ExternalIdDataCreator('Account'));
        
        Test.stopTest();
        
        System.assert(String.isNotBlank(batchId), 'Batch Id should be there');
        System.assertEquals('1', [SELECT Id, External_Id__c FROM Account ORDER BY External_Id__c LIMIT 1].External_Id__c, 'External Id Should be 1');
    }
    @isTest
    private static void testBatchNegetive(){
        Test.startTest();
        
        String batchId = Database.executeBatch(new ExternalIdDataCreator('Test', 'Test_External_Id__c'));
        
        Test.stopTest();
        
        System.assert(String.isNotBlank(batchId), 'Batch Id should be there');
        System.assertEquals(NULL, [SELECT Id, External_Id__c FROM Account ORDER BY External_Id__c LIMIT 1].External_Id__c, 'External Id Should be NULL');
    }
}