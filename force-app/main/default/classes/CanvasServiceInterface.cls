public interface CanvasServiceInterface {
    String getConnectedAppName();
    Map<String,Object> getParameters(List<String> listRecordId, String tipoOferta);
}