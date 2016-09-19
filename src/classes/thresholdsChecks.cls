public class thresholdsChecks {
    
    public thresholds__c checkThresholds(){
        Integer availableLicenses = [SELECT count() FROM License__c WHERE isIssued__c = false];
        thresholds__c thresholds = thresholds__c.getInstance('Licenses');
        if(availableLicenses <= thresholds.Low_Limit__c){ //Adjust limit DOWN, and create a Case
            double newLowLimit = math.floor(thresholds.Low_Limit__c/thresholds.Adjustment_Factor__c);
            thresholds.Low_Limit__c = (integer)newLowLimit;
            update thresholds; //Adjust limit DOWN
            case createdCase = createLowLimitCase(availableLicenses, thresholds); //Create a Case
        } else if(availableLicenses >= thresholds.High_Limit__c &&
            thresholds.Low_Limit__c != thresholds.Low_Limit_Default_Value__c){ //Adjust the limit UP
            thresholds.Low_Limit__c = thresholds.Low_Limit_Default_Value__c;
            update thresholds; //Adjust the limit UP
        }
        return thresholds ;
    }
    
    public Case createLowLimitCase(integer availableLicenses, thresholds__c newSettings){
        Case LowLimitCase = new Case();
        LowLimitCase.Description = 'The number of availableLicenses is ' + availableLicenses + '\r\n' +
            'The warning threshold has been adjusted to : ' + newSettings.Low_Limit__c;
        LowLimitCase.Origin = 'Web';
        LowLimitCase.Priority='Critical';
        LowLimitCase.Status='New';
        LowLimitCase.Type='Threshold';
        insert LowLimitCase;
        return LowLimitCase;
    }
}