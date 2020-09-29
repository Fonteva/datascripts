# Data Script for Fonteva


## Introduction:

**Data scripts will help in loading data from Org to Org, Org to CSV, and CSV to Org** 

These scripts will help you to populate your org **(scratch / dev / sandbox / production)** with data imported from another org or CSV files. It will also take care of the circular references between objects.


## Installation:


### Prerequisites:

Installing SFDX CLI on your local machine from  here(skip if you already have it installed):

```
https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_install_cli.htm
```



### Install SFDMU as SFDX plugin:

```bash
# If you already have outdated version of the Plugin installed on your local machine
# and want to update it, first uninstall the existing version:
$ sfdx plugins:uninstall sfdmu

# Install the latest version of the Plugin:
$ sfdx plugins:install sfdmu
```


## Loading Data:

### Prerequisites:

#### Disable the Triggers and Validation Rules from Source and Target orgs:

```bash
# Disable triggers for following objects from "Spark Admin" app in Source salesforce org(skip if the Source is CSVFile)
# 1. OrderApi__Invoice_Line__c
# 2. OrderApi__Sales_Order_Line__c
# 3. OrderApi__Sales_Order__c
# 4. OrderApi__Subscription_Line__c
# 5. OrderApi__Item_Class__c
# 6. EventApi__Sponsor_Package__c
# 7. OrderApi__Item__c
# 8. EventApi__Schedule_Item__c
# 9. OrderApi__Price_Rule__c
# 10. OrderApi__Subscription__c

# Disable validation rules for following objects from "Spark Admin" app in Source salesforce org(skip if the Source is CSVFile)
# 1. OrderApi__Sales_Order_Line__c
# 2. OrderApi__Sales_Order__c


# Disable triggers for following objects from "Spark Admin" app in Target salesforce org(skip if the Target is CSVFile)
# 1. Account
# 2. Contact
# 3. OrderApi__Price_Rule__c
# 4. OrderApi__Payment_Method__c 
# 5. OrderApi__Subscription_Plan__c
# 6. OrderApi__Invoice__c
# 7. OrderApi__Scheduled_Payment__c
# 8. OrderApi__Sales_Order__c
# 9. OrderApi__Receipt__c
# 10. OrderApi__Receipt_Line__c
# 11. EventApi__Waitlist_Entry__c
# 12. OrderApi__Sales_Order_Line__c
# 13. OrderApi__Invoice_Line__c
# 14. OrderApi__Subscription_Line__c
# 15. OrderApi__Assignment__c
# 16. OrderApi__Badge_Type__c
# 17. LTE__Site__c

# Disable validation rules for following objects from "Spark Admin" app in Target salesforce org(skip if the Target is CSVFile)
# 1. OrderApi__Item_Class__c
# 2. EventApi__Sponsor_Package__c
# 3. OrderApi__Item__c
# 4. EventApi__Schedule_Item__c
# 5. OrderApi__Price_Rule__c
# 6. OrderApi__Subscription__c
# 7. OrderApi__Sales_Order__c
# 8. OrderApi__Invoice__c
# 9. OrderApi__Sales_Order_Line__c
# 10. OrderApi__Invoice_Line__c
# 11. OrderApi__Subscription_Line__c
# 12. OrderApi__Renewal__c
# 13. OrderApi__Assignment__c
# 14. OrderApi__Badge_Type__c
# 15. LTE__Site__c
```

#### Creating External_Id fields in Source and Target orgs

```bash
# Instructions coming soon. There will be an option in the installation wizard for the same.

```


### Salesoforce Org to Salesforce Org data import:

```bash
# Run following command to load the data from one Salesforce org to another Salesforce org
sfdx sfdmu:run --sourceusername <source org username/alias> --targetusername <target org username/alias>  -p <desired folder path>

# Example:
sfdx sfdmu:run --sourceusername production --targetusername qa  -p data-script/PD-19-ThemeAndRelatedObjects

```

### Salesoforce Org to CSVFile data import:

```bash
# Run following command to load the data from one Salesforce org to another Salesforce org
sfdx sfdmu:run --sourceusername <source org username/alias> --targetusername CSVFile  -p <desired folder path>

# Example:
sfdx sfdmu:run --sourceusername production --targetusername CSVFile  -p data-script/PD-19-ThemeAndRelatedObjects

```

### CSVFile to Salesoforce Org data import:

```bash
# Run following command to load the data from one Salesforce org to another Salesforce org
sfdx sfdmu:run --sourceusername CSVFile --targetusername  <source org username/alias> -p <desired folder path>

# Example:
sfdx sfdmu:run --sourceusername CSVFile --targetusername production  -p data-script/PD-19-ThemeAndRelatedObjects

```

### Order of data import:

```bash
# The order matters here as the objects/modules have dependencies with other objects/modules, we suggest following the below order for import for any type of import/export(org-org, org-csv or csv-org). Just replace the -p parameter with the following names and run the desired command. 
# Example: sfdx sfdmu:run --sourceusername CSVFile --targetusername production  -p data-script/PD-17-AccountObjects

# 1. data-script/PD-19-ThemeAndRelatedObjects
# 2. data-script/PD-17-AccountObjects
# 3. data-script/PD-2-GLAccountObjects
# 3. data-script/ProgramBasicSetup
# 4. data-script/PD-16-SiteObjects
# 5. data-script/ProgramProfileAndRelatedObjects
# 6. data-script/PD-21-CommunityGroupObjects
# 7. data-script/PD-3-ItemClassObjects
# 8. data-script/PD-23-TrackObjects
# 9. data-script/PD-24-ItemObjects
# 10. data-script/PD-25-RenewalObjects
# 11. data-script/PD-26-PackageItem
# 12. data-script/PD-27-CatalogObjects
# 13. data-script/PD-11-PriceRuleObjects
# 14. data-script/PD-28-PaymentObjects
# 15. data-script/PD-14-SubscriptionObjects
# 16. data-script/PD-22-SourceCodeObjects
# 17. data-script/PD-30-SalesOrderAndRelatedObjects
# 18. data-script/PD-31-CreditObjects
# 19. data-script/PD-32-SectionObjects
# 20. data-script/PD-45-MediaAssetObject
# 21. data-script/PD-29-SalesOrderLineAndRelatedObjects
# 22. data-script/PD-33-InvoiceLineAndRelatedObjects
# 23. data-script/PD-34-EPaymentLineAndRelatedObjects
# 24. data-script/PD-35-CreditMemoLineAndRelatedObjects
# 25. data-script/PD-36-Renewal(Term)AnsRelatedObjects
# 26. data-script/PD-37-RegistrationItem
# 27. data-script/PD-12-FormResponseAndRelatedObjects
# 28. data-script/PD-43-GiftInKindAndRelatedObjects
# 29. data-script/PD-42-BadgeTypeAndRelatedObjects
# 30. data-script/LTESiteAndRelatedObjects
# 31. data-script/PD-40 JoinProcessObjects
# 32. data-script/PD-41-AccessPermissionObject

```
