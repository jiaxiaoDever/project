/**
 * 弹窗工具类
 */
var WinUtils = {
	createEditWin : function(dialog, model, url, _config) {
		// var dialog = $("<div>");
		// dialog.buttonDiv = $('<div id=\"formButtons\">');
		var config = {
				autoOpen : false,
				width : 600,// 添加自定义宽度
				height : 400,
				modal : true,
				fixedMaxHeight : 40,// 修正最大化时额外减去的高度
				resizable : false,
				showTaskBar : false,
				position : [ "center", "center-5%" ],
				close : function() {
					if ($(dialog).find(".yhui-validate").length > 0) {
						$(dialog).find("form").yhValidate("remove");
					}
					dialog.yhWindow("close");
				}
			};
		$.extend(true,config,_config);
		dialog.yhWindow(config);
		this.createFormTo(dialog, model, url);
		return dialog;
	},
	createFormTo : function(target, model, url) {
		var form = $("<form>").appendTo($(target));
		$(target)[0].form = form;
		form.attr("method", "post");
		if (url) {
			form.attr("action", url);
		}
		var editTable = $("<table>").appendTo(form);

		$.each(model, function(k, v) {
			var tr = $("<tr>").appendTo(editTable);
			// tr.append("<td class='column2Even'>" + v.label + "</td>");
			var labelTd = $("<td class='column2Even'>" + v.label + "</td>").appendTo(tr);
			var valueTd = $("<td class='column2Odd'>").appendTo(tr);
			if (v.field) {
				if ($.isPlainObject(v.field.editor)) {// 编辑器为组件时
					valueTd.append(v.field.editor);
				} else {
					switch (v.field.editor) {
					case "select":// 普通下拉
						if (!v.field.config.json) {
							break;
						}
						var selectEle = $("<select name=\"" + v.name + "\"/>");
						var option = null;
						$.each(v.field.config.json, function(kk, vv) {
							option = "<option value=\"" + vv.id + "\" " + (vv.selected ? 'selected' : '') + ">" + vv.name + "</option>";
							selectEle.append(option);
						});
						valueTd.append(selectEle);
						selectEle.yhSelectmenu();
						break;
					case "dropdown":
						var dropDownEle = $("<input type=\"text\" id=\"" + v.name + "\" dropdown />");
						valueTd.append(dropDownEle);
						dropDownEle.yhDropDown(v.field.config).yhDropDown("parseDrop");
						break;
					case "checkboxtree":
						var checkboxtreeEle = $("<div id=\"" + v.name + "\"></div>");
						valueTd.append(checkboxtreeEle);
						checkboxtreeEle.yhCheckBoxTree(v.field.config);
						break;
					case "textarea":
						var editor = $("<textarea name=\"" + v.name + "\" style=\"width:150px;\"></textarea>");
						valueTd.append(editor);
						break;
					case "editor":
						var editor = $("<textarea name=\"" + v.name + "\" style=\"width:670px;\"></textarea>");
						valueTd.append(editor);
						$.extend(true, v.field.config, {
							uploadJson : ctx + '/static/kindeditor/upload_json.jsp',
							fileManagerJson : ctx + '/static/kindeditor/file_manager_json.jsp',
							allowFileManager : true
						});
						editor.yhEditor(v.field.config);
						break;
					case "file":
						var editor = KindEditor.editor({
							allowFileManager : true
						});
						var fileEle = $("<input type=\"text\" name=\"" + v.name + "\">");
						var fileBtn = $("<input type=\"button\" value=\"选择图片\" >");
						valueTd.append(fileEle);
						valueTd.append(fileBtn);
						fileBtn.click(function() {
							editor.loadPlugin('image', function() {
								editor.plugin.imageDialog({
									showRemote : false,
									imageUrl : fileEle.val(),
									clickFn : function(url, title, width, height, border, align) {
										fileEle.val(url);
										editor.hideDialog();
									}
								});
							});
						});
						break;
					case "hidden":
						valueTd.append("<input type=\"hidden\"  name=\"" + v.name + "\" class=\"yhui-form-text\"/>");
						tr.hide();
						break;
					case "label":
						valueTd.append("<span name=\"" + v.name + "\" />");
						break;
					case "readOnly":
						valueTd.append("<input type=\"text\" readonly=\"readonly\" name=\"" + v.name + "\" class=\"yhui-form-text\"/>");
						break;
					case "text":
						valueTd.append("<input type=\"text\"  name=\"" + v.name + "\" class=\"yhui-form-text\"/>");
						break;
					case "no":
						tr.hide();
						break;
					default:// 默认直接使用YHUI组件
						valueTd.append(v.field.editor);
					}

				}
			} else {
				if (v.hidden) {
					valueTd.append("<input type=\"hidden\"  name=\"" + v.name + "\" class=\"yhui-form-text\"/>");
					tr.hide();
				} else {
					valueTd.append("<input type=\"text\" name=\"" + v.name + "\" class=\"yhui-form-text\"/>");
				}
			}
		});
		form.yhFormField();

	},
	fillFrom : function(frm, data, model) {

		$.each(model, function(k, v) {
			if (!data) {
				return true;
			}

			var element = $(frm).find("[name='" + v.name + "']");

			if (v.field) {
				switch (v.field.editor.toLowerCase()) {
				case "dropdown":
					$("#" + v.name).yhDropDown("setValue", data[v.name]);
					break;
				case "editor":
					element.yhEditor("html", data[v.name]);
					break;
				case "select":
					element.yhSelectmenu("setValue", data[v.name]);
					break;
				case "checkboxtree":
					$("#" + v.name).yhCheckBoxTree("setValue", data[v.name]);
					break;
				case "label":
					element.html(data[v.name]);
					break;
				case "hidden":
				case "text":
					element.val(data[v.name]);
					break;
				default:
				}
			} else {
				element.val(data[v.name]);
			}
		});
	},
	updateDataByJqArray : function(data, serializeArray) {
		jQuery.each(serializeArray, function(i, field) {
			data[field.name] = field.value;
		});
		return data;
	},
	newDataByJqArray : function(serializeArray) {
		var data = {};
		jQuery.each(serializeArray, function(i, field) {
			data[field.name] = field.value;
		});
		return data;
	},
	getNodeByMode : function(model, node) {
		var result = {};
		for ( var k in model) {
			var m = model[k];
			result[m.name] = node[m.name];
		}
		return result;
	},
	htmlspecialchars : function(str) {
		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("<", "&lt;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("\"", "&quot;");
		return str;
	},
	getModelValiRules : function(model) {
		var valiRules = {
			ignore : "",
			validateOnSubmit : false,
			rules : {}
		};
		for ( var i in model) {
			if (model[i].valiRule) {
				valiRules.rules[model[i].name] = model[i].valiRule;
			}
		}
		return valiRules;
	}
};