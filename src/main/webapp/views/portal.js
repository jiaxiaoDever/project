var YHPORTAL = function(){
	return{
		init:function(){
			var data1= [
			{company:'3m Co', price:1.72, change:0.02,  pctChange:0.03},
			{company:'Alcoa Inc', price:29.01,change: 0.42,  pctChange:1.47},
			{company:'Altria Group Inc', price:83.81, change:0.28, pctChange: 0.34},
			{company:'American Express Company', price:52.55, change:0.01, pctChange: 0.02},
			{company:'American International Group, Inc.',  price:64.13, pctChange:0.31, change: 0.49},
			{company:'AT&T Inc.',price:31.61,change: -0.48, pctChange:-1.54},
			{company:'Boeing Co.', price:75.43, change:0.53,  pctChange:0.71},
			{company:'Caterpillar Inc.', price:67.27, change:0.92,  pctChange:1.39},
			{company:'Citigroup, Inc.', price:49.37, change:0.02, pctChange: 0.04},
			{company:'E.I. du Pont de Nemours and Company', price:40.48, change:0.51, pctChange: 1.28},
			{company:'Exxon Mobil Corp',price:68.1,  change:-0.43, pctChange:-0.64}
		    ];
			var model_1 =[ {
					name : "company",
					index : "company",
					label : "公司名",
					sortable : false
				}, {
					name : "price",
					index : "price",
					label : "价格",
					sortable : false
				}, {
					name : "change",
					index : "change",
					label : "变化",
					sortable : false
				} , {
					name : "pctChange",
					index : "pctChange",
					label : "环比",
					sortable : false
				} ];
				
			var grid = $( "#list1" ).yhGrid({
					data: data1,
                    datatype: "local",
                    heightStyle: "fill",
                    colModel: model_1
                });
                
            $("#rptlist").append("<a href=\"#\" >OBD端口占用分析</a><br/>");
            $("#rptlist").append("<a href=\"#\" >代维工单</a><br/>");
            $("#rptlist").append("<a href=\"#\" >FTTX分析</a><br/>");
            $("#rptlist").append("<a href=\"#\" >LAN端口占用分析</a><br/>");
            $("#rptlist").append("<a href=\"#\" >OBD端口占用分析</a><br/>");
            $("#rptlist").append("<a href=\"#\" >OBD总体分析</a><br/>");
            $("#rptlist").append("<a href=\"#\" >区域分析</a><br/>");
            
            var checkObj = this.checkFlash();
            if(checkObj.iFlash){
	           var chart1 = new AnyChart(ctx+'/static/anychart/swf/AnyChart.swf');
				chart1.width = '100%';
				chart1.wMode = 'transparent';// transparent opaque
				chart1.height = '100%';
				chart1.setXMLFile(ctx+'/views/sample/sample_189.xml');
				chart1.write('sample1');
	
				 var chart2 = new AnyChart(ctx+'/static/anychart/swf/AnyChart.swf');
				chart2.width = '100%';
				chart2.wMode = 'transparent';// transparent opaque
				chart2.height = '100%';
				chart2.setXMLFile(ctx+'/views/sample/sample_216.xml');
				chart2.write('sample2');
				
				 var chart3 = new AnyChart(ctx+'/static/anychart/swf/AnyChart.swf');
				chart3.width = '100%';
				chart3.wMode = 'transparent';// transparent opaque
				chart3.height = '100%';
				chart3.setXMLFile(ctx+'/views/sample/sample_19.xml');
				chart3.write('sample3');
				
				var chart4 = new AnyChart(ctx+'/static/anychart/swf/AnyChart.swf');
				chart4.width = '100%';
				chart4.wMode = 'transparent';// transparent opaque
				chart4.height = '100%';
				chart4.setXMLFile(ctx+'/views/sample/sample_123.xml');
				chart4.write('sample4');
            }else{
            	var htmlstr ="<p>您的浏览器未安装flash插件,请下载安装后刷新此页面</p>";
            	$("#sample1").html(htmlstr);
            	$("#sample2").html(htmlstr);
            	$("#sample3").html(htmlstr);
            	$("#sample4").html(htmlstr);
            }

		},
		
		checkFlash:function () {
			var iFlash = null;
		    var version = null;
		    var isIE = navigator.userAgent.toLowerCase().indexOf("msie") != -1
		    if(isIE){
		        //for IE
		        if (window.ActiveXObject) {
		            var control = null;
		            try {
		                control = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
		            } catch (e) {
		                iFlash = false;
		            }
		            if (control) {
		                iFlash = true;
		                version = control.GetVariable('$version').substring(4);
		                version = version.split(',');
		                version = parseFloat(version[0] + '.' + version[1]);
		               
		            }
		        }
		    }else{
		        //for other
		        if (navigator.plugins) {
		          for (var i=0; i < navigator.plugins.length; i++) {
		            if (navigator.plugins[i].name.toLowerCase().indexOf("shockwave flash") >= 0) {
		              iFlash = true;
		              version = navigator.plugins[i].description.substring(navigator.plugins[i].description.toLowerCase().lastIndexOf("Flash ") + 6, navigator.plugins[i].description.length);
		            }
		          }
		        }
		    }
		    
		    return {
		    	iFlash:iFlash,
		    	version:version
		    };
		    
		   }
	};
}();