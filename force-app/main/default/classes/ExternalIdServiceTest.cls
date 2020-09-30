/**
 * @description       : Test class of ExternalIdService
 * @author            : vpoddar@fonteva.com
 * @group             : 
 * @last modified on  : 09-30-2020
 * @last modified by  : vpoddar@fonteva.com
 * Modifications Log 
 * Ver   Date         Author                Modification
 * 1.0   09-30-2020   vpoddar@fonteva.com   Initial Version
**/
@isTest
public with sharing class ExternalIdServiceTest {
    /**
     * Dummy Metadata API web service mock class (see MetadataCreateJobTest.cls for a better example)
     **/
	private class WebServiceMockImpl implements WebServiceMock 
	{
		public void doInvoke(
			Object stub, Object request, Map<String, Object> response,
			String endpoint, String soapAction, String requestName,
			String responseNS, String responseName, String responseType) 
		{
			if(request instanceof MetadataServiceCopy.retrieve_element)
				response.put('response_x', new MetadataServiceCopy.retrieveResponse_element());
			else if(request instanceof MetadataServiceCopy.checkDeployStatus_element)
				response.put('response_x', new MetadataServiceCopy.checkDeployStatusResponse_element());
			else if(request instanceof MetadataServiceCopy.listMetadata_element)
				response.put('response_x', new MetadataServiceCopy.listMetadataResponse_element());
			else if(request instanceof MetadataServiceCopy.checkRetrieveStatus_element)
				response.put('response_x', new MetadataServiceCopy.checkRetrieveStatusResponse_element());
			else if(request instanceof MetadataServiceCopy.describeMetadata_element)
				response.put('response_x', new MetadataServiceCopy.describeMetadataResponse_element());
			else if(request instanceof MetadataServiceCopy.deploy_element)
				response.put('response_x', new MetadataServiceCopy.deployResponse_element());
            else if(request instanceof MetadataServiceCopy.updateMetadata_element)
                response.put('response_x', new MetadataServiceCopy.updateMetadataResponse_element());
            else if(request instanceof MetadataServiceCopy.renameMetadata_element)
                response.put('response_x', new MetadataServiceCopy.renameMetadataResponse_element());
            else if(request instanceof  MetadataServiceCopy.cancelDeploy_element)
                response.put('response_x', new MetadataServiceCopy.cancelDeployResponse_element());
            else if(request instanceof  MetadataServiceCopy.deleteMetadata_element)
                response.put('response_x', new MetadataServiceCopy.deleteMetadataResponse_element());
            else if(request instanceof  MetadataServiceCopy.upsertMetadata_element)
                response.put('response_x', new MetadataServiceCopy.upsertMetadataResponse_element());
            else if(request instanceof  MetadataServiceCopy.createMetadata_element)
                response.put('response_x', new MetadataServiceCopy.createMetadataResponse_element());
            else if(request instanceof  MetadataServiceCopy.deployRecentValidation_element)
                response.put('response_x', new MetadataServiceCopy.deployRecentValidationResponse_element());
            else if(request instanceof MetadataServiceCopy.describeValueType_element)
                response.put('response_x', new MetadataServiceCopy.describeValueTypeResponse_element());
            else if(request instanceof MetadataServiceCopy.checkRetrieveStatus_element)
                response.put('response_x', new MetadataServiceCopy.checkRetrieveStatusResponse_element());
			return;
		}
	}    
    @TestSetup
    public static void testSetup(){
        insert new Account(Name='Test Account 1');
    }
	@isTest
    public static void testAllExternalIdService(){
        System.Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        
        Test.startTest();
        
        ExternalIdService.createExternalIdFields();
        ExternalIdService.givePermissionsToExternalIdFields(new List<String>{'Standard User', 'System Administrator'});
        ExternalIdService.populateExternalIdFields();
        
        Test.stopTest();
        
        Account acc = [SELECT Id, External_Id__c FROM Account LIMIT 1];
        System.assertEquals('1', acc.External_Id__c, 'External Id field should be populated');
    }
}