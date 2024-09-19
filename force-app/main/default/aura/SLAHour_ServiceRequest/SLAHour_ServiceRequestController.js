({
  calculateSLA: function(component, event, helper) {
    debugger;
    var simpleRecord = component.get("v.simpleRecord");
    var title = component.get("v.title");
    var iConName = component.get("v.iConName");
    console.log("Simple record", simpleRecord);
    title = "SLA Não Iniciado";
    iConName = "standard:business_hours";

    if (simpleRecord.DueDate__c) {
      title = "SLA Concluído";
      if (!simpleRecord.ClosingDateTime__c) {
        title = "SLA Em Andamento";
      }
      var now = new Date().getTime();
      var targetTime = new Date(simpleRecord.DueDate__c).getTime();

      var workflowPreSales = component.get("v.workflowPreSales");
      var OpeningDateTime__c = new Date(
        simpleRecord.OpeningDateTime__c
      ).getTime();
      var paused = simpleRecord.isPausedTime__c;

      if (now > targetTime) {
        title = "SLA Estourado";
        iConName = "standard:first_non_empty";
      }

      if (workflowPreSales) {
        helper.getutilDays(component);
        var t =
          ((now - OpeningDateTime__c) / (targetTime - OpeningDateTime__c)) *
          100;
        if (t > 70 && t < 100) {
          title = "SLA Crítico";
          iConName = "standard:timeslot";
        }
        if (paused) {
          title = "SLA Pausado";
          iConName = "standard:date_time";
        }
        if (t < 0) {
          component.set("v.hideValues", true);
        }
        if (simpleRecord.ClosingDateTime__c) {
          title = "SLA Concluído";
          iConName = "standard:date_time";
        }
      }
    }
    component.set("v.title", title);
    component.set("v.iConName", iConName);

    component.set("v.stopInterval", false);
    if (!simpleRecord) {
      return;
    }

    helper.calculate(component, simpleRecord);

    var timer = setInterval(function() {
      if (component.get("v.stopInterval") || simpleRecord.ClosingDateTime__c) {
        clearInterval(timer);
        return;
      }
      helper.calculate(component, simpleRecord);
      var stopInterval = component.get("v.stopInterval");
      if (stopInterval) {
        clearInterval(timer);
      }
    }, 60000);
  }
});