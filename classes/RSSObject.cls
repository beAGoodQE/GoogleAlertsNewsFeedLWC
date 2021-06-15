public class RSSObject {
    @AuraEnabled
    public String title {get;set;}
    @AuraEnabled
    public String link {get;set;}
    @AuraEnabled
    public String content {get;set;}
    @AuraEnabled
    public String published {get;set;}
    
    public RSSObject(String title, String link, String content, String published) {
        this.title = title;
        this.link = link;
        this.content = content;
        this.published = published;
    }
}