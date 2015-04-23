var userinfo = {
	code : "userinfo",
	url : ctx + "/system/user/",
	/**
	 * 初始化布局
	 */
	initLayout : function() {
		$(document.body).yhLayout({});
		$("#mainContent").yhLayout({
                north: {
                    size:0,
                    spacing_open: 0,
                    spacing_closed: 0
                },
                center__onresize: function() {
                        //grid.yhGrid( "refresh" );
                    }
            });    
		$("#editForm form").yhFormField({});
	},
	/**
	 * 按钮的触发方法
	 */
	initActions : function() {
	},
	/**
	 * 初始化工具条
	 */
	initToolBar : function() {
	},

	/**
	 * 初始化按钮
	 */
	initButton : function() {
		var _this = this;
		_this.formDiv = $("#editForm");
		_this.formDiv.buttonDiv = $('<div>').insertAfter(_this.formDiv[0]);
		_this.formDiv.buttonDiv.yhButton({
			form : _this.formDiv,
			align : "center-180",
			items : [ {
				type : "save",
				onClick : function(e, form) {
					var vali = $("#editForm form").yhValidate( "checkForm" );
					if(!vali) {
						return;
					}
					var data = $("#editForm form").serialize()+"&times="+new Date();
					$.ajax({
						type : "POST",
						dataType : "json",
						url : _this.url + "saveUser",
						data : data,
						success : function(data, textStatus) {
							if (data.success) {
								$("#editForm form").yhValidate( "remove" );
								$.yhDialogTip.confirm(data.title, data.reason);
							
							} else {
								$.yhDialogTip.error(data.title, data.reason);
							}
						}
					});
				}
			} ]
		});
	
	},
	initVali : function(){
			var _this = this;
			$("#editForm form").yhValidate(_this.valiRules);
	},
	valiRules : {
        ignore : "",
        methods : {
        	isPasswd:function (value, field, param){//校验密码：只能输入字母、数字、下划线
        		if(value =="" || value =="●●●●●●") return true;    			
    			var patrn=/^(\w)+$/;    
    			if (!patrn.exec(value)) return false ;
    			$('#password').val(value);
        	    return true ;
        	}
        },
        rules : {
            name:{
                required: true,
                maxLength: 8,
                minLength: 2
            },
            phoneNbr:{
            	phone: true
            },
            mobileNbr:{
            	mobile: true
            },
            emailAddr:{
            	email: true
            },
            pwd:{
            	required: true,
            	maxLength: 15,
            	isPasswd: true
            }
        },
        messages:{
        	pwd: {
	        	isPasswd : "用户密码只能由字母、数字、下划线组成"
	        }
		}

    },
	/**
	 * 加载数据
	 */
	initLoadData : function() {
		var id = $("#organizationId").val();
		$.getJSON(ctx+"/system/org/get",{id:id},function(data){
			$("#organizationName").val(data.name);
		});
	}

};

/**
 * 初始化时layout要放在form/toolbar/button之后，loaddata之前
 */
YHUI.use("yhFormField yhLayout yhDropDown yhToolbar yhButton yhDialogTip zTree  yhValidate", function() {
	userinfo.initActions();
	userinfo.initToolBar();
	userinfo.initButton();
	userinfo.initLayout();
	userinfo.initLoadData();
	userinfo.initVali();
	$("#formButtons .yhui-btn-holder").css("border","none");
});