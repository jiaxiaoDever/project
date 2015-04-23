/*!
* yhui 1.3.0beta
* jquery.yhLayout.js
* 2013-04-23
*/
(function(t){return t.layout?(t.fn.yhLayout=function(e){if("string"==typeof e){var i=t.data(this[0],"layout"),s=Array.prototype.slice.call(arguments,1);return i&&(t.isFunction(i[e])?i[e].apply(i,s):t.yhui.log("没有"+e+"方法！")),void 0}var a={defaults:{togglerTip_open:"隐藏",togglerTip_closed:"展开",fxName:"none",togglerLength_open:53,togglerLength_closed:53,maskContents:!0},north:{size:64,spacing_open:8,spacing_closed:8,showOverflowOnHover:!0,resizerTip:"上下拖动"},west:{size:240,togglerLength_open:54,togglerLength_closed:54,resizerTip:"左右拖动"},south:{size:64,spacing_open:8,spacing_closed:8,resizerTip:"上下拖动"}},n=t.extend(!0,a,e);return n.addBorder&&t(document.body).addClass("yhui-layout-border").find("div.yhui-header").addClass("yhui-layout-border-bottom"),this.layout(n),this},void 0):t.yhui.log("no layout plugin!")})(jQuery);