/*!
* yhui 1.3.0beta
* jquery.yhToolbar.js
* 2013-04-23
*/
(function(t){var e=function(e){this.renderTo=e.renderTo,this.border=e.border||"bottom",this.items=e.items||[],this.gitems=[],this.filters=e.filters||[],this.active=e.active,this.azable=e.azable,this.azparam=t("#"+e.azparam),this.renderContent="string"==typeof this.renderTo?t("#"+this.renderTo):this.renderTo,this.customDom=e.customDom||t.noop,this.azs=["ALL","0~9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]};e.prototype={init:function(){this.toolbar=t("<div></div>"),this.toolbar.addClass("toolbar"),"none"!=this.border&&this.toolbar.addClass(this.border+"Border"),this.toolbar.appendTo(this.renderContent),this.toolbar_table=t("<table></table>").appendTo(this.toolbar),this.toolbar_table_row=t("<tr></tr>").appendTo(this.toolbar_table);var e=t("<td></td>");e.width(2).appendTo(this.toolbar_table_row);for(var i=0,a=this.items.length;a>i;i++)this.add(this.items[i]);for(var s=0,n=this.filters.length;n>s;s++)this.addFilter(this.filters[s]);this.customDom.call(this,this.renderContent)},render:function(){return this.init(),this},genAZ:function(){this.azable&&(this.createAZFix(),this.createAZButton())},add:function(e){var i=this;if("-"==e){var a=t("<td></td>");a.appendTo(this.toolbar_table_row),t("<span></span>").addClass("spacer").appendTo(a)}else if("button"==e.type||"az"==e.type){var a=t("<td></td>").appendTo(this.toolbar_table_row),s=t("<table></table>").addClass("button_table").attr({cellPadding:0,cellSpacing:0}).appendTo(a),n=t("<TR></TR>").appendTo(s),r=t("<td></td>").addClass("b_left"),o=t("<td></td>").addClass("b_center"),l=t("<a></a>"),d=t("<td></td>").addClass("b_right"),h=function(){n.on("mouseover",function(){var e=t(this);e.addClass("over").on("mouseout",function(){e.removeClass("over down")})}).on("mousedown",function(){var e=t(this);e.addClass("down").on("mouseup",function(){e.removeClass("down").off("mouseup")})})};l.text(e.text),e.bodyStyle&&l.addClass(e.bodyStyle),l.appendTo(o),e.title&&(l[0].title=e.title),n.append(r.add(o).add(d)),this.gitems.push({table:n,itemTable:s,button:l,handler:e.handler}),"button"==e.type?"F"!=e.useable?(e.handler&&l.on("click",e.handler),h()):(l.attr("disabled",!0),s.addClass("toolbar_disabled")):(h(),s.attr({title:"快速过滤第一个字段",id:"toolbar_az"}),l.on("click",function(){i.showAZ(i)}))}else if("textfield"==e.type){var a=t("<td></td>");a.appendTo(this.toolbar_table_row);var u=t("<input />");u.attr("id",e.id),u.attr("name",e.id),u.attr("type","text"),u.addClass("textfield"),u.appendTo(a),e.bodyStyle&&u.addClass(e.bodyStyle),e.handler&&u.on("click",e.handler)}else{var a=t("<td></td>");a.appendTo(this.toolbar_table_row);var s=t("<table></table>");s.attr("cellPadding",0),s.attr("cellSpacing",0),s.appendTo(a);var n=t("<tr></tr>");n.appendTo(s);var c=t("<td></td>");c.appendTo(n),"string"==typeof e.html?c.html(e.html):c.append(e.html)}},addFilter:function(e){var i=this;if(0==t("#filterTable").length){var a=t("<table></table>");a.attr("cellPadding",0),a.attr("cellSpacing",0),a.attr("id","filterTable"),a.addClass("filterTable"),a.appendTo(this.toolbar);var s=t("<tr></tr>");s.addClass("over"),s.appendTo(a),this.filterLeft=t("<td></td>"),this.filterLeft.addClass("b_left"),this.filterRight=t("<td></td>"),this.filterRight.addClass("b_right"),s.append(this.filterLeft),s.append(this.filterRight)}var n=t("#filterTable").find(".b_center");if(n.length>0){var r=t("<td></td>");this.filterRight.before(r);var o=t("<span></span>");o.addClass("filter-spacer"),o.appendTo(r)}var l=t("<td></td>");l.attr("id",e.id),l.addClass("b_center");var d=t("<a></a>");d.text(e.text),e.title&&d.attr("title",e.title),e.bodyStyle&&d.addClass(e.bodyStyle),d.on("click",function(){i.activeFilter(t(this).parent().attr("id"))}),e.handler&&d.on("click",e.handler),d.appendTo(l),this.filterRight.before(l),e.id==this.active&&this.activeFilter(e.id),this.updateFilterBorder()},activeFilter:function(e){e&&1==t("#"+e).length&&(t("#filterTable").find(".border-center-active").each(function(){t(this).removeClass("border-center-active")}),t("#"+e).addClass("border-center-active"),this.updateFilterBorder())},updateFilterBorder:function(){this.filterLeft.next().hasClass("border-center-active")?this.filterLeft.addClass("border-left-active"):this.filterLeft.removeClass("border-left-active"),this.filterRight.prev().hasClass("border-center-active")?this.filterRight.addClass("border-right-active"):this.filterRight.removeClass("border-right-active")},createAZFix:function(){var e=t("#toolbar_az");this.az_fix=t("<table></table>"),this.az_fix.css("left",e.offset().left-2),"bottom"==this.border?(this.az_fix.addClass("az-fix"),this.az_fix.css("top",e.offset().top+e.get(0).offsetHeight-2)):(this.az_fix.addClass("az-fix-2"),this.az_fix.css("top",e.offset().top-3)),this.az_fix.attr("cellSpacing",0),this.az_fix.attr("cellPadding",0),this.az_fix.appendTo(t(document.body));var i=t("<tr></tr>");i.appendTo(this.az_fix);var a=t("<td></td>");a.addClass("left");var s=t("<td></td>");s.css("width",e.get(0).offsetWidth-4),s.addClass("center");var n=t("<td></td>");n.addClass("right"),a.appendTo(i),s.appendTo(i),n.appendTo(i)},createAZButton:function(){var e=this;this.azbar=t("<div></div>"),this.azbar.addClass("az"),this.azbar.addClass(this.border+"Border"),"bottom"==this.border?this.azbar.css("top",this.toolbar.offset().top+this.toolbar.height()+1):this.azbar.css("top",this.toolbar.offset().top-this.toolbar.height()-2),this.azbar.appendTo(t(document.body));var i=t("<table></table>");i.appendTo(this.azbar),i.attr("cellSpacing",0),i.attr("cellPadding",0);var a=t("<tr></tr>");a.appendTo(i);for(var s=0;this.azs.length>s;s++){var n=t("<td></td>");"ALL"==this.azs[s]?n.attr("title","浏览全部记录"):"0~9"==this.azs[s]?n.attr("title","以数字0~9为首字符浏览记录"):n.attr("title","以字母/拼音为首字符浏览记录"),n.text(this.azs[s]),this.azs[s]==this.azparam.val()&&n.addClass("tdovered"),n.on("click",function(t){return function(){e.azparam.val(e.azs[t]);var i=e.azparam.parents("form");window.location=i.attr("action").split("?")[0]+"?azparam="+e.azs[t]}}(s)),n.hasClass("tdovered")||(n.on("mouseover",function(){t(this).addClass("tdover")}),n.on("mouseout",function(){t(this).removeClass("tdover")})),n.appendTo(a)}},showAZ:function(e){"none"==e.azbar.css("display")?(t("#toolbar_az").addClass("over"),e.az_fix.fadeIn(100,function(){e.azbar.fadeIn(100)})):(t("#toolbar_az").removeClass("over"),e.azbar.fadeOut(100,function(){e.az_fix.fadeOut(100)}))},setText:function(t,e){this.gitems[t].button.text(e)},getText:function(t){return this.gitems[t].button.text()},setDisabled:function(e,i){var a=this.gitems[e];a&&(i?(a.button.attr("disabled",i).off("click"),a.table.off("mouseover mousedown click"),a.itemTable.addClass("toolbar_disabled")):(a.button.removeAttr("disabled"),a.itemTable.removeClass("toolbar_disabled"),a.table.on("mouseover",function(){var e=t(this);e.addClass("over").on("mouseout",function(){e.removeClass("over down")})}),a.table.on("mousedown",function(){var e=t(this);e.addClass("down").on("mouseup",function(){e.removeClass("down").off("mouseup")})}).on("click",a.handler)))},getDisabled:function(t){return this.gitems[t].button.attr("disabled")}},t.fn.yhToolbar=function(i){var a=arguments[1]||0;if("string"==typeof i){var s=t.data(this[0],"yhToolbar");return"disable"===i?(s.setDisabled(a,!0),this):"enable"===i?(s.setDisabled(a,!1),this):"isDisable"===i?!!s.getDisabled(a):t.yhui.log("yhToolbar没有"+i+"方法")}return this.each(function(){t.extend(i,{renderTo:t(this)});var a=new e(i);a.render(),t.data(this,"yhToolbar",a),i.azable&&a.genAZ()})}})(jQuery);