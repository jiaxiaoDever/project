$(function() {
		myLib.progressBar();
	});
	$.include([ 'themes/default/css/desktop_admin.css',
			'jsLib/jquery-ui-1.8.18.custom.css',
			'jsLib/jquery-smartMenu/css/smartMenu.css',
			'jsLib/jquery-ui-1.8.18.custom.min.js',
			'jsLib/jquery.winResize.js',
			'jsLib/jquery-smartMenu/js/mini/jquery-smartMenu-min.js',
			'jsLib/desktop_admin.js' ]);
	$(window).load(function() {
		myLib.stopProgress();

		var lrBarIconData = {
		};

		//存储桌面布局元素的jquery对象
		myLib.desktop.desktopPanel();

		//初始化桌面背景
		myLib.desktop.wallpaper.init("themes/default/images/blue_glow.jpg");

		//初始化侧边栏
		myLib.desktop.lrBar.init(lrBarIconData);
		var deskIconData = {};
		//初始化桌面图标
		myLib.desktop.deskIcon.init(deskIconData);
		//加载角色portlet
		loadRolePortlets();
	});
	function loadRolePortlets(){
		$.ajax({
            dataType: "json",
            url: ctx + "/portlet/findAllRolePortlets",
            success:initRolePortlets
        });
	};
	function initRolePortlets(rolePortletData){
		if(rolePortletData != null && rolePortletData.length > 0){
			myLib.desktop.roles = rolePortletData;
			for(var k in rolePortletData){
				var rolePortlet = rolePortletData[k];
				myLib.desktop.deskIcon.addRolePortlets(rolePortlet);
			}
		}
		//加载后台portlet
		loadIcons();
	};
	function addPortletToRole(roleIds,portlet){
		if(roleIds == null || roleIds == '' || portlet == null || portlet.id == null || portlet.id == '') return;
		$.ajax({
			dataType: "json",
			url: ctx + "/portlet/savePortletToAllRole?roleIds="+roleIds+"&portletId="+portlet.id,
			success:function(data){
				var rs = roleIds.split(',');
				if(rs != null && rs.length > 0){
					for(var i in rs){						
						myLib.desktop.deskIcon.addRoleIcon(rs[i],portlet);
					}
				}
			}
		});
	};
	function removeAllInRole(roleId){
		if(roleId == null || roleId == '') return;
		$.ajax({
            dataType: "json",
            url: ctx + "/portlet/removeRoleAllPortlet?roleId="+roleId,
            success:function(data){
            	myLib.desktop.deskIcon.removeRoleIcons(roleId);
            }
        });
	};
	function setRoleLayout(roleId){
		top.window.Index.addTab( null,ctx + "/views/portlet/index.jsp?roleId="+roleId, "角色portlet布局");
	};
	function removeRolePortlet(roleId,portletId){
		if(roleId == null || roleId == '' || portletId == null || portletId == '') return;
		$.ajax({
			dataType: "json",
			url: ctx + "/portlet/removeRolePortlet?roleId="+roleId+"&portletId="+portletId,
			success:function(data){
				myLib.desktop.deskIcon.removeRoleIcon(roleId,portletId);
			}
		});
	};
	function removePortletToAllRole(roleIds,portletId){
		if(portletId == null || portletId == '') return;
		$.ajax({
			dataType: "json",
			url: ctx + "/portlet/removePortletOfRoles?id="+portletId,
			success:function(data){
				myLib.desktop.deskIcon.removeIconInRoles(roleIds,portletId);
			}
		});
	};
	function removePortlet(roleIds,portletId){
		if(portletId == null || portletId == '') return;
		$.ajax({
			dataType: "json",
			url: ctx + "/portlet/removePortlet?id="+portletId,
			success:function(data){
				myLib.desktop.deskIcon.removePortletIcons(roleIds,portletId);
			}
		});
	};
	function loadIcons(){
		$.ajax({
            dataType: "json",
            url: ctx + "/portlet/findSysPortlets",
            success:addIcon
        });
	};
	//添加应用函数
	function addIcon(portletData) {
		if(portletData != null && portletData.length > 0){
			myLib.desktop.portlets = portletData;
			
			for(var k in portletData){
				var data = {id:portletData[k].id,iconSrc:(portletData[k].icon != null && portletData[k].icon != "")?portletData[k].icon:"icon/icon7.png",title:portletData[k].title,url:portletData[k].url};
				myLib.desktop.deskIcon.addIcon(data);
			}
		}
	};
