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
private class thresholdsService_test {
    private static final integer MAX_LOOP_COUNTER = 11;
    @testSetup static void setupTestData(){
        //setup common test data here
        //Need a few Licenses, and a Threshold Custom setting
        list<License__c> testLicenses= new list<License__c>();
        for(integer i = 0; i < MAX_LOOP_COUNTER; i++){
            License__c oneLicense = new License__c();
            testLicenses.add(oneLicense);
            system.debug(testLicenses);
        }
        insert testLicenses;
        
        thresholds__c thresholds = new thresholds__c();
        thresholds.Name = 'Licenses';
        thresholds.Low_Limit__c = 10;
        thresholds.High_Limit__c = 20;
        thresholds.Adjustment_Factor__c = 2;
        thresholds.Low_Limit_Default_Value__c = 10;
        insert thresholds;
    }
    static testMethod void testSetupData(){
        //use this method to validate that you have test data setup correctly
        integer availableLicenses = [SELECT count() FROM License__c WHERE isIssued__c = false];
        system.assertEquals(MAX_LOOP_COUNTER, availableLicenses);
        thresholds__c thresholds = thresholds__c.getInstance('Licenses');
        system.assertEquals(10, thresholds.Low_Limit__c);
        system.assertEquals(10, thresholds.Low_Limit_Default_Value__c);
        system.assertEquals(20, thresholds.High_Limit__c);
        system.assertEquals(2, thresholds.Adjustment_Factor__c);
    }
    static testMethod void test_getNamedDataSet() {
        thresholds__c readCustomSetting = new thresholds__c();
        readCustomSetting = thresholdsService.getNamedDataSet('Licenses');
        system.assertEquals(10, readCustomSetting.Low_Limit__c);
        system.assertEquals(10, readCustomSetting.Low_Limit_Default_Value__c);
        system.assertEquals(20, readCustomSetting.High_Limit__c);
        system.assertEquals(2, readCustomSetting.Adjustment_Factor__c);
    }
    static testMethod void test_getAvailableLicenseCount(){
      system.assertEquals(MAX_LOOP_COUNTER, thresholdsService.getAvailableLicenseCount());
    }
    static testMethod void test_checkAvailableLicenseCount() {
        thresholds__c readCustomSetting = new thresholds__c();
        readCustomSetting = thresholdsService.checkAvailableLicenseCount();
        system.assertEquals(10, readCustomSetting.Low_Limit__c);
        system.assertEquals(10, readCustomSetting.Low_Limit_Default_Value__c);
        system.assertEquals(20, readCustomSetting.High_Limit__c);
        system.assertEquals(2, readCustomSetting.Adjustment_Factor__c);
    }
    static testMethod void test_issueOneLicense(){
      system.assertEquals(MAX_LOOP_COUNTER - 1 , thresholdsService.issueOneLicense());
    }
    static testMethod void test_addLicenses(){
      system.assertEquals(MAX_LOOP_COUNTER + 2 , thresholdsService.addLicenses(2));
    }
}