({
    doInit : function(component, event, helper) {
        helper.getFeed(component);
    },
    fetchNews : function(component, event, helper) {
        helper.fetchNews(component);
    },
    doMove : function(component, event, helper) {
    	helper.doMove(component, event);
        
    },
    closeList : function(component, event, helper) {
    	component.set('v.listClosed', !component.get('v.listClosed'));
    },
})