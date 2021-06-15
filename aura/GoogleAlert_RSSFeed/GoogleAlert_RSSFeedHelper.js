({
    getFeed : function(component) {
        if(component.get("v.theUrl") != "") {
            this.fetchNews(component);
        } else if(component.get("v.sObjectName") != "") {
            //get the url from the Apex Controller
            var action1 = component.get("c.getURL");  
            action1.setParams({ "URLField" : component.get("v.theUrlField"),
                               "recordId": component.get("v.recordId"),
                               "objectName": component.get("v.sObjectName")
                              });
            
            action1.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    console.log(response.getReturnValue());
                    component.set("v.theUrl", response.getReturnValue());                
                }
                else if (state === "ERROR") {
                    this.handleErrors(response.getError());
                }
            })
            $A.enqueueAction(action1);
        }
    },
    
    fetchNews : function(component) {        
        var action2 = component.get("c.getRSSFeed");   
        action2.setParams({"url": component.get("v.theUrl")});
        
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.feedItems", response.getReturnValue());
            }
            else if (state === "ERROR") {
                this.handleErrors(response.getError());
            }
        });
        $A.enqueueAction(action2);
    },
    
    doMove : function(component, event) {   
        var button =  event.getSource().getLocalId();
        var contents = component.find("newsContents").getElement();
        
        if (button == 'left') {
            contents.scrollLeft = contents.scrollLeft - 264;
        }
        else {
            contents.scrollLeft = contents.scrollLeft + 264;
        }
    },
    handleErrors : function(errors) {
        // Configure error toast
        let toastParams = {
            title: "Error",
            message: "Unknown error", // Default error message
            type: "error"
        };
        // Pass the error message if any
        if (errors && Array.isArray(errors) && errors.length > 0) {
            toastParams.message = errors[0].message;
        }
        // Fire error toast
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams(toastParams);
        toastEvent.fire();
	},
})