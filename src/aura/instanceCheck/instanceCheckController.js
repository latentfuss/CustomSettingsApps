({
    check: function(cmp, event, helper) {
        //get server value
        var action = cmp.get('c.getIsProduction');
        //handle response from server
        action.setCallback(this, function(resp) {
            var respData = resp.getReturnValue();
            cmp.set('v.myText', respData ? 'This is a Production Org' : 'This is a Sandbox Org');
            
        });
        //Send request to server
        $A.enqueueAction(action);
    }
})