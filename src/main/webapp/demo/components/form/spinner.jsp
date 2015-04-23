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
</head>
<body>
    <form id = "formField" class = "yhui-formfield"> 
		<table>
			<tr><td colspan = "4" >数字微调控件的使用实例</td></tr>
			<tr>
				<td>默认</td>
				<td><input type="text" id = "text1" /></td>
				<td>调整幅度（step）</td>
				<td><input type="text" id = "text2" /></td>
			</tr>
			<tr>
				<td>最大最小值</td>
				<td><input type="text" id = "text3" /></td>
				<td>Page值（pagedown/up键）</td>
				<td><input type="text" id="text4" /></td>
			</tr>
			<tr>
				<td>设置值</td>
				<td><input type="text" id = "text5" /></td>
				<td><button>获取值</button></td>
				<td><input type="text" id = "text6" /></td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		YHUI.use( "yhFormField yhDialogTip", function() {
			$( "#formField" ).yhFormField({
				haveTitle: true
			}).submit(function() {
				return false;
			});
			
			//默认的使用方法，使用就是那么简单。相信大家也习惯了。
			$( "#text1" ).spinner();
			
			$( "#text2" ).spinner({
				step: 0.01         	//单击一次增加0.01
			});
			
			$( "#text3" ).spinner({
				max: 5,				//最大值五
				min: 0				//最小值零
			});
			
			$( "#text4" ).spinner({
				step: 0.01,
				page: 100			//按pagedown/up键数字变动的幅度。这个例子中step0.01,page100
									//那么按pageup键，数值就会增加1，而不是0.01。可以看看实例。
			});
			
			
			$( "#text5" ).spinner().spinner( "value", 5 ); //传入字符串"value"和需要的数字5
															//这里的value是spinner的一个方法
			var $text5 = $( "#text6" ).spinner();
			$( "button" ).eq(0).on("click", function() {
				var value = $text5.spinner("value");
				$.yhDialogTip.confirm( value ? value : "请选择", "当前值" );				//这里还是value方法，没有传入相应的数字，就是获取。
			});
		});
	</script>
</body>
</html>
