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
private class instanceCheck_test {
    @testSetup 
    static void setupTestData(){
        //We need to setup the Cusstom Setting here... 
        string orgId = UserInfo.getOrganizationId();
        h_Production_Org_Ids__c mySetting = h_Production_Org_Ids__c.getOrgDefaults();
        mySetting.Org_Id_18_char__c = orgId;
        mySetting.Org_Id_15_char__c = orgId.left(15);
        upsert mySetting;
    }
    
    static testMethod void testSetupData(){
        //use this method to validate that you have test data setup correctly
        string orgId = UserInfo.getOrganizationId();
        h_Production_Org_Ids__c mySetting = h_Production_Org_Ids__c.getOrgDefaults();
        system.assertEquals(orgId, mySetting.Org_Id_18_char__c);
    }
    
    static testMethod void test_isProduction(){
      system.assert(instanceCheck.getIsProduction());
    }
    
    static testMethod void test_isNOTProduction(){
	    h_Production_Org_Ids__c mySetting = h_Production_Org_Ids__c.getOrgDefaults();
	    mySetting.Org_Id_18_char__c = '00D000000000000';
	    update mySetting;
      system.assertEquals(false, instanceCheck.getIsProduction());
    }
}