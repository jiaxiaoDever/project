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
<style type = "text/css">
            h1 { font-size: 20px; margin: 10px 20px; }
            p { margin: 10px 30px; }
            .ui-menu-item { position: relative; }
            /*.ui-selectmenu-menu .ui-menu .ui-menu-item a { padding-left: 20px; }*/
            .ui-menu-item .ui-icon { top: 50%; margin-top: -8px; }

        </style>
</head>
<body>
  <h1>下拉框 ( yhSelectmenu )</h1>
        <p>该插件直接作用在原生的&lt;select&gt;上，比较适合数据较少的列表形式下拉。</p>
        <p>该 jsp 路径： Components/form/yhSelectmenu.jsp 。</p>

        <form class = "yhui-formfield">
            <table>
                <tr>
                    <td><label for = "def">普通用法</label></td>
                    <td>
                        <select id = "def">
                            <option value = "1">1</option>
                            <option value = "2">2</option>
                            <option value = "3">3</option>
                        </select>
                    </td>
                    <td><label for = "defSe">默认选中</label></td>
                    <td>
                        <select id = "defSe">
                            <option selected = "selected" value = "1">1</option>
                            <option value = "2">2</option>
                            <option value = "3">3</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td><label for = "month">内置月份</label></td>
                    <td><select id = "month"></select></td>
                    <td><label for = "monthDef">默认选中月份</label></td>
                    <td><select id = "monthDef"></select></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td><label for = "year">内置年份</label></td>
                    <td><select id = "year"></select></td>
                    <td><label for = "yearDef">默认选中</label></td>
                    <td><select id = "yearDef"></select></td>
                </tr>
                <tr>
                    <td><label for = "range1">年份区间1</label></td>
                    <td><select id = "range1"></select></td>
                    <td><label for = "range2">年份区间2</label></td>
                    <td><select id = "range2"></select></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td><label for = "group">分组</label></td>
                    <td>
                        <select id = "group">
                            <optgroup label="广东">
                                <option value="guangzhou">广州</option>
                                <option value="shenzhen">深圳</option>
                            </optgroup>
                            <optgroup label="安徽">
                                <option value="heifei">合肥</option>
                                <option value="anqing">安庆</option>
                            </optgroup>
                        </select>
                    </td>
                    <td><label for="customRender">自定义样式</label></td>
                    <td>
                        <select id = "customRender">
                            <option value = "1">一</option>
                            <option value = "2">二</option>
                            <option value = "3">三</option>
                            <option value = "4">四</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td> <label for="select">select 事件</label> </td>
                    <td>
                        <select id = "select">
                            <option value = "1">1</option>
                            <option value = "2">2</option>
                            <option value = "3">3</option>
                            <option value = "4">4</option>
                        </select>
                    </td>
                    <td><label for = "change"> change 事件 </label></td>
                    <td>
                        <select id = "change">
                            <option value = "1">1</option>
                            <option value = "2">2</option>
                            <option value = "3">3</option>
                            <option value = "4">4</option>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
        <script type = "text/javascript">
            YHUI.use( "yhFormField yhSelectmenu yhDropDown yhDialogTip", function() {
                $( "form" ).eq( 0 ).yhFormField();

                // 默认
                $( "#def" ).yhSelectmenu();

                // 默认选中
                $( "#defSe" ).yhSelectmenu();

                // 月份
                $( "#month" ).yhSelectmenu({
                    type: "month"
                });

                // 默认选中月份
                $( "#monthDef" ).yhSelectmenu({
                    type: {
                        type: "month",
                        selected: 4
                    }
                });

                // 年份
                $( "#year" ).yhSelectmenu({
                    type: "year"
                });

                // 年份默认选中
                $( "#yearDef" ).yhSelectmenu({
                    type: {
                        type: "year",
                        selected: "now"     // 多为数字，"now"是唯一合法的字符串
                    }
                });

                // 年份区间1
                $( "#range1" ).yhSelectmenu({
                    type: {
                        type: "year",
                        range: 2    // 当前年份前后各两年
                    }
                });

                // 年份区间2
                $( "#range2" ).yhSelectmenu({
                    type: {
                        type: "year",
                        range: [ 1998, 2006 ],
                        selected: 2004
                    }
                });


                // 分组
                $( "#group" ).yhSelectmenu();

                // 自定义样式
                // 高阶用法，不清楚构造过程的话，谨慎使用
                $( "#customRender" ).yhSelectmenu({
                    renderItem: function( ul , item ) {
                        var li = $( "<li>" ).data( "ui-selectmenu-item", item ),
                                element,
                                span;

                        if ( item.disabled ) {
                            li.addClass( "ui-state-disabled" ).text( item.label );
                        } else {
                            element = item.element;
                            span = $( "<span>", {
                                style: element.attr( "style" ),
                                'class': "ui-icon ui-icon-triangle-1-e "
                            });
                            $( "<a>", {
                                text: item.label,
                                href: '#',
                                style: "margin-left: 20px"
                            }).append( span ).appendTo( li );
                        }

                        return li.appendTo( ul );
                    }
                });

                // select 事件
                $( "#select" ).yhSelectmenu({
                    select: function( e, yhui ) {
                        $.yhDialogTip.alert( "选项的 value 为： " + yhui.item.value, "提示" );
                    }
                });

                // change 事件
                $( "#change" ).yhSelectmenu({
                    change: function( e, yhui ) {
                        $.yhDialogTip.alert( "选项的 value 为： " + yhui.item.value, "提示" );
                    }
                });
            });
        </script>  
</body>
</html>
