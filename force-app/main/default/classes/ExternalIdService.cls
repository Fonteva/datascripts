/**
 * @description       : This class is used to created external Id fields, Give permission & populate the field
 * @author            : vpoddar@fonteva.com
 * @group             : 
 * @last modified on  : 09-30-2020
 * @last modified by  : vpoddar@fonteva.com
 * Modifications Log 
 * Ver   Date         Author                Modification
 * 1.0   09-30-2020   vpoddar@fonteva.com   Initial Version
**/
public with sharing class ExternalIdService {

    public static final List<String> objectNames = new List<String>{
        'Account','Contact',
            'PagesApi__Field_Group__c','PagesApi__Field__c',
            'OrderApi__Package_Item__c','EventApi__Schedule_Item__c',
            'OrderApi__Item__c','EventApi__Ticket_Type__c',
            'EventApi__Sponsor_Package__c','EventApi__Speaker_Schedule_Item__c',
            'OrderApi__Assignment_Role__c', 'OrderApi__Item_Class__c',
            'OrderApi__Subscription__c','OrderApi__Payment_Method__c',
            'OrderApi__Custom_Payment_Type__c','OrderApi__Payment_Terms__c',
            'OrderApi__Price_Rule_Variable__c','OrderApi__Price_Rule__c',
            'OrderApi__Batch__c','OrderApi__Item_Subscription_Plan__c',
            'OrderApi__Sales_Order__c', 'OrderApi__Receipt__c',
            'OrderApi__EPayment__c', 'OrderApi__Invoice__c',
            'EventApi__Waitlist_Entry__c', 'OrderApi__Credit_Memo__c',
            'OrderApi__Credit_Note__c', 'EventApi__Section__c',
            'EventApi__Seat__c', 'EventApi__Section_Ticket__c',
            'PagesApi__Media_Asset__c', 'OrderApi__Sales_Order_Line__c',
            'EventApi__Attendee__c', 'EventApi__Registration_Group__c',
            'OrderApi__Invoice_Line__c', 'OrderApi__Subscription_Line__c',
            'OrderApi__Scheduled_Payment_Line__c', 'OrderApi__EPayment_Line__c',
            'OrderApi__Receipt_Line__c', 'OrderApi__Log__c',
            'OrderApi__Credit_Memo_Line__c', 'OrderApi__Transaction__c',
            'OrderApi__Transaction_Line__c', 'OrderApi__Renewal__c',
            'OrderApi__Assignment__c', 'EventApi__Registration_Item__c',
            'PagesApi__Form_Response__c', 'PagesApi__Field_Response__c',
            'OrderApi__Badge_Workflow__c', 'OrderApi__Badge__c',
            'joinapi__Join_Process__c','joinapi__Step__c',
            'joinapi__Step_Condition__c','ProgramApi__Program_Profile__c',
            'ProgramApi__Goals__c','ProgramApi__Program_Term__c',
            'EventApi__Event_Page_Component__c','EventApi__Event_Page__c',
            'EventApi__Speaker__c','EventApi__Track_Schedule_Item__c',
            'OrderApi__Scheduled_Payment__c','OrderApi__Payment_Gateway__c'};
	/**
	* @description This method creates the External Id fieldo on the given object
	* @author vpoddar@fonteva.com | 09-30-2020 
	**/
	public static void createExternalIdFields(){
        for(String objectName : objectNames){
            MetadataServiceCopy.createExternalIdCustomField(objectName);
        } 
    }
    /**
    * @description This method gives permission to External Id of the given object
    * @author vpoddar@fonteva.com | 09-30-2020 
    * @param List<String> permissionSetNames 
    **/
    public static void givePermissionsToExternalIdFields(List<String> permissionSetNames){
        List<PermissionSet> profilePermissionsSetIds = [SELECT Id, Profile.Name
                                                        FROM PermissionSet
                                                        WHERE IsOwnedByProfile = true AND Profile.Name IN :permissionSetNames];
        List<FieldPermissions> fieldPermissions = new List<FieldPermissions>();
        for(String objectName : objectNames){
            for ( PermissionSet p: profilePermissionsSetIds ) {
                fieldPermissions.add(
                    new FieldPermissions(
                        Field = objectName + '.External_Id__c',
                        SObjectType = objectName,
                        ParentId = p.Id,
                        PermissionsRead = true,
                        PermissionsEdit = true
                    ));
            }
        }
        Database.insert(fieldPermissions, false);
    }
    /**
    * @description This method will populate the external Id of all the given objects
    * @author vpoddar@fonteva.com | 09-30-2020 
    **/
    public static void populateExternalIdFields(){
        for(String objectName : objectNames){
            Database.executeBatch(new ExternalIdDataCreator(objectName));
        } 
    }
}