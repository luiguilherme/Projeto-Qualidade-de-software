global with sharing class getTopicTreeResponseWrapper {
    global class responseSucess{
        global List<TopicTree> topicTree;
        
    }
    global class topicTree {
        global String id { get; set; }
        global String name { get; set; }
        global String omniTree { get; set; }
        global String gpsFlow { get; set; }
        global String productType { get; set; }
        global String caseRecordTypeDevName { get; set; }
    }
    global class responseError {
        global String message {get; set;}
        global String errorCode {get;set;}
    }   
}