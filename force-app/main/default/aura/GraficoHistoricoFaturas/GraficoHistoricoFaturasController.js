( {
    doInit : function(component, event, helper) {
		helper.helperSetCanvasId(component, event, helper);
        helper.loadTabelaFixaMovel(component, event, helper); 
	},

	geraChart: function(component, event, helper) {
        component.set("v.scriptsLoaded", true);
        helper.loadTabelaFixaMovel(component, event, helper); 
    },

	/*gotoURL: redireciona o para a URL URLGraficoHistoricoFaturas*/
    gotoURL : function (component)  {
        var urlparam = component.get('v.URLGraficoHistoricoFaturas');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams( {
          "url": urlparam + component.get('v.recordId')
        });
        urlEvent.fire();
    }
})