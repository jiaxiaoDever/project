<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<%@ include file="/common/meta.jsp" %>
		<title>佰润BI</title>
		<style type = "text/css">
            html, body, .ui-layout-center, .ui-layout-content { overflow: hidden; }
            #rptlist{padding: 10px 15px; line-height: 24px; color: #333;}
            #rptlist a,.rptlist a:link{color: #333;}
            .rptlist a:hover{color:blue;}
            .yhui-portlet-column {padding-bottom: 10px;}
            .yhui-portlet-content .ui-jqgrid-bdiv{height:auto;}
        </style>
   <script language="JavaScript">
   			//禁止后退功能
         window.history.forward(1);
	</script>
	</head>
	<body>
		<div class = "yhui-cover yhui-whole-loading"></div>
        <div class = "yhui-cover yhui-whole-overlay"></div>
		<div class="yhui-header ui-layout-north">
			<div class = "yhui-header-inner">
               <div>
                  <a class = "yhui-header-welcome" href = "#">欢迎您，${user.username }!</a>
                  <a href = "#" class = "yhui-header-password">[10]</a>|               
					<span id="userRole" class = "yhui-header-role" >用户角色
						<ul class = "yhui-header-rolelist">						
						<c:forEach var='role' items='${user.roles}'>
							<li><a href="#">${role.name }</a></li>
							</c:forEach></ul>
					</span>
                  <!--  <span id = "userRole" ><c:forEach var='role' items='${user.roles}'>${role.name }&nbsp;&nbsp;</c:forEach>
                   </span>-->|
                  <a id="agencyinfo" href = "${ctx}/views/report/agency.jsp" target="_blank">待办信息</a>|
                  <a id="uinfo" href = "#">个人信息</a>|
                  <a id="uinfo" href = "${ctx}/demo/index.jsp" target="_blank">BringBI演示</a>|
                  <a href = "javascript:void(0);" onclick="logout();">注销</a>
               </div>
            </div>
            <ul class="yhmenu" id="headMenu"></ul>
		</div> 	 

		<div class="ui-layout-center">
		  <div class = "yhui-tabs-header">
             <div class = "yhui-tabs-header-inner">
               <ul>
                 <li id="tab_index" title="欢迎使用昱辉基础平台" class="ui-state-default ui-corner-top ui-tabs-active ui-state-active" role="tab" tabindex="0" aria-controls="yhtabs-1384416800618" aria-labelledby="ui-id-2" aria-selected="true"><a href="#yhtabs-1384416800618" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-2">欢迎使用昱辉基础平台</a><span id="table_index_close" title="关闭" class="ui-icon ui-icon-close yhui-tabs-close">Remove Tab</span></li>
               </ul>
             </div>
           </div>  
           <div class = "ui-layout-content">
              <div id = "tabs-1" style="overflow:auto;"></div>
            </div>
        </div>
		
	</body>
	<script type="text/javascript" src="${ctx}/views/logout.js"></script>
	<script type="text/javascript">
	
		var Index = {
				layout : function(){
					$(document.body).yhLayout({
						north : {
							size: 65,
                            spacing_open: 0
						},
					
						center : {
							onresize : function(a,b){
								Index.tabs.yhTabs("update");
							}
						},
						addBorder: true
					});
				},
				 userRole: function() {
                    $( "#userRole" ).hover( function() {
                        $( this ).toggleClass( 'userRoleHover' ).find( 'ul' ).slideToggle( 100 );
                    } );
                },
				
				
				initTabs : function(selector){
					this.tabs = $(selector).yhTabs({
						frame : true,
						showLoading : true,
						create : function(){
							$.yhui.loadingFadeOut();
							$("div.ui-layout-resizer-north").eq(0).remove();
						}
					});
				},
				
				initHeadMenu : function(selector){
					$("#headMenu").yhMenu({  //初始化菜单
						url:"index/getMenu", //获取json的URL
						onClick: function( e, yhui ) { //click事件
							var $li = $( "#" + yhui.node.mId );
							var random = new Date().getTime();
							var url =yhui.node.link;
							if(url.indexOf("?")>0){
								url = [url,'&random=',random].join('');
							}else{
								url=[url,'?random=',random].join('');
							}
							
                            if ( !yhui.node.isNewWindow ) {
                                Index.addTab($li,url);
                            } else {
                                window.open( url, "_blank" );
                            }
						}
					});
				},
				
				addTab : function(dom,url,title){
					Index.tabs.yhTabs( "addTab", dom,url, title);
				}
				
		};
		
		YHUI.use("yhLayout yhMenu yhTabs yhGrid yhLoading yhTreemenu yhPortlet",function(){
			Index.layout();
			Index.initHeadMenu(); 
			Index.userRole();
			Index.initTabs( "div.ui-layout-center:first" );
			$('#uinfo').bind("click",function(){
				var link = "${ctx}/views/system/userinfo.jsp";
				Index.tabs.yhTabs( "addTab", $('.yhui-tabs-header-inner'),link, "个人信息");
			});
			Index.tabs.yhTabs("add",{title:"欢迎使用佰润BI",id:"tab_index",src:"${ctx}/views/portlet/index.jsp"});
			$("#table_index_close").trigger('click');
		});
	</script>
	<script  id ="keepsession" type="text/javascript">
	function keepsession(){ 
		document.all["keepsession"].src=ctx+"/system/session/keepSession?id="+Math.random(); 
			window.setTimeout("keepsession()",300000); 
		} 
		keepsession();
	</script>
</html>