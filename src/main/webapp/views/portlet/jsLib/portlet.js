$(function() {
		myLib.progressBar();
	});
	$.include([ 'themes/default/css/desktop.css',
			'jsLib/jquery-ui-1.8.18.custom.css',
			'jsLib/jquery-smartMenu/css/smartMenu.css',
			'jsLib/jquery-ui-1.8.18.custom.min.js',
			'jsLib/jquery.winResize.js',
			'jsLib/jquery-smartMenu/js/mini/jquery-smartMenu-min.js',
			'jsLib/desktop.js' ]);
	$(window).load(function() {
		myLib.stopProgress();

		var lrBarIconData = {
		};

		//存储桌面布局元素的jquery对象
		myLib.desktop.desktopPanel();

		//初始化桌面背景
		myLib.desktop.wallpaper.init("themes/default/images/blue_glow.jpg");

		//初始化任务栏
		myLib.desktop.taskBar.init();


		//初始化桌面导航栏
		myLib.desktop.navBar.init();

		//初始化侧边栏
		myLib.desktop.lrBar.init(lrBarIconData);
		var deskIconData = {};
		//初始化桌面图标
		myLib.desktop.deskIcon.init(deskIconData);
		//加载后台portlet
		var roleId = $('#roleId').val();
		if(roleId != null && roleId != ""){
			type = "role";
			forId = roleId;
		}
		loadIcons();
		
	});
	
	var type = "user";
	var forId = "";
	function saveUserLayout(){
		var saveurl = ctx + "/portlet/saveUserLayout";
		if(type == "role") saveurl = ctx + "/portlet/saveRoleLayout?forId="+forId;
		myLib.desktop.layoutObject.desktops[0].portlets = myLib.desktop.win.wins;
		$.ajax({
			type : "POST",
			dataType : "json",
			url: saveurl,
			data:"layoutContext="+JSON.stringify(myLib.desktop.layoutObject)
		});
	};
	function removeUserPortlet(pid){
		$.ajax({
            dataType: "json",
            url: ctx + "/portlet/removePortlet?id="+pid,
            success:function(data){
            	myLib.desktop.deskIcon.removeIcon(pid);
            }
        });
	}
	function loadIcons(){
		var url = ctx + "/portlet/findUserPortlets";
		if(type == "role") url = ctx + "/portlet/findRolePortlets?roleId="+forId;
		$.ajax({
            dataType: "json",
            url: url,
            success:addIcon
        });
	};
	//添加应用函数
	function addIcon(portletData) {
		if(portletData != null && portletData.length > 0){
			myLib.desktop.portlets = portletData;
			for(var k in portletData){
				var data = {id:portletData[k].id,iconSrc:portletData[k].icon != null && portletData[k].icon != ''?portletData[k].icon:"icon/icon7.png",title:portletData[k].title,url:portletData[k].url,category:portletData[k].category};
				myLib.desktop.deskIcon.addIcon(data);
			}
		}
		loadLayout();
		//renderDesktops(null);
	};
	function loadLayout(){
		var url = ctx + "/portlet/loadLayout";
		if(type == "role") url = ctx + "/portlet/loadRoleLayout?roleId="+forId;
		$.ajax({
			dataType: "json",
			url: url,
			success:renderDesktops
		});
	};
	function renderDesktops(layoutData){
		if(layoutData != null && layoutData.layoutContext != null && layoutData.layoutContext != ""){
			var layoutString = layoutData.layoutContext;
			var layoutObject = $.parseJSON(layoutString);
			myLib.desktop.layoutObject = layoutObject;
			renderDesktopPortlets(layoutObject);
		}else{
			if(myLib.desktop.portlets != null && myLib.desktop.portlets.length > 0){
				var tw = 800,th = 380,tt = 400,tl = 800,tc = 50;
				var myData=myLib.desktop.getMydata(),$deskIcon=myData.panel.desktopPanel['deskIcon'];
				var desktopWidth=$deskIcon.width();
				var defaultNum = 8;
				var portlets = [];
				for(var i=0;i<myLib.desktop.portlets.length;i++){
					if(i==defaultNum) break;
					var top = (i==0 || i== 1 || i== 4 || i== 5)?tt:0;
					var left = (i==1 || i==3)?tl + tc:(i==4 || i==6)?tl*2 + tc*2+80:(i==5 || i==7)?tl*3 + tc*3+60:25;
					var data = {WindowsId:myLib.desktop.portlets[i].id,WindowTitle:myLib.desktop.portlets[i].title,iframSrc:myLib.desktop.portlets[i].url,
							WindowPositionTop : top,WindowPositionLeft : left,
							WindowWidth:tw,WindowHeight:th};
					myLib.desktop.win.newWin(data);
				}
			}
		}
	};
	function renderDesktopPortlets(layoutObject){
		if(layoutObject && layoutObject.desktops && layoutObject.desktops.length > 0){
			var layoutDesktops = layoutObject.desktops;
			for(var d in layoutDesktops){
				if(layoutDesktops[d].index && layoutDesktops[d].portlets && layoutDesktops[d].portlets.length > 0){						
					var di = layoutDesktops[d].index;
					$("#desktop"+di).trigger('click');
					var layoutPortlets = layoutDesktops[d].portlets;
					for(var k in layoutPortlets){
						if(layoutPortlets[k] != null){							
							var id = layoutPortlets[k].id
							var portlet = null;
							if(myLib.desktop.portlets != null && myLib.desktop.portlets.length > 0){
								for(var p in myLib.desktop.portlets){
									if(id == myLib.desktop.portlets[p].id) portlet = myLib.desktop.portlets[p];
								}
							}
							var portletsrc = "../../common/404.jsp";
							var title = "异常portlet";
							if(portlet != null){
								portletsrc = portlet.url;
								title = portlet.title
							}
							var data = {WindowsId:id,WindowTitle:title,iframSrc:portletsrc,
									WindowPositionTop : layoutPortlets[k].top,WindowPositionLeft : layoutPortlets[k].left,
									WindowWidth:layoutPortlets[k].width,WindowHeight:layoutPortlets[k].height};
							myLib.desktop.win.newWin(data);
						}
					}
				}
			}
		}
	};
