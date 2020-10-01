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

# 1. data-script/ThemeAndRelatedObjects
# 2. data-script/AccountAndRelatedObjects
# 3. data-script/GLAccountAndRelatedObjects
# 3. data-script/ProgramTypeAndRelatedObjects
# 4. data-script/SiteAndRelatedObjects
# 5. data-script/ProgramProfileObject
# 6. data-script/CommunityGroupAndRelatedObjects
# 7. data-script/ItemClassAndRelatedObjects
# 8. data-script/TrackAndRelatedObjects
# 9. data-script/ItemAndRelatedObjects
# 10. data-script/RenewalPathAndRelatedObjects
# 11. data-script/PackageItemObject
# 12. data-script/CatalogAndRelatedObjects
# 13. data-script/PriceRuleAndRelatedObjects
# 14. data-script/PaymentAndRelatedObjects
# 15. data-script/SubscriptionAndRelatedObjects
# 16. data-script/SourceCodeAndRelatedObjects
# 17. data-script/SalesOrderAndRelatedObjects
# 18. data-script/CreditMemoLineAndRelatedObjects
# 19. data-script/SectionAndRelatedObjects
# 20. data-script/MediaAssetObject
# 21. data-script/SalesOrderLineAndRelatedObjects
# 22. data-script/InvoiceLineAndRelatedObjects
# 23. data-script/EPaymentLineAndRelatedObjects
# 24. data-script/TransactionAndRelatedObjects
# 25. data-script/RenewalTermAndRelatedObjects
# 26. data-script/RegistrationItemObject
# 27. data-script/FormResponseAndRelatedObjects
# 28. data-script/GiftInKindAndRelatedObjects
# 29. data-script/BadgeTypeAndRelatedObjects
# 30. data-script/LTESiteAndRelatedObjects
# 31. data-script/JoinProcessAndRelatedObjects
# 32. data-script/AccessPermissionObject

```
