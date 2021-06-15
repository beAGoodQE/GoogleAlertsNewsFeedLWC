public class RSSFeedCtrl {
    @AuraEnabled
    public static String getURL(String URLField, ID recordId, String objectName) {
        String queryString = 'select ' + URLField + ' from ' + objectName + ' where Id = \'' + recordId + '\'';
        String returnValue = '';
        
        try {
            sObject s = Database.query(queryString);
            returnValue = (String)s.get(URLField);
        }
        catch (Exception e) {
            throw new AuraHandledException('Error in getURL method of RSSFeedCtrl: ' + e.getMessage());    
        }
        
        return returnValue;
    }

    @AuraEnabled
    public static List<RSSObject> getRSSFeed(String url) {
        List<RSSObject> toReturn = new List<RSSObject>();
        try {
            if(url != null){
                toReturn = RSSFeedUtil.getGoogleRSSObjects(url);
            } 
        }
        catch (Exception e) {
            throw new AuraHandledException('Error in getRSSFeed method of RSSFeedCtrl:' + e.getMessage());    
        }
               
        return toReturn;
    }
}