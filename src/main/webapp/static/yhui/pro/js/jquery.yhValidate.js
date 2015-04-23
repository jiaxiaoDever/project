/*!
* yhui 1.3.0beta
* jquery.yhValidate.js
* 2013-04-23
*/
(function(t){t.widget("yhui.yhValidate",{version:"1.3.0beta",options:{debug:!1,ignore:"[type=hidden]",messages:null,methods:null,position:{at:"right center",my:"left center"},rules:null,starTip:"这个字段必须填写",validateOnSubmit:!0},methods:{required:function(e,i){var s;return s=this._checkable(i)?!!t(i).find("input").filter(":checked").length:t.trim(e).length>0},minLength:function(t,e,i){return t.length>=i},maxLength:function(t,e,i){return i>=t.length},equalTo:function(e,i,s){var a=t("#"+s);return a.length?e===a.val():t.yhui.log("没有匹配的元素")},remote:function(e,i,s){var a=this,n={},r=this._getFlag(i);return t.data(i,"remoteValid")===e?(r in this.remoteErrorMap&&delete this.remoteErrorMap[r],!0):(this.remoteErrorMap||(this.remoteErrorMap={},this.remotedAll=!0),n[r]=e,s="string"==typeof s&&{url:s}||s,this.xhr&&this.xhr[r]&&4!=this.xhr[r].readyState&&this.xhr[r].abort(),this._startRequest(i),this.xhr[r]=t.ajax(t.extend(!0,{dataType:"json",data:n,success:function(s){var n=s===!0||"true"===s;if(n)a._cancelError(i),r in a.remoteErrorMap&&delete a.remoteErrorMap[r],t.data(i,"remoteValid",e);else{var o=a._messages(i,t.data(i,"currentRule"),!0);r in a.remoteErrorMap||(a.remotedAll&&(a.remotedAll=!1),a.remoteErrorMap[r]={element:i,message:o}),a._showError(i,o),(!a.tip||a.tip&&a.tip.is(":hidden"))&&a._tip(i,o),t.removeData(i,"remoteValid")}a._stopRequest(i,n,r)},error:function(e,i){a.options.debug&&t.yhui.log(i)}},s)),"pending")},minChecked:function(e,i,s){return t(i).find("input").filter(":checked").length>=s},maxChecked:function(e,i,s){return s>=t(i).find("input").filter(":checked").length},email:function(t){return/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/.test(t)},phone:function(t){return/^(0\d{2,3})?-?\d{7,8}$/.test(t)},mobile:function(t){return/^0?1\d{2}-?\d{8}$/.test(t)},url:function(t){return/^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(t)}},messages:{required:"此字段必须填写",remote:"经验证，表单值不合法",email:"输入的邮箱地址无效",equalTo:"请与上一个值保持一致",maxLength:"最多{0}个字符",maxChecked:"至多选择{0}项",minLength:"最少{0}个字符",minChecked:"至少选择{0}项",mobile:"输入的手机号码无效",phone:"输入的电话号码无效",file:"选择上传的文件",url:"输入的地址无效"},_create:function(){if("form"!==this.element[0].nodeName.toLowerCase())return t.yhui.log("yhValidate 只作用于表单元素");this.options.methods&&t.extend(!0,this.methods,this.options.methods);var e,i=this;t.isEmptyObject(e=this.options.rules)||t.each(e,function(t,s){e[t]=i._normalizeRule(s)}),this.elements=this._getElements(),this.element.attr("novalidate","novalidate")[0].reset(),this._events();var s;(s=this.options.starTip)&&this.element.tooltip({items:".yhui-form-required",content:s})},_addStar:function(e){var i="<span class = 'yhui-form-icon yhui-form-required'></span>";t(e).closest(":yhui-yhformfield").length&&t(e).eq(0).closest("td").prev().prepend(i)},_events:function(){var e=this,i=":data(rules):not(:data(yhDatePicker)):data(rules):not(:data(yhDropDown))";t.yhui.windowResize(function(){e.tip&&e.tip.is(":visible")&&e.tip.position(t.extend(e.options.position,{of:t.data(e.tip[0],"target")}))},this.eventNamespace,this.window),this.element.on(this._namespace("submit"),function(t){e.options.debug&&t.preventDefault(),e._form()||e.formSubmit||t.preventDefault()}).on(this._namespace("mouseenter focus"),".yhui-validate",function(){var i,s=this;this.className.indexOf("yhui-dropdown")>-1&&(s=t(this).find("input[type=text]"));var a=t(s);(i=a.data("message"))&&!a.attr("data-hastip")&&e._tip(s,i)}).on(this._namespace("change"),":data(rules)>[type=radio],:data(rules)>[type=checkbox]",function(){e._checkField(this.parentNode)}).on(this._namespace("keyup"),i,function(){e._checkField(this)}).on(this._namespace("yhdatepickerhide"),":data(yhDatePicker)",function(){e._checkField(this)}).on(this._namespace("yhdropdownhide"),":data(yhDropDown)",function(){e._checkField(this)})},_namespace:function(e){return t.yhui.parseEventType(e,this.eventNamespace)},_getElements:function(){var e=this,i={};return this.element.find("input, select, textarea, span.yhui-form-checkable").not("[type=submit], [type=reset], [type=image], [disabled]").not(this.options.ignore).filter(function(){var s=e._getFlag(this);return s in i||t.isEmptyObject(e._rules(this))?!1:(e._addStar(this),!0)})},_rules:function(e){var i;if(i=t.data(e,"rules"))return i;if(i=t.extend(!0,{},this._staticRules(e),this._attributeRules(e)),i=this._normalizeRules(i),i.required){var s=i.required;delete i.required,i=t.extend({required:s},i)}return t.isEmptyObject(i)||t.data(e,"rules",i),i},_form:function(){return this.checkForm(),this._parseErrorField(),this._valid()},_valid:function(){return t.isEmptyObject(this.errorMap)&&t.isEmptyObject(this.pending)&&t.isEmptyObject(this.remoteErrorMap)},_attributeRules:function(e){var i,s,a={},n=t(e);for(i in this.methods)/^(required|phone|mobile|email|url)$/.test(i)?(s=n.attr(i),""===s&&(s=!0),s="false"===s?"false":!!s):s=n.attr(i),s&&(a[i]=s);return a.maxLength&&/-1|2147483647|524288/.test(a.maxLength)&&delete a.maxLength,a},_staticRules:function(e){var i={},s=this._getFlag(e),a=this.options.rules;return!t.isEmptyObject(a)&&a[s]&&(i=a[s]),i},_normalizeRule:function(e){if("string"==typeof e){var i={};t.each(e.split(/\s/),function(){i[this]=!0}),e=i}return e},_normalizeRules:function(e){return t.each(e,function(t,i){return"false"===i||i===!1?(delete e[t],undefined):undefined}),e},_check:function(e){var i,s,a,n=e.value,r=this._rules(e),o=this._getFlag(e);for(i in r){if(s={method:i,param:r[i]},a=this.methods[i].call(this,n,e,s.param),t.data(e,"currentRule",s),"pending"===a)return!1;if(!a)return this._messages(e,s),!1}return this.errorMap[o]&&delete this.errorMap[o],!0},checkForm:function(){this.errorMap||(this.errorMap={});for(var e,i=0,s=this.elements;s[i];i++)e=this._getFlag(s[i]),t(s[i]).hasClass("yhui-validate")||this._check(s[i]);return this._valid()},_checkField:function(e){if(this.errorMap){if("remote"===t.data(e,"currentRule").method)return this._check(e),undefined;var i=this._getFlag(e);if(this._check(e))this._cancelError(e),this.errorMap[i]&&delete this.errorMap[i];else{var s=t.data(e,"currentRule"),a=this._messages(e,s);this._showError(e),this._tip(e,a),this.errorMap[i]||(this.errorMap[i]={element:e,message:a})}}},_startRequest:function(e){this.pending||(this.pending={},this.xhr={});var i=this._getFlag(e);this.pending[i]=e;var s=t("#yhui-validate-pending-"+i);s.length||t("<span></span>",{id:"yhui-validate-pending-"+i,"class":"yhui-validate-pending"}).appendTo(this.document[0].body).position({of:e,at:"right center",my:"right-3 center"})},_stopRequest:function(e,i,s){delete this.pending[s],t("#yhui-validate-pending-"+s).remove(),i&&t.isEmptyObject(this.pending)&&t.isEmptyObject(this.errorMap)&&t.isEmptyObject(this.remoteErrorMap)&&(this.formSubmit=!0,this.remotedAll&&this.element.submit(),this.remotedAll=!0)},_messages:function(t,e,i){var s=this._getMessages(t,e.method,e.param);return i||(this.errorMap[this._getFlag(t)]={element:t,message:s}),s},_getMessages:function(e,i,s){var a;if(a=t(e).attr(i+"-msg"))return t.yhui.print(a,s);if(this.options.messages&&(a=this.options.messages[this._getFlag(elem)])){if("string"==typeof a)return t.yhui.print(a,s);if(a=a[i])return t.yhui.print(a,s)}return t.yhui.print(this.messages[i]||"请定义提示语",s)},_parseErrorField:function(){for(var t,e,i,s=0,a=this.elements,n=a.length;n>s;s++)t=a[s],e=this._getFlag(t),e in this.errorMap&&(this._showError(t,this.errorMap[e].message),i||(i=!0,this._tip(t,this.errorMap[e].message)))},_showError:function(e,i){var s=t(e).closest(".yhui-dropdown");s.length?s.addClass("yhui-validate"):t(e).addClass("yhui-validate"),i&&t.data(e,"message",i)},_tip:function(e,i){t.isEmptyObject(this.errorMap)&&t.isEmptyObject(this.remoteErrorMap)||(this.tip?this.tipList.html(i):(this.tip=t("<div class='yhui-validate-tip'></div>").hide(),this.tipContent=t("<div class='yhui-validate-tip-content'></div>"),this.tipList=t("<p class='yhui-validate-tip-errorlist'></p>").html(i).appendTo(this.tipContent),this.tip.append(this.tipContent).appendTo(document.body)),t(this.hasTipElement).removeAttr("data-hastip"),this.hasTipElement=e,t(this.hasTipElement).attr("data-hastip","hastip"),this.tip.data("target",e).css({top:0,left:0}).show().position(t.extend(this.options.position,{of:e,collision:"fit"})))},_cancelError:function(e){var i=t(e),s=t(e).closest(".yhui-dropdown");i.attr("data-hastip")&&this.tip.hide(),s.length&&(i=s),i.removeClass("yhui-validate")},_getFlag:function(e){var i;return i=this._checkable(e)?t(e).find("input")[0].name:e.name||e.id},_checkable:function(t){return t.className.indexOf("yhui-form-checkable")>-1},_findByName:function(t){return this.element.find('[name="'+t+'"]')}})})(jQuery);