public with sharing class thresholdsService {
    @AuraEnabled
    public static thresholds__c getNamedDataSet(string dataSetName){
      thresholds__c returnThresholds = new thresholds__c();
      returnThresholds = thresholds__c.getInstance(dataSetName);
      system.debug(returnThresholds);
      return returnThresholds;
    }
    
    @AuraEnabled
    public static Thresholds__c checkAvailableLicenseCount(){
        thresholdsChecks util = new thresholdsChecks();
        return util.checkThresholds();
    }
    
    @AuraEnabled
    public static integer getAvailableLicenseCount(){
      integer returnCount = [SELECT count() FROM License__c WHERE isIssued__c = false];
      return returnCount;
    }
    
    @AuraEnabled
    public static integer issueOneLicense(){
      License__c toBeIssued = new License__c();
      toBeIssued = [SELECT Id, isIssued__c FROM License__c WHERE isIssued__c = false LIMIT 1];
      toBeIssued.isIssued__c = true;
      update toBeIssued;
      return getAvailableLicenseCount();
    }
    
    @AuraEnabled
    public static integer addLicenses(integer addCount){
      system.debug('addCount : ' + addCount);
        list<License__c> licenseList = new list<License__c>();
        for(integer i=0; i < addCount  ; i++){
            License__c singleLicense = new License__c();
            licenseList.add(singleLicense);
        }
        insert licenseList;
        return getAvailableLicenseCount();
    }
}