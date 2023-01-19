public class valUnitConvert {
	public class applicationException extends Exception {}
    
    public static Decimal convertByte(Long value, String unitMeasurementValue, String targetUnitMeasurement){
            
        List<String> dataMeasurementList = new List<String>();
        Decimal convertedValue;
        
        dataMeasurementList.add('B');
        dataMeasurementList.add('KB');
        dataMeasurementList.add('MB');
        dataMeasurementList.add('GB');
        dataMeasurementList.add('TB');
        
        Integer valueIndex = dataMeasurementList.indexOf(unitMeasurementValue);
        Integer targetIndex = dataMeasurementList.indexOf(targetUnitMeasurement);
        Integer multiplicationFactor = targetIndex - valueIndex;
        
        If(valueIndex == -1 || targetIndex == -1){
            throw new applicationException('Parâmetros inválidos');
            
        } else if (valueIndex == targetIndex) {
            return (Decimal)value; 
        }
        
        If(multiplicationFactor > 0){
            convertedValue = value / Math.pow(1024, multiplicationFactor);
        } 
        else if (multiplicationFactor < 0){
            convertedValue = value * Math.pow(1024, Math.abs(multiplicationFactor));
        }
        
        return convertedValue.setscale(2);
    }    
}