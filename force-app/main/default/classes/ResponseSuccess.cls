public with sharing class ResponseSuccess {
    private RestResponse response;
    private Blob body;
    private final Integer SUCESS_STATUS_CODE = 200;
 

    private ResponseSuccess(){}

    public ResponseSuccess(RestResponse restContextresponse, Blob body){
        this.response = restContextresponse;
        this.body = body;

    }

    public  void dispacherSucessResponse() {
        this.response.statusCode = SUCESS_STATUS_CODE;
        this.response.responseBody = body;
        this.response.addHeader('Content-Type', 'application/json');
    }
}