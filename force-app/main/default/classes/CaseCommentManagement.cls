@RestResource(urlMapping = '/CaseCommentManagement/v1/*')
global with sharing class CaseCommentManagement {
    private static UUIDService service;

    @HttpGet
    global static void getCaseComments() {
        try{
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            String jwt;
            String caseId;
            String cpf;
            Boolean isValidRequest = validateAuthenticationRequest(req, '');
            String headerXAuth;

            if (isValidRequest) {
                headerXAuth = req.headers.get('x-Authorization');
                String[] jwtParts = headerXAuth.split(' ');
                jwt = jwtParts[1];
                caseId = RestContext.request.params.get('caseId');
                cpf = getCpfBycaseId(caseId);
                String UUID = JWTUtility.getJWTBody(jwt).sub;
                Boolean isPrePaid = service.isPrePaid();

                List < CaseComment__c > caseCommentList =  [SELECT Id, ParentId__c, Comment__c, Origin__c, ViewDatetime__c, CreatedDate,IDGedoc__c 
                                                            FROM CaseComment__c 
                                                            WHERE ParentId__c = :caseId 
                                                            ORDER BY CreatedDate ASC
                                                            ];

                //Caso não seja encontrado nenhum caseComment.
                if(caseCommentList.isEmpty()) {
                    res.responseBody = Blob.valueOf(JSON.serialize(new List<String>()));
                    res.statusCode = 200;
                    return;
                }

                generateBusinnesResponse(caseCommentList, caseid);

            } else {
                new ResponseError(RestContext.response, Blob.valueOf(JSON.serialize(new ErrorDisplay('401', 'INVALID_SESSION_ID'))), 401).dispacherErrorResponse();
            }

        } catch (Exception e) {
            new ResponseError(RestContext.response, Blob.valueOf(JSON.serialize(new ErrorDisplay('500', 'INTERNAL_SERVER_ERROR'))), 500).dispacherErrorResponse();
        }
    }

    @HttpPatch
    global static void upsertCaseComment() {

        try {
            RestRequest req = RestContext.request;
            String jwt;
            String caseId;
            String cpf;
            Boolean sucessDataBase = true;
            String body = req.requestBody.toString();
            GetCasesCommentsResponseWrapper caseCommentWrapper = (GetCasesCommentsResponseWrapper) JSON.deserialize(body, GetCasesCommentsResponseWrapper.class);
            Boolean isValidRequest = validateAuthenticationRequest(req, caseCommentWrapper.caseId);

            if (isValidRequest) {
                List < CaseComment__c > newCaseCommentList = new List<CaseComment__c>();
                List < FileLink__c > fileLinkList = new List<FileLink__c>();

                if(caseCommentWrapper.caseCommentRef != null) {
                    newCaseCommentList = fromcaseCommentRefWrapperToCaseComents(caseCommentWrapper);
                }
                if(caseCommentWrapper.fileLinksRef != null) {
                    fileLinkList = fromcaseCommentRefWrapperToFileLink(caseCommentWrapper);
                }

                SavePoint savePointDml = Database.setSavepoint();

                Map<String, Object> upsertResponse = new Map<String, Object>();
                if (newCaseCommentList.size() > 0) {
                    List <String> sucessIds = new List < String > ();
                    List <Database.UpsertResult > upSertResult = Database.upsert(newCaseCommentList, false);
                    for (Database.UpsertResult result: upSertResult) {
                        sucessIds.add(result.getId());
                        if (!result.isSuccess()) {
                            sucessDataBase = false;
                        }
                    }

                    if (!sucessIds.isEmpty()) {
                        List<CaseCommentUpsertResponseWrapper> caseCommentsUpsertResponse = new List<CaseCommentUpsertResponseWrapper>();
                        for (String id: sucessIds) {
                            CaseCommentUpsertResponseWrapper caseCommentUpsertResponse = new CaseCommentUpsertResponseWrapper();
                            caseCommentUpsertResponse.Id = id;
                            caseCommentsUpsertResponse.add(caseCommentUpsertResponse);
                        }
                        upsertResponse.put('caseCommentRef', (Object)caseCommentsUpsertResponse);
                    }

                }

                if (fileLinkList.size() > 0) {
                    List < String > sucessIds = new List < String > ();
                    List < Database.UpsertResult > upSertResult = Database.upsert(fileLinkList, false);
                    for (Database.UpsertResult result: upSertResult) {
                        sucessIds.add(result.getId());
                        if (!result.isSuccess()) {
                            sucessDataBase = false;
                        }
                    }
                    if (!sucessIds.isEmpty()) {
                        List<FileLinkUpsertResponseWrapper> fileLinksUpsertResponse = new List<FileLinkUpsertResponseWrapper>();
                        for (String id: sucessIds) {
                            FileLinkUpsertResponseWrapper fileLinkUpsertResponse = new FileLinkUpsertResponseWrapper();
                            fileLinkUpsertResponse.Id = id;
                            fileLinksUpsertResponse.add(fileLinkUpsertResponse);
                        }
                        upsertResponse.put('fileLinksRef', (Object)fileLinksUpsertResponse);
                    }

                }

                if (fileLinkList.size() == 0 && newCaseCommentList.size() == 0) {

                    sucessDataBase = false;
                }

                if (sucessDataBase) {
                    new ResponseSuccess(RestContext.response, Blob.valueOf(JSON.serialize(upsertResponse))).dispacherSucessResponse();
                } else {
                    Database.rollback(savePointDml);
                    new ResponseError(RestContext.response, Blob.valueOf(JSON.serialize(new ErrorDisplay('400', 'Registros não atualizados/criados, verifique os valores  do registro'))), 500).dispacherErrorResponse();
                }

            } else {
                new ResponseError(RestContext.response, Blob.valueOf(JSON.serialize(new ErrorDisplay('401', 'INVALID_SESSION_ID'))), 401).dispacherErrorResponse();

            }
        } catch (Exception e) {
            new ResponseError(RestContext.response, Blob.valueOf(JSON.serialize(new ErrorDisplay('500', 'INTERNAL_SERVER_ERROR'))), 500).dispacherErrorResponse();

        }

    }

    private static caseCommentRefWrapper fromcaseCommentsTocaseCommentRefWrapper(CaseComment__c caseComemntsParam) {
        caseCommentRefWrapper newCaseCommentRef = new caseCommentRefWrapper();

        newCaseCommentRef.comment = caseComemntsParam.Comment__c == null ? '' : caseComemntsParam.Comment__c;
        newCaseCommentRef.id = caseComemntsParam.id;
        newCaseCommentRef.idGedoc = caseComemntsParam.IDGedoc__c == null ? '' : caseComemntsParam.IDGedoc__c;
        newCaseCommentRef.origin = caseComemntsParam.Origin__c == null ? '' : caseComemntsParam.Origin__c;
        newCaseCommentRef.viewDateTime = caseComemntsParam.ViewDatetime__c == null ? '' : caseComemntsParam.ViewDatetime__c.toString();
        newCaseCommentRef.createdAt = String.valueOf(caseComemntsParam.CreatedDate);

        return newCaseCommentRef;
    }

    private static List<CaseComment__c> fromcaseCommentRefWrapperToCaseComents(GetCasesCommentsResponseWrapper caseCommentWrapper) {
        List <caseCommentRefWrapper> caseCommentRefList = caseCommentWrapper.caseCommentRef;
        List <CaseComment__c> caseCommentList = new List <CaseComment__c>();
        
        if (caseCommentRefList != null) {
            for (caseCommentRefWrapper caseCommentRef: caseCommentRefList) {
                CaseComment__c newCaseComment = new CaseComment__c();

                String id = caseCommentRef.id;
                if (!String.isBlank(id)) { newCaseComment.Id = id; }

                String caseId = caseCommentWrapper.caseId;
                if (!String.isBlank(caseId)) { newCaseComment.ParentId__c = caseId; } 

                String comment = caseCommentRef.comment;
                if (!String.isBlank(comment)) { newCaseComment.Comment__c = comment; }

                String origin = caseCommentRef.origin;
                if (!String.isBlank(origin)) { newCaseComment.Origin__c = origin; }     
                
                String idGedoc = caseCommentRef.idGedoc;
                if (!String.isBlank(idGedoc)) { newCaseComment.IDGedoc__c = idGedoc; }

                String viewDateTime = caseCommentRef.viewDateTime;
                if (!String.isBlank(viewDateTime)) { newCaseComment.ViewDatetime__c = DateTime.valueOfGMT(viewDateTime.replace('T', ' ') + ':00'); }
                
                caseCommentList.add(newCaseComment);
            }
        }
        return caseCommentList;
    }

    private static List<FileLink__c> fromcaseCommentRefWrapperToFileLink(GetCasesCommentsResponseWrapper caseCommentWrapper) {
        List<FileLink__c> fileLinkList = new List<FileLink__c>();
        List <fileLinksWarraper> fileLinksWarraperList = caseCommentWrapper.fileLinksRef;
        
        if (fileLinksWarraperList != null) {
            for (fileLinksWarraper fileWrapper: fileLinksWarraperList) {
                FileLink__c newFileLink = new FileLink__c();
                newFileLink.Case__c = caseCommentWrapper.caseId;
                newFileLink.FileDescription__c = fileWrapper.fileDescription;
                newFileLink.IDGedoc__c = fileWrapper.idGedoc;
                fileLinkList.add(newFileLink);
            }
        }
        return fileLinkList;
    }

    private static void generateBusinnesResponse(List < CaseComment__c > caseCommentList, String caseiD) {
        if (caseCommentList.isEmpty()) {
            new ResponseError(RestContext.response, Blob.valueOf(JSON.serialize(new ErrorDisplay('400', 'BAD_REQUEST'))), 400).dispacherErrorResponse();
        } else {
            GetCasesCommentsResponseWrapper caseWrapper = new GetCasesCommentsResponseWrapper();
            caseWrapper.caseId = caseId;
            caseWrapper.caseCommentRef = new list < caseCommentRefWrapper > ();

            for (CaseComment__c caseComments: caseCommentList) {
                caseWrapper.caseCommentRef.add(fromcaseCommentsTocaseCommentRefWrapper(caseComments));
            }

            new ResponseSuccess(RestContext.response, Blob.valueOf(JSON.serialize(caseWrapper))).dispacherSucessResponse();

        }

    }

    private static Boolean validateAuthenticationRequest(RestRequest req, String bodyCaseId) {
        Boolean isValidAuthentication = false;
        try {
            String caseId = req.params.containsKey('caseId') ? req.params.get('caseId') : bodyCaseId != '' ? bodyCaseId : '';
            String incomingCpf = caseId == '' ? '' : getCpfBycaseId(caseId);
            if(!req.headers.containsKey('x-Authorization') || req.headers.get('x-Authorization') == ''){
                return false;
            }
            String headerXAuth = req.headers.get('x-Authorization');
            String[] jwtParts = headerXAuth.split(' ');
            String incomingJwt = jwtParts[1];
            Boolean isValidJwt = JWTUtility.isValidJwt(incomingJwt);

            if (incomingCpf != null && incomingJwt != null && isValidJwt && incomingCpf != '' && incomingJwt != '') {
                String UUID = JWTUtility.getJWTBody(incomingJwt).sub;
                service = new UUIDService(UUID, incomingCpf);
                isValidAuthentication = service.uuIDIsValid();
            }

            return isValidAuthentication;

        } catch (Exception QueryException) {
            return false;
        }

    }

    private static String getCpfBycaseId(String caseid) {
        Case caseRef = [SELECT Id,Account.documentNumber__c 
                        FROM Case
                        WHERE Id = :caseId
                        limit 1
                        ];
        if (caseRef != null) {
            return caseRef.account.documentNumber__c;
        } else {
            return '';
        }
    }

    public class GetCasesCommentsResponseWrapper {
        public List < caseCommentRefWrapper > caseCommentRef;
        public String caseId;
        public list < fileLinksWarraper > fileLinksRef;
    }

    public class caseCommentRefWrapper {
        public String comment;
        public String id;
        public String idGedoc;
        public String origin;
        public String viewDateTime;
        public String createdAt;
    }

    public class fileLinksWarraper {
        public String id;
        public String fileDescription;
        public String idGedoc;
    }

    public class CaseCommentUpsertResponseWrapper {
        String Id;
    }

    public class FileLinkUpsertResponseWrapper {
        String Id;
    }

    public class ErrorDisplay {
        public String erroCode;
        public String erromsg;

        public errorDisplay(String erroCode, String erroMsg) {
            this.erroCode = erroCode;
            this.erroMsg = erroMsg;
        }
    }

}