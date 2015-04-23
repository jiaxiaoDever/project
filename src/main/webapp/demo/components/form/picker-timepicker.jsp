<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>Document</title>
<meta name="description" content="">
<meta name="keywords" content="">
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/meta.jsp" %>
<style type="text/css">
		h4 { padding:10px 0 10px 35px; }
		h5 { padding:10px 35px 10px 0; text-align:right; }
</style>
</head>
<body>
     <h4>欢迎使用日期、时间选择器，对应html路径 form/timePicker.html</h4>
    <form id = "field" class = "yhui-formfield" >
		<table>
			<tr><td colspan = "4">时间选择器</td></tr>
			<tr>
				<td>默认：</td>
				<td><input  type="text" id="timepicker1"/></td>
				<td>AM/PM</td>
				<td><input  type="text" id="timepicker2"/></td>
			</tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
			<tr>
				<td>纯时间：</td>
				<td><input  type="text" id="timepicker3"/></td>
				<td>自定义字符串格式</td>
				<td><input  type="text" id="timepicker4"/></td>
			</tr>
			<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
			<tr>
				<td>控制时分秒甚至微秒的显示</td>
				<td><input  type="text" id="timepicker5"/></td>
				<td>设置默认时间</td>
				<td><input  type="text" id="timepicker6"/></td>
			</tr>
			<tr><td colspan = "4">日期选择器</td></tr>
			<tr>
				<td>默认</td>
				<td><input type="text" id="datepicker1" /></td>
				<td>自定义格式yy-mm-dd</td>
				<td><input type="text" id="datepicker2" /></td>
			</tr>
			<tr>
				<td>最大最小值（过去5天未来5天）</td>
				<td><input type="text" id="datepicker3" /></td>
				<td><button>获取值</button></td>
				<td><input type="text" id="datepicker4" /></td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		YHUI.use("yhDropDown yhFormField zTree yhDialogTip datetimepicker", function() {
			$("#field").yhFormField({
                haveTitle: true
            }).on("submit", function() {
			    return false;
			});
			
			$("input:text").val("");
			
			/********************
			**时间选择器
			********************/
			var $tp1 = $('#timepicker1').datetimepicker();//默认API

			$tp1.datetimepicker( "setDate", $.yhui.stringToDate( "2012-08-07 22:22:11" ) );
			
			$('#timepicker2').datetimepicker({
				ampm:true // 显示上下午
			});
			
			//只显示时间选择器
			$('#timepicker3').timepicker({});
			
			//自定义字符串格式
			$('#timepicker4').datetimepicker({
				dateFormat:'yy-mm-dd',   //日期格式
				timeFormat: 'h:m',       //时间格式
				separator: '@'           //日期与时间的分隔符            
			});

			$('#timepicker5').datetimepicker({
				showSecond:true,
				showMillisec:true,
				timeFormat: 'hh:mm:ss:l'
			});

			$('#timepicker6').datetimepicker({ 
				hour: 13, 
				minute: 15 
			});
			
			/********************
			**日期选择器
			********************/
			//默认
			//这里我们调用了一个方法 "setDate", 将值设置到"7/30/2012"
			//这个传入的字符串也有考究。这里 dateFomat 默认是 mm/dd/yy,所有可以这样设置。
			//如下第二个例子， dateFormat自定义为 yy-mm-dd，那么就要设成“2012-7-30”。总之，保持一致。
			$( "#datepicker1" ).datepicker().datepicker( "setDate", "7/30/2012" );
			//自定义格式
			$( "#datepicker2" ).datepicker({
				dateFormat: "yy-mm-dd"
			})
			//最大最小值
			$( "#datepicker3" ).datepicker({
				maxDate: 5,
				minDate: -5
			});
			//获取值
			$( "#datepicker4" ).datepicker();
			$( "button" ).eq(0).click(function(){
				//$().datepicker( "getDate" ) 是获取当前时间的方法，不过他获取的是一个date对象。下面这话转化成了字符串。
				//如果你想直接获得 input 中的字符串，应该知道怎么做吧？？		
				var value = $( "#datepicker4" ).datepicker( "getDate" );
				value ? (value = value.toString()) : (value = "请点选");
				
				$.yhDialogTip.confirm( value, "当前值为" );
			});
		});
	</script>
</body>
</html>
