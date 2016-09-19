public with sharing class instanceCheck {
  @AuraEnabled
  public static boolean getIsProduction(){
    boolean returnBool;
    h_Production_Org_Ids__c mySetting = new h_Production_Org_Ids__c();  //Create a new instance of the Custom Setting
    mySetting = h_Production_Org_Ids__c.getOrgDefaults();               //get the Org default dataset for our Production Org
    string currentOrgId = UserInfo.getOrganizationId();                 //get the current Org Id from the UserInfo Class
    if(currentOrgId == mySetting.Org_Id_18_char__c){                    //compare the two Org Ids...
      returnBool = true;                                                //if True, We are in production, use production behaviour 
    } else {                                                            //if False...
      returnBool = false;                                               //then we are in a Sandbox, use sandbox behaviour
    }
    system.debug('isProductionOrg = ' + returnBool);                    //handy debug statement for an exec anon demo
    return returnBool;
  }
}