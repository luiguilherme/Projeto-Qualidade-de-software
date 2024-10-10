/**
 * @author Ronan Michel
 * @company Everis do Brasil
 * @description Esta classe faz o calculo de horas úteis.
 **/
public with sharing class CalculateWorkingTime {

    public class WrapperTimeWorked {
        public String lRecord;
        public Id lBusinessHourId;
        public Datetime lDateInit; 
        public DateTime lDateEnd;

        public WrapperTimeWorked(String aRecordId, Id aBusinessHourId, Datetime aDateInit, DateTime aDateEnd) {
            this.lRecord = aRecordId;
            this.lBusinessHourId = aBusinessHourId;
            this.lDateInit = aDateInit;
            this.lDateEnd = aDateEnd;
        }
    }

    /*
      Método para retornar uma DateTime, de horas úties com base no valor da variável "aWorkingMinute".
      aMapDateTimeByRecord => Map com o Id do Registro e o DateTime que deseja recalcular
      aWorkingMinuteByRecord => Map com o Id do Registro e os minutos para usar no calculo da hora útil.
     */
    public static Map<String, Datetime> calculateTime(Map<String, Datetime> aMapDateTimeByRecord, Map<String, Map<String, Integer>> aWorkingMinuteByRecord, Map<String, Id> aMapBusinessHourByRecordId, String aType) {
        Map<String, Datetime> lMapDateTimeCalculate = new Map<String, Datetime> ();

        if (aMapDateTimeByRecord == null || aWorkingMinuteByRecord == null || aWorkingMinuteByRecord.isEmpty() || aMapBusinessHourByRecordId.isEmpty()) { return lMapDateTimeCalculate; }

        for (String iIdRecord : aMapDateTimeByRecord.keySet()) {
            if (!aWorkingMinuteByRecord.containsKey(iIdRecord) || !aMapBusinessHourByRecordId.containsKey(iIdRecord)) { continue; }
            Id iIdBusinessHour = aMapBusinessHourByRecordId.get(iIdRecord);
            if (String.isBlank(iIdBusinessHour)) { continue; }

            DateTime iDateTime = aMapDateTimeByRecord.get(iIdRecord);

            Map<String, Integer> lMapType = aWorkingMinuteByRecord.get(iIdRecord);
            if (!lMapType.containsKey(aType)) { continue; }

            iDateTime = (BusinessHours.isWithin(iIdBusinessHour, iDateTime)) ? iDateTime : BusinessHours.nextStartDate(iIdBusinessHour, iDateTime);

            Integer iWorkingMinute = lMapType.get(aType);

            Long iDistance = iWorkingMinute * 60000;
            DateTime iNewDateTime = BusinessHours.add(iIdBusinessHour, iDateTime, iDistance);

            lMapDateTimeCalculate.put(iIdRecord, iNewDateTime);
        }

        return lMapDateTimeCalculate;
    }
    /*
      Método para retornar os minutos úteis minutos úteis trabalhados entre duas datas.
    
    public static Map<String, Decimal> calculateHoursWorked(List<WrapperTimeWorked> aListTimeWorked) {

        Map<String, Decimal> lMapMinutesWorkedTime = new Map<String, Decimal> ();
        if (aListTimeWorked == null || aListTimeWorked.isEmpty()) { return lMapMinutesWorkedTime; }

        for (WrapperTimeWorked iWorked : aListTimeWorked) {
            if (String.isBlank(iWorked.lBusinessHourId) || String.isBlank(iWorked.lRecord) || iWorked.lDateInit == null || iWorked.lDateEnd == null) { continue; }

            Id iIdBusinessHours= iWorked.lBusinessHourId;
            Long iDiferenceInMiliSeconds= BusinessHours.diff(iIdBusinessHours, iWorked.lDateInit, iWorked.lDateEnd);
            Decimal iMinutes= iDiferenceInMiliSeconds / 60000;
            lMapMinutesWorkedTime.put(iWorked.lRecord, iMinutes);
        }

        return lMapMinutesWorkedTime;
    } */

}