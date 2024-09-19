({
  calculate: function(component, simpleRecord) {
    var dataDeTermino = simpleRecord.ClosingDateTime__c;

    var targetDate = simpleRecord.DueDate__c
      ? new Date(simpleRecord.DueDate__c)
      : null;
    if (!targetDate) {
      component.set("v.stopInterval", true);
    }

    var now = dataDeTermino ? new Date(dataDeTermino) : new Date().getTime();

    var timeLeft = this.formatedeDate(0, 0, 0);
    var titleSLArestante = "Tempo Restante";
    if (targetDate) {
      var dt1 = targetDate;
      var dt2 = now;

      if (now > targetDate) {
        dt1 = now;
        dt2 = targetDate;
        titleSLArestante = "Tempo de SLA violado";
      }
      timeLeft = this.calculateTime(dt1, dt2);
    }
    component.set("v.tempoRestante", timeLeft);

    var initDate = simpleRecord.OpeningDateTime__c
      ? new Date(simpleRecord.OpeningDateTime__c)
      : null;
    timeLeft = initDate
      ? this.calculateTime(now, initDate)
      : this.formatedeDate(0, 0, 0);
    component.set("v.titleSlaRestante", titleSLArestante);
    component.set("v.tempoDecorrido", timeLeft);
  },

  calculateTime: function(dateTimeCom1, dateTimeCom2) {
    var distance = dateTimeCom1 - dateTimeCom2;
    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
    var hours = Math.floor(
      (distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
    );
    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    //var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    return this.formatedeDate(days, hours, minutes);
  },

  formatedeDate: function(days, hours, minutes) {
    return days + " Dias " + hours + " Horas " + minutes + " Minutos ";
  },

  getutilDays: function(component) {
    const workflowPreSales = component.get("v.workflowPreSales");
    const simpleRecord = component.get("v.simpleRecord");

    if (!workflowPreSales || simpleRecord.ClosingDateTime__c) return;

    var action = component.get("c.getBusinessHourDiff");
    action.setParams({
      BusinessHourId: simpleRecord.BusinessHoursId,
      startDate: new Date(), //simpleRecord.OpeningDateTime__c,
      endDate: simpleRecord.DueDate__c
    });

    action.setCallback(this, function(response) {
      var state = response.getState();
      if (state === "SUCCESS") {
        const diffMilisseconds = response.getReturnValue();

        component.set(
          "v.diffUtilDays",
          Math.floor(diffMilisseconds / (1000 * 60 * 60 * 8))
        );
      }
    });
    $A.enqueueAction(action);
  }
});