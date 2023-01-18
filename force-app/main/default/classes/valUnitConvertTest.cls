@isTest
public class valUnitConvertTest {
    @isTest
    public static void convertByteHigherTargetTest(){
        Long value = 104857600;
        String unitMeasurementValue = 'B';
        String targetUnitMeasurement = 'MB';

        Test.startTest();
        Decimal convertedValue = valUnitConvert.convertByte(value, unitMeasurementValue, targetUnitMeasurement);
        Test.stopTest();
        
        System.assertEquals(100, convertedValue);
    }
    
    @isTest
    public static void convertByteLowerTargetTest(){
        Long value = 100;
        String unitMeasurementValue = 'MB';
        String targetUnitMeasurement = 'B';
        
        Test.startTest();
        Decimal convertedValue = valUnitConvert.convertByte(value, unitMeasurementValue, targetUnitMeasurement);
        Test.stopTest();
        
        System.assertEquals(104857600, convertedValue);
    }
    
    @isTest
    public static void convertByteEqualValuesTest(){
        Long value = 100;
        String unitMeasurementValue = 'MB';
        String targetUnitMeasurement = 'MB';
        
        Test.startTest();
        Decimal convertedValue = valUnitConvert.convertByte(value, unitMeasurementValue, targetUnitMeasurement);
        Test.stopTest();
        
        System.assertEquals(100, convertedValue);
    }
    
    @isTest
    public static void convertByteInvalidValuesTest(){
		Boolean exceptionOccurred = false;
        Long value = 100;
        String unitMeasurementValue = 'Kbit';
        String targetUnitMeasurement = 'MBit';
        
        Test.startTest();
         try{
             
           Decimal convertedValue = valUnitConvert.convertByte(value, unitMeasurementValue, targetUnitMeasurement);
             
         }catch(Exception e){
            exceptionOccurred = true; 
         }
        
        Test.stopTest();
        
        System.assert(exceptionOccurred, 'Parâmetros inválidos');
    }
    
}