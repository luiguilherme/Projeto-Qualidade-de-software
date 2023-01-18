({    
    scriptsLoaded : function(component, event, helper, listMovel, listMes, listFixa) {

		var canvasId = component.get('v.canvasId');
        var corFixa = component.get('v.corfixa');
        var cormovel = component.get('v.cormovel');

        let lElement = document.getElementById(canvasId);
        if ( !lElement ) return;
        var chartHistory = lElement.getContext('2d');
        var data = [{
            label: 'Fixa',
            backgroundColor: corFixa,
            data: listFixa,
        }, {
            label: 'Móvel',
            backgroundColor: cormovel,
            data: listMovel, 
        }];
        window.myChartHistoricoFaturas = new Chart(chartHistory, {
            type: 'bar',
            data: {
                labels: listMes,
                datasets: data,
            },
            options: {
                tooltips: {
                    enabled: false,
                    displayColors: true,
                    callbacks:{
                        mode: 'x',
                    },		
                },
                scales: {
                    xAxes: [{
                        stacked: true,
                        gridLines: {
                            display: false,
                        }
                    },
                            {
                                type: 'category',
                                offset: true,
                                position: 'top',
                                ticks: {
                                    fontColor: "#6e00f5",
                                    fontStyle: 'bold',
                                    callback: function(value, index, values) {
                                        var sum = Math.floor(data[0].data[index]*100)/100 +  Math.floor(data[1].data[index]*100)/100;
                                        sum = Math.floor(sum*100)/100;
                                        sum = sum.toFixed(2);
                                        sum = sum.replace('.', ',');
                                        return sum;
                                    }
                                },
                            }],
                    yAxes: [{
                        stacked: true,
                        ticks: {
                            beginAtZero: false,
                            userCallback: function(value, index, values) {
                                // Convert the number to a string and splite the string every 3 charaters from the end
                                value = JSON.stringify(value).replace('.', ',');
                                value = value.toString();
                                value = value.split(/(?=(?:...)*$)/);
                                
                                // Convert the array to a string and format the output
                                value = value.join('.');
                                return 'R$ ' + value;
                            }
                        },
                        type: 'linear',
                    }]
                },
                legend:{
                    display: true, 
                    position: 'bottom',
                },
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    datalabels: {
                        align: 'center',
                        anchor: 'bottom',
                        color: 'white',
                        formatter: function(value, context) {
                            value = ( !value || value == 0 ) ? '' : value.toFixed(2);
                            return value.replace('.', ',');
                        }
                    }
                },
            },
        });       
    },
    loadTabelaFixaMovel: function(component, event, helper){
        var action = component.get("c.getComboFixa");
        action.setParams({
            "accountId": component.get('v.recordId') 
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var retorno = response.getReturnValue();
                retorno = JSON.parse(retorno);
                component.set('v.dataTableFixaMovel', retorno);
                var listMes = [];
                var listMovel = [];
                var listFixa = [];
                
                retorno = retorno.reverse();
                
                for(let i=0; i<retorno.length; i++){
                    if(retorno[i].mes){
                        listMes[i]=(retorno[i].mes);
                    }
                    if(retorno[i].movel){
                        retorno[i].movel == 0 ? listMovel[i]=0 :listMovel[i]=((retorno[i].movel *100)/100);
                    }
                    if(retorno[i].fixa || retorno[i].fixa == 0){
                        retorno[i].fixa == 0 ? listFixa[i]=0 :listFixa[i]=((retorno[i].fixa *100)/100);
                    }
                    if(listMovel.length < listFixa.length){
                        listMovel[i] = 0;
                    } else if (listFixa.length < listMovel.length){
                        listFixa[i] = 0;
                    }
                }
                if ( component.get("v.scriptsLoaded") ){
					this.scriptsLoaded(component, event, helper,listMovel, listMes, listFixa);
                }                
            }
        });
        $A.enqueueAction(action);
        
    },

	helperSetCanvasId : function(component, event, helper){
		component.set('v.canvasId', generateUUID());

		function generateUUID() { // Public Domain/MIT
			var d = new Date().getTime();//Timestamp
			var d2 = (performance && performance.now && (performance.now()*1000)) || 0;//Time in microseconds since page-load or 0 if unsupported
			return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
				var r = Math.random() * 16;//random number between 0 and 16
				if(d > 0){//Use timestamp until depleted
					r = (d + r)%16 | 0;
					d = Math.floor(d/16);
				} else {//Use microseconds since page-load if supported
					r = (d2 + r)%16 | 0;
					d2 = Math.floor(d2/16);
				}
				return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
			});
		}
	}
})