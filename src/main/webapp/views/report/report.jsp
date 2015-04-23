<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/common/meta.jsp" %>
<link rel="stylesheet" type="text/css" href="${ctx}/views/report/css/report.css"  media="screen" />
<title>报表查看主页面</title>
</head>
<body>
<div id="mainContent" class="ui-layout-center" >
	<div class="ui-layout-center noscroll">
		<iframe id = "main1" name = "main1" style = "width:100%; height: 100%;" frameborder="0"></iframe>
	</div>
	<div class="ui-layout-south">
		<!-- 评论显示区 -->
		
		<div class="ui-layout-south">
			
			
			<dl id = "commentView" class = "rpt-comment">
				<dt>
					<strong>评论</strong>
					 共&nbsp;<span id='num'><s:property value="%{entity.noteList.size()}" /></span>&nbsp;条  
					评论
					<span class="" style="float:right;"><a class="comment" id ="comment">发表评论</a></span>
				</dt>
				<dd id="commentHeader">
				
				</dd>
				
			</dl>
		</div>
	</div>
	
	<div id="editForm"></div>
</div>


		
		
		
		
		
		
		
	<script type="text/javascript">
		var reportId = '${param.reportId}';
		var reportName = '${param.name}';
		var crewData ;
		YHUI.use("yhFormField yhLayout yhDropDown yhWindow yhSelector yhDialogTip yhButton", function() {
			$(document.body).yhLayout({
				north__resizable: false
			});
			$("#mainContent").yhLayout({
				south: {
					size: 0.3
				}
			});

			
			//初始化数据
			$("#main1").attr('src','${param.url}');
			
			//加载评论信息
			$.ajax({ 
				async: true, 
				type : "POST", 
				url : ctx+'/'+'report/getReportNotes', 
				data:{
					reportId:reportId
				},
				dataType : 'json', 
				success : function(data) { 
					var list = data; 
					if(list){
						var commentHeader = $('#commentHeader');
						for(var i =0,len = list.length; i< len;i++){
							var rec = list[i];
							var tr1 = $('<div class = "rpt-commentInfo">&nbsp;&nbsp;&nbsp;评论人：<span style=\'color:#006699;\'>'+rec.userName+'</span>评论时间： &nbsp;'+rec.commonDate+'</div>');
							var tr2 = $('<div class = "rpt-commentContent">&nbsp;&nbsp;&nbsp;'+rec.msg+'</div>');	
							commentHeader.after(tr2).after(tr1);
						}
						$('#num').text(list.length);
					}else{
						$('#num').text(0);
					}
				} 
			}); 
			
			var crew = "<input type=\"text\" id=\"crewList\" name=\"crewList\"  />（评论时此项不填）";
			var model =[{
					name : "type",
					label : "转发方式",
					field : {
						editor : 'dropdown',
						config : {
							hiddenId : "type",
							noChild:true,
							json:[{name:"评论",id:"0"},{name:"转发",id:"2"}],
							post : "name",
							customContent: "",
							onClick: function( e, yhui ) {
									if(yhui.node.id=='0'){
										$("#crewList").attr("disabled",true);
										
									}else if(yhui.node.id == '2'){
										$("#crewList").attr("disabled",false);
									}
									
							}
						}
					},
					sortable : false
				},{
					name : "crewList",
					label : "转发目标",
					id:'toUsers',
					hidden : true,
					field : {
						editor : crew
					},
					sortable : false
				}, {
					name : "msg",
					index : "msg",
					label : "信息",
					hidden : true,
					field : {
						editor : "textarea",
						hidden : false
					},
					sortable : false
				}];
			var formDiv =$("#editForm");
			
			//创建
			WinUtils.createEditWin(formDiv, model, null,null);
			formDiv.buttonDiv = $('<div>').insertAfter(formDiv[0]);
			//初始化发表评论的按钮
			formDiv.buttonDiv.yhButton({
			align : "right",
			form : formDiv,
			items : [ {
				type : "save",
				onClick : function(e, form) {
					var data ={};
					data = $.yhui.mapForm(form);
					var param={};
					param["reportId"] = reportId;
					param["name"] = reportName;
					param["msg"] = data.msg;
					param["type"] =data.type =='转发'?2:0;
					param["messageurl"] ='${param.url}';
					param["receiveId"] =crewData;
					param["receiveName"] = data.crewList;
					
					//添加评论信息
					$.ajax({ 
						async: true, 
						type : "POST", 
						url : ctx+'/'+'report/saveNote', 
						data:param,
						dataType : 'json', 
						success : function(data) { 
							
							var num =$('#num').text();
							
							var commentHeader = $('#commentHeader');
							
							var tr1 = $('<div class = "rpt-commentInfo">&nbsp;&nbsp;&nbsp;评论人：<span style=\'color:#006699;\'>'+data.userName+'</span>评论时间： &nbsp;'+data.commonDate+'</div>');
							var tr2 = $('<div class = "rpt-commentContent">&nbsp;&nbsp;&nbsp;'+data.msg+'</div>');	
							commentHeader.after(tr2).after(tr1);
							
							$('#num').text(parseInt(num)+1);
							formDiv.yhWindow("close");
						} 
					}); 
				}
			},{
				type : "cancel",
				onClick : function() {
					
					formDiv.yhWindow("close");
					
				}
			} ]
		});
			
			//发表评论
			$("#comment").click(function(){
				var data = [];
				data.push({name:"评论",id:"type"});
				WinUtils.fillFrom(formDiv, data, model);
				formDiv.yhWindow("open","发表评论");
			});
			
			//单击弹出选择转发人员
			$("#crewList").click(function(){
				$("#crewList").removeClass().addClass("yhui-form-text");
				dispWindow('转发人员选择',ctx + '/views/report/crewList.jsp?vali=');
			});
			
		});
		
		function dispWindow(title,url){
				var $wrap = $("<div></div>"),
					$ifr = $("<iframe name='_tempframe' style = 'width:100%;height:300px' allowTransparency='true' frameborder = '0'></iframe>");
				$wrap.appendTo( document.body ).yhWindow({
					    modal:true,
			            title: title,
			            width: 700,
			            //height:260,
			            position: [ "center", "center-15%" ],
			            resizable: false,
			            showTaskBar: false,
			            open: function( e, ui ) {
			                $ifr.appendTo( $(this) ).prop( "src" ,url );
			            },
			            close: function() {
			                var $ifr = $(this).find("iframe");
			                $ifr.length && $ifr.remove();
			                $.yhui.isIE && CollectGarbage();
			                $(this).yhWindow( "destroy" ).remove();
			            },
			            buttons:{
							'确定':	function(){ 
						        var cwb = $(window.frames["_tempframe"].document).find("#rolesubBtn");
								$(cwb).trigger('click');
								var vali = $(window.frames["_tempframe"].document).find("#vali").val();
								var crli = $(window.frames["_tempframe"].document).find("#crewList").val();
								var isTrue = false;
								if(vali != "") isTrue = true;
								if(isTrue){
									crewData = vali;
									$("#crewList").val(crli);
									$(this).yhWindow( "destroy" ).remove();
									return;
							    }else{
							    	$.yhDialogTip.alert( "人员列表不能为空！", "系统提示！" );
							    }
							},	'取消':	function(){ 
								$(this).yhWindow( "destroy" ).remove(); 
							}
						}
			        });
			
		}
		
	</script>
</body>
</html>