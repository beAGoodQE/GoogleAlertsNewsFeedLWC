public class RSSFeedUtil {
    public static List<RSSObject> getGoogleRSSObjects(String theUrl) {
        List<RSSObject> returnList = new List<RSSObject>();
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();        
        req.setEndpoint(theUrl);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        
        Dom.Document doc = res.getBodyDocument();
        Dom.XMLNode feed = doc.getRootElement();
        String namespace = feed.getNamespace();
        
        for(Dom.XMLNode child : feed.getChildElements()) {
            if(child.getName() == 'entry') {
                RSSObject returnListItem = new RSSObject(
                    child.getChildElement('title', namespace).getText().unescapeHtml4(),
                    child.getChildElement('link', namespace).getAttribute('href', ''),                    
                    child.getChildElement('content', namespace).getText().unescapeHtml4(),
                    child.getChildElement('published', namespace).getText()
                );
                System.debug(returnListItem);
                returnList.add(returnListItem);
            }
            System.debug(returnList);
        }
        return returnList;        
    }
}