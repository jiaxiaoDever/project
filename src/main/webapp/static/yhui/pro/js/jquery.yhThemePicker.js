/*!
* yhui 1.3.0beta
* jquery.yhThemePicker.js
* 2013-04-23
*/
(function(t){t.yhui.yhThemePicker=function(e){var i,a=t("<select><option value = 'skinOrange'>蜜橘橙</option><option value = 'skinBlue'>天空蓝</option></select>"),s=t.yhui.cookie("yhui-themepicker");if(s)for(var n=0,o=a[0].options.length;o>n;n++)a[0].options[n].value===s&&(a[0].options[n].selected=!0);i=a[0].selectedIndex,a.appendTo(e).on("change",function(){confirm("* 要刷新页面才能更换皮肤\n\n* 这个过程会关闭当前打开的选项卡\n\n* 是否刷新？")?(t.yhui.cookie("yhui-themepicker",this.options[this.selectedIndex].value,{expires:100}),location.reload(!0)):this.selectedIndex=i})}})(jQuery);