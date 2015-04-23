/**
 * 工具栏
 * 
 * @author zhangy
 */
(function($, undefined) {

	$.fn.yhEditor = function(options) {
		var arg = arguments[1] || "";

		if (typeof options === "string") {
			var editor = this[0].editor;
			if (options == "get") {
				return editor;
			} else {
				return editor[options](arg);
			}
		}

		var editor = KindEditor.create(this, options);
		this[0].editor = editor;
		return editor;

	};
})(jQuery);