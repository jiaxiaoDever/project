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
   <form id = "field" class = "yhui-formfield" >
		<table>
			<tr>
				<td>姓名</td>
				<!-- 看下一行，属性data-validation-engine就是用来验证的，FormField会自动嗅探。 -->
				<td><input name = "name" type="text" id="text1" data-validation-engine = "validate[required]" /></td>
				<td>年龄</td>
				<!-- 这里是数字微调，data-type设置类型，data-default设置默认值 -->
				<td><input id = "spinner" name = "age"  type="text" data-type = "yhspinner" data-default = "25" data-validation-engine = "validate[required]" /></td>
			</tr>
			<tr>
				<td>性别</td>
				<td><input name = "sex"  type="text" id="text3" /></td>
				<td>出生年月</td>
				<!-- 这里是日期选择器，三个属性……不解释 -->
				<td><input name = "birth"  type="text" data-type = "datepicker" data-default = "-7d" data-validation-engine = "validate[required]" /></td>
			</tr>
			<tr>
				<td>日期时间选择器</td>
				<td>
					<!-- 日期时间选择器 -->
					<input type="text" name = "timepicker" data-type = "datetimepicker" data-default = "now" data-validation-engine = "validate[required]" />
				</td>
				<td>日期联动</td>
				<td>
					<!-- 昱辉日期联动选择器 -->
					<input type="text" name = "linkDate" data-type = "yhdatepicker" data-validation-engine = "validate[required]" />
				</td>
			</tr>
			<tr>
				<td>做个ajax验证</td>
				<td>
					<input type="text" name="loginName" id="ajax" data-validation-engine = "validate[required,ajax[yhAjax]]" >
					只有"yhui"才能通过
				</td>
				<td>昱辉下拉框</td>
				<td>
					<!-- 下拉框，为了让验证的过程不是那么突兀，仍要设置两个属性。 -->
					<input type="text" name="tree1" id="dtext" data-type = "yhdropdown"  data-validation-engine = "validate[required]" />
				</td>
			</tr>
			<tr>
				<td>做个电话验证</td>
				<td>
					<input type="text" name="phone" id="phone" data-validation-engine = "validate[required,custom[yhPhone]]">
					类似"020-xxxxxxxx"或者"020xxxxxxxx"
				</td>
				<td>昱辉下拉框</td>
				<td><input type="text" name="tree2" id="dtext1" /></td>
			</tr>
			
			<tr>
				<td>这个做为控制台</td>
				<td colspan = "3" ><textarea id="area" cols="30" rows="10" style="width:76%;"></textarea></td>
			</tr>
		</table>
		<!-- 底下这个div，看类名就知道是防止按钮的。 -->
		<div id="button" class = 'btnHolder'></div>
	</form>
	<script type="text/javascript">
		//谈谈表单布局器吧。
		 //表单样式动态加入、特殊组件的初始化（比如datepicker）以及表单验证都可以由yhFormField的简单完成。
		
		//引入需要的js，不多说。
		YHUI.use( "yhDropDown yhButton yhFormField", function() {
			
			var $field = $("#field").yhFormField({//初始化布局器
				tipPosition: "bottom" //这个属性是设置错误提示框的位置，默认"centerRight"
										//可以使用的值有： topLeft, topRight, bottomLeft, centerRight, bottomRight, bottom
			});
			
			$('#dtext').yhDropDown({   //下拉框初始化。下拉框太复杂了，暂时没有纳入布局器中，也就是要单独初始化。
				url: "treeData.txt",
				checkbox:true,
				post:"id"
			});
			
			$('#dtext1').yhDropDown({
				url: "treeData.txt",
				post:"id"
			});
			
			//这里我做一个AJAX、post方式提交
			var $yhButton = $("#button").yhButton({ //初始化按钮
				items: [
					{
						type:"submit",
						onClick: function( e, btnHolder, btnObj ) {
							var dd = $field.yhFormField( "validate" ), s, a = [];
							if ( dd ) {
								s = $field.serialize(); //将表单序列化成字符串。数据只要前后端传递，必然是以字符串形式进行。
								
								//下面是jQuery的一个post的方法，显而易见，提交方式是“post”
								$.post("../formfield4", s, function( data ) {
									data = $.parseJSON( data );//将json字符串转为对象。这里的data已经是后台返回的数据了，当然，是一个json……字符串。
									for ( var i = 0, l = data.length; i < l; i++ ) {
										for( var j in data[i] ){
											a.push(j, ":", data[i][j], "\n");
										}
									}
									$( "#area" ).val( a.join("") ); //在富文本框中打印出提交的数据。异步提交，就是那么简单。
								});
							}
						}
					},
					{
						type:"reset"	
					}
				]
			});


		});
		

	</script> 
</body>
</html>
