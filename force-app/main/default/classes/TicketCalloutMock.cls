@isTest
global class TicketCalloutMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"ticket_id":"08082019-9732221","start_date":"2019-08-08T00:00:00Z","end_date":"2019-08-08T00:00:01Z","status":"OPEN","reason":"Problemas de conexão da Banda Larga"},{"ticket_id":"08082019-9732222","start_date":"2021-02-08T00:00:00Z","end_date":"2021-02-08T00:00:01Z","status":"OPEN","reason":"Problemas de conexão vivo movél"},{"ticket_id":"08082019-9732223","start_date":"2021-01-08T00:00:00Z","end_date":"2021-01-08T00:00:01Z","status":"OPEN","reason":"Linha de telefone mudo"},{"ticket_id":"08082019-9732224","start_date":"2020-08-08T00:00:00Z","end_date":"2020-08-08T00:00:01Z","status":"OPEN","reason":"Cabo da fibra otica danificado"},{"ticket_id":"08082019-9732225","start_date":"2020-05-08T00:00:00Z","end_date":"2020-06-08T00:00:01Z","status":"OPEN","reason":"Chip sem linha"}]');
        response.setStatusCode(200);
        return response;
    }
}