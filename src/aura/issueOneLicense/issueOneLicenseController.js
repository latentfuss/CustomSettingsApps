({
	clickIssueOneLicense : function(component, event, helper) {
		// Create the action
        var action = component.get("c.issueOneLicense");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response){
            //Fire off an event!
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var compEvent = component.getEvent("newLicenseCount");
                // Optional: set some data for the event (also known as event shape)
                compEvent.setParams({"newCount": response.getReturnValue()});
                compEvent.fire();
                console.log("Fired Event! : " + response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	}
})