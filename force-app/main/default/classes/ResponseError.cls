public with sharing class ResponseError {
        private RestResponse response;
        private Blob errorMessage;
        private Integer statusCode ;

        private ResponseError(){}

        public ResponseError(RestResponse restContextresponse, Blob errorMessage, Integer statusCode){
            this.response = restContextresponse;
            this.errorMessage = errorMessage;
            this.statusCode = statusCode;

        }

        public  void dispacherErrorResponse() {
            this.response.statusCode = statusCode;
            this.response.responseBody = errorMessage;
            this.response.addHeader('Content-Type', 'application/json');
        }
    
}