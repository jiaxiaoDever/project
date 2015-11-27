<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/common/meta.jsp"%>
</head>
<body>
	<div id="mainContent" class="ui-layout-center">
		<div class="ui-layout-center noscroll">
			<form id="searchForm" class="yhui-formfield noborder" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td>导入目录：</td>
						<td><input id="importTable" name="importTable" type="text"/>&nbsp;&nbsp;下载&nbsp;&nbsp;<a id="importTemplet" href="">学生信息模板</a></td>
					</tr>
					<tr>
						<td>导入文件：</td>
						<td ><input type="file" id="upfile" name="upfile"/> 
					</tr>
					<tr>
						<td colspan="2">
						<div id="btn_import" ></div>
					</tr>
				</table>
			</form>
			<table id="successlist"></table>
			<table id="checkFaillist"></table>
			<table id="faillist"></table>
		</div>
	</div>

	<script type="text/javascript">
		var importFlag = '${importFlag}';
		var result = [${result}];
		//var importFlag = '1';
		//var result = [{"successes":[{"addCourseNum":0,"branchId":"","branchName":"市内分点","canSignCourseNum":0,"city":"广州市","common":"","createDate":null,"deleteDate":null,"deleteInfo":"","editDate":null,"exceptionBookNum":0,"isBookedNotic":0,"isImplScoreNotic":0,"isPreImplNotic":0,"jxId":"","jxName":"广州程通驾校","licenseType":"C1","licenseTypeCode":"","lockInfo":"","lockTime":null,"maxNumSign":0,"overCourseNum":0,"password":"","phoneNum":"13512726275","preImplNoticBHour":0,"province":"广东省","qq":"","sex":1,"stAddress":"","stArea":"天河区","stWorkAddress":"","studentCardId":"430221198706062020","studentId":"80a88913-738c-4bd7-9949-f0438baabe9c","studentName":"张三丰","studentStat":"","studentStatCode":"","subjectId":"","subjectName":"科目二","totalCourseNum":0,"unlockTime":null},{"addCourseNum":0,"branchId":"","branchName":"市内分点","canSignCourseNum":0,"city":"广州市","common":"","createDate":null,"deleteDate":null,"deleteInfo":"","editDate":null,"exceptionBookNum":0,"isBookedNotic":0,"isImplScoreNotic":0,"isPreImplNotic":0,"jxId":"","jxName":"广州程通驾校","licenseType":"C1","licenseTypeCode":"","lockInfo":"","lockTime":null,"maxNumSign":0,"overCourseNum":0,"password":"","phoneNum":"15869719159","preImplNoticBHour":0,"province":"广东省","qq":"","sex":0,"stAddress":"","stArea":"天河区","stWorkAddress":"","studentCardId":"430221198706051970","studentId":"45ddd4ba-ed03-4ba7-a9f3-ca1235326422","studentName":"李潇潇","studentStat":"","studentStatCode":"","subjectId":"","subjectName":"科目二","totalCourseNum":0,"unlockTime":null}],"fails":[],"checkFails":[]}];
		var fmsg = '${fmsg}';
		var importType = '${importType}';
		if(importType == '') importType = '4';
		YHUI.use("yhFormField yhLayout yhDropDown zTree yhButton yhGrid", function() {
			$(document.body).yhLayout({});
			var tform = $("#searchForm").yhFormField({});

			var shlist = [ { name: "学生信息", id: 4 },{ name: "驾校信息", id: 1 },{ name: "网点信息", id: 2 },{ name: "教练信息", id: 3 }];
			var tlist = ["href1","href2","href3","href4"];
			$("#importTable").yhDropDown({
				hiddenId:"importType",
				post : "id",
				json : shlist,
				noChild : true,
				onClick : function( e, yhui ){
					$("#importTemplet").text(yhui.node.name +" 模板");
					$("#importTemplet").attr("href",tlist[yhui.node.id-1]);
					importType = yhui.node.id-1;
				}
			}).yhDropDown("parseDrop");
			$("#importTable").yhDropDown("setValue",importType);
			$("#importTemplet").attr("href",tlist[parseInt(importType-1)]);
			$("#btn_import").yhButton({
				form:tform,
			    items: [
			        {
			            type: "save",                 // 按钮的类型，主要是图标不同，更多见下表。
			            // disabled: true,              // 是否禁用按钮。默认 false ，不禁用。
			            onClick: function( e, form ) {  // 按钮的 click 事件
			                // e 事件对象
			                // form 按钮在的表单
			 				var str = $('#upfile').val();
			            	if(str == null || str == ''){
			            		alert("请选择需要导入的excel文件！");
			            		return false;
			            	}
			            	var ftype='.xls,.xlsx,.csv';
			            	var str1=str.substring(str.lastIndexOf("."),str.length).toLowerCase();
			            	if(ftype.indexOf(str1)==-1){
			            		alert("请选择excel文件进行上传！");
			            		$('#upfile').val('');
			            		$('#upfile').focus();
			            		return false;
			            	}
			            	$(tform).attr("action","./importData/"+importType);
			            	$(tform).submit();
			            }
			        }
			    ]
			});
			
			if(importFlag != ''){
				alert(fmsg);
				$("#successlist").yhGrid({
					caption : "导入成功数据列表",
					datatype : "local",
					data : result[0].successes,
					emptyrecords : "无记录",
					gridview : true,
					heightStyle : "fill",
					colModel : models[parseInt(importType-1)]
				});
				$("#faillist").yhGrid({
					caption : "导入失败数据列表",
					datatype : "local",
					data : result[0].fails,
					emptyrecords : "无记录",
					gridview : true,
					heightStyle : "fill",
					colModel : models[parseInt(importType-1)]
				});
				$("#checkFaillist").yhGrid({
					caption : "数据格式异常列表",
					datatype : "local",
					data : result[0].checkFails,
					emptyrecords : "无记录",
					gridview : true,
					heightStyle : "fill",
					colModel : excmodels[parseInt(importType-1)]
				});
				
			}
		});
		
		var excmodels = [[],[],[],[{
			name : "STUDENT_NAME",
			label : "姓名",
			sortable : false
		}, {
			name : "sex",
			label : "性别",
			sortable : false
		}, {
			name : "STUDENT_CARD",
			label : "身份证号",
			sortable : false
		}, {
			name : "PHONE_NUM",
			label : "手机号",
			sortable : false
		}, {
			name : "qq",
			label : "QQ",
			sortable : false
		}, {
			name : "JX_NAME",
			label : "驾校名称",
			sortable : false
		}, {
			name : "BRANCH_NAME",
			label : "网点名称",
			sortable : false
		}, {
			name : "LICENSE_TYPE",
			label : "在考驾照类型",
			sortable : false
		}, {
			name : "SUBJECT_NAME",
			label : "科目名称",
			sortable : false
		}, {
			name : "province",
			label : "所在省",
			sortable : false
		}, {
			name : "city",
			label : "所在地市",
			sortable : false
		}, {
			name : "ST_AREA",
			label : "所在区县",
			sortable : false
		}, {
			name : "ST_ADDRESS",
			label : "住址",
			sortable : false
		}]];
		
		var models = [[],[],[],[{
			name : "studentId",
			label : "学员编号",
			hidden : true,
			sortable : false
		}, {
			name : "studentName",
			label : "姓名",
			sortable : false
		}, {
			name : "sex",
			label : "性别",
			sortable : false
		}, {
			name : "studentCardId",
			label : "身份证号",
			sortable : false
		}, {
			name : "phoneNum",
			label : "手机号",
			sortable : false
		}, {
			name : "qq",
			label : "QQ",
			sortable : false
		}, {
			name : "jxName",
			label : "驾校名称",
			sortable : false
		}, {
			name : "branchName",
			label : "网点名称",
			sortable : false
		}, {
			name : "licenseType",
			label : "在考驾照类型",
			sortable : false
		}, {
			name : "subjectName",
			label : "科目名称",
			sortable : false
		}, {
			name : "province",
			label : "所在省",
			sortable : false
		}, {
			name : "city",
			label : "所在地市",
			sortable : false
		}, {
			name : "stArea",
			label : "所在区县",
			sortable : false
		}, {
			name : "stAddress",
			label : "住址",
			sortable : false
		}, {
			name : "common",
			label : "备注",
			sortable : false
		}, {
			name : "branchId",
			label : "网点编号",
			hidden : true,
			sortable : false
		}, {
			name : "createDate",
			label : "创建时间",
			hidden : true,
			sortable : false
		}, {
			name : "deleteDate",
			label : "删除时间",
			hidden : true,
			sortable : false
		}, {
			name : "deleteInfo",
			label : "删除原因",
			hidden : true,
			sortable : false
		}, {
			name : "editDate",
			label : "编辑时间",
			hidden : true,
			sortable : false
		}, {
			name : "exceptionBookNum",
			label : "异常预约次数",
			hidden : true,
			sortable : false
		}, {
			name : "isBookedNotic",
			label : "课程预约通知开关",
			hidden : true,
			sortable : false
		}, {
			name : "isImplScoreNotic",
			label : "课程结束评价通知开关",
			hidden : true,
			sortable : false
		}, {
			name : "isPreImplNotic",
			label : "课程上课通知开关",
			hidden : true,
			sortable : false
		}, {
			name : "jxId",
			label : "驾校编号",
			hidden : true,
			sortable : false
		}, {
			name : "licenseTypeCode",
			label : "在考驾照类型编码",
			hidden : true,
			sortable : false
		}, {
			name : "lockInfo",
			label : "锁定原因",
			hidden : true,
			sortable : false
		}, {
			name : "lockTime",
			label : "锁定时间",
			hidden : true,
			sortable : false
		}, {
			name : "preImplNoticBHour",
			label : "课程上课通知提前小时数",
			hidden : true,
			sortable : false
		}, {
			name : "stWorkAddress",
			label : "工作地址",
			hidden : true,
			sortable : false
		}, {
			name : "studentStat",
			label : "状态",
			hidden : true,
			sortable : false
		}, {
			name : "studentStatCode",
			label : "状态编码",
			hidden : true,
			sortable : false
		}, {
			name : "subjectId",
			label : "科目编号",
			hidden : true,
			sortable : false
		}, {
			name : "unlockTime",
			label : "解锁时间",
			hidden : true,
			sortable : false
		}, {
			name : "maxNumSign",
			label : "每天最多可约课次数",
			hidden : true,
			sortable : false
		}, {
			name : "canSignCourseNum",
			label : "可预约课次数",
			hidden : true,
			sortable : false
		}, {
			name : "overCourseNum",
			label : "已预约课次数",
			hidden : true,
			sortable : false
		}, {
			name : "addCourseNum",
			label : "新增可约课次数",
			hidden : true,
			sortable : false
		}, {
			name : "totalCourseNum",
			label : "总约课次数",
			hidden : true,
			sortable : false
		} ]];

	</script>
</body>
</html>