({
	doInit : function(component, event, helper) {
		// Create the action
        var action = component.get("c.getNamedDataSet");
        action.setParams({ "dataSetName" : "Licenses"});
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.setting", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	},
	
	handleLicenseCheckPress : function(component, event, helper){
	    // Create the action
        var action = component.get("c.checkAvailableLicenseCount");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS"){
            	//component.set("v.setting", response.getReturnValue());
                var updatedThreshold = response.getReturnValue();
                var originalThreshold = component.get("v.setting");
                if(originalThreshold != updatedThreshold){
                    //Something Changed!
                    component.set("v.setting", updatedThreshold);
                }
            } else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	}
})