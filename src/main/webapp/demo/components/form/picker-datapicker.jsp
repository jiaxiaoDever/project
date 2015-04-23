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
        h1 { font-size: 20px; padding: 5px 10px; }
    </style>
</head>
<body>
     <h1>昱辉日期选择器</h1>
	<table class = "yhui-formfield" >
		<tr>
            <td colspan = "4">日期</td>
        </tr>
        <tr>
			<td>默认</td>
			<td><input type="text" /></td>
			<td>自定义分隔符</td>
			<td> <input type="text" /></td>
		</tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
		<tr>
			<td>最大最小值</td>
			<td><input type="text" /></td>
			<td>设置默认日期</td>
			<td> <input type="text" /></td>
		</tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
		<tr>
			<td>联动的开始</td>
			<td><input type="text" /></td>
			<td>联动的结束</td>
			<td> <input type="text" /></td>
		</tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan = "4">日期和时间</td>
        </tr>
        <tr>
            <td>设置默认日期时间</td>
            <td><input type="text" /></td>
            <td>秒钟禁用</td>
            <td><input type="text" /></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
         <tr>
            <td>分秒禁用</td>
            <td><input type="text" /></td>
            <td>默认</td>
            <td><input type="text" /></td>
        </tr>
	</table>
    <script type="text/javascript">
        YHUI.use( "yhFormField yhDatePicker", function() {
            $("table").yhFormField({
                onlyTable: true,
                haveTitle: true
            });

            var $input = $("input");
            
            $input.eq(0).yhDatePicker();
            
            $input.eq(1).yhDatePicker({
                separator: "/"
            });
            
            $input.eq(2).yhDatePicker({
                minDate: "-7d",//new Date( 2012, 9, 6 ),"2012-9-6"
                maxDate: "+7d"
            });

            $input.eq(3).yhDatePicker({
                selectedDate: "2015-10-6"
            });

            $input.eq(4).yhDatePicker({
                hide: function( e, yhui ) {
                    this.value !== ""
                        && $input.eq(5)
                                .yhDatePicker(
                                    "option",
                                    "minDate",
                                    $(this).yhDatePicker("option","selectedDate")
                                )
                                .yhDatePicker( "show" );
                }
            });

            $input.eq(5).yhDatePicker();

            $input.eq(6).yhDatePicker({
                selectedDate: new Date(),
                showTime: "11:11:11"
            });

            $input.eq(7).yhDatePicker({
                selectedDate: new Date(),
                showTime: "23:33"
            });

            $input.eq(8).yhDatePicker({
                selectedDate: new Date(),
                showTime: "23"
            });
            
            $input.eq(9).yhDatePicker({
                showTime: true
            });
        });
    </script>
</body>
</html>
