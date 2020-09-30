/**
* ─────────────────────────────────────────────────────────────────────────────────────────────────┐
* The batch will generate the external Id field values for the given object
* ──────────────────────────────────────────────────────────────────────────────────────────────────
* @author         Concretio Apps
* @version        1.0
* @created        2020-09-21
* @modified       2020-09-21
* @systemLayer    Batch Class
* @testClass      ExternalIdDataCreatorTest.cls
* ─────────────────────────────────────────────────────────────────────────────────────────────────┘
*/
public with sharing class ExternalIdDataCreator implements Database.Batchable<sObject>, Database.Stateful{
    public Integer counter = 1;
    //Object name
    private String objectName;
    //External id field name
    private String externalIdFieldName = 'External_Id__c';
    /**
	* ───────────────────────────────────────────────────────────────────────────────────────────────┐
	* parameterized constructor of PopulateExternalIdBtch Batch
	* ────────────────────────────────────────────────────────────────────────────────────────────────
	* @param     objectName		 Object name for which we need to create external id values
	* ───────────────────────────────────────────────────────────────────────────────────────────────┘
	*/
    public ExternalIdDataCreator(String objectName){
        this.objectName = objectName;
    }
    /**
	* ───────────────────────────────────────────────────────────────────────────────────────────────┐
	* parameterized constructor of PopulateExternalIdBtch Batch
	* ────────────────────────────────────────────────────────────────────────────────────────────────
	* @param     objectName		 			Object name for which we need to create external id values
	* @param     externalIdFieldName		External id field name
	* ───────────────────────────────────────────────────────────────────────────────────────────────┘
	*/
    public ExternalIdDataCreator(String objectName, String externalIdFieldName){
        this.externalIdFieldName = externalIdFieldName;
        this.objectName = objectName;
    }
    /**
	* ───────────────────────────────────────────────────────────────────────────────────────────────┐
	* Start method of Batch class
	* ────────────────────────────────────────────────────────────────────────────────────────────────
	* @param     bc						object of BatchableContext class
	* @return    QueryLocator    		returns the records of the specified object
	* ───────────────────────────────────────────────────────────────────────────────────────────────┘
	*/
    public Database.QueryLocator start(Database.BatchableContext bc){
        String query;
        if(!validateSObject()){
            //Dummy query
            query = 'SELECT Id FROM Account WHERE CreatedDate > Today';
        }
        else{
            query = 'SELECT Id, ' + externalIdFieldName + ' FROM ' + objectName + ' ORDER BY CreatedDate';
        }
        return Database.getQueryLocator(query);
    }
    /**
	* ───────────────────────────────────────────────────────────────────────────────────────────────┐
	* Execute method of Batch class
	* ────────────────────────────────────────────────────────────────────────────────────────────────
	* @param     bc					object of BatchableContext class
	* @param     records		 	List of records of the object specified
	* @return    void
	* ───────────────────────────────────────────────────────────────────────────────────────────────┘
	*/
    public void execute(Database.BatchableContext bc, List<sObject> records){
        try{
            for(sObject record : records){
                record.put(externalIdFieldName, ''+counter);
                counter ++;
            }
            
            Database.update(records, false);
        }
        catch(Exception e){
            System.debug('Exception occured:'+e.getStackTraceString());
        }
    }
    /**
	* ───────────────────────────────────────────────────────────────────────────────────────────────┐
	* Finish method of Batch class
	* ────────────────────────────────────────────────────────────────────────────────────────────────
	* @param     bc		object of BatchableContext class
	* @return    void
	* ───────────────────────────────────────────────────────────────────────────────────────────────┘
	*/
    public void finish(Database.BatchableContext bc){
        System.debug('Finish');
    }
    /**
	* ───────────────────────────────────────────────────────────────────────────────────────────────┐
	* This method checks that field is available on object or not.
	* ────────────────────────────────────────────────────────────────────────────────────────────────
	* @param     no parameter
	* @param     Boolean			returns that field is has access or not
	* ───────────────────────────────────────────────────────────────────────────────────────────────┘
	*/
    public Boolean validateSObject(){
        Schema.SObjectType sobjType = Schema.getGlobalDescribe().get(objectName);
        if(sobjType == NULL) return false;
        
        Schema.DescribeSObjectResult describeObjectResult = sobjType.getDescribe();
		return describeObjectResult.fields.getMap().containsKey(externalIdFieldName);
    }
}