({
	doInit : function(component, event, helper) {
	    // Create the action
	    var action = component.get("c.getAvailableLicenseCount");
	    // Add callback behavior for when response is received
	    action.setCallback(this, function(response){
	        var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.count", response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
	    });
		// Send action off to be executed
        $A.enqueueAction(action);
	},
	
	handleLicenseCountChangeEvent : function(component, event, helper) {
        console.log("handled event at component!");
        // Create the action
        component.set("v.count", event.getParam("newCount"));
    }
})