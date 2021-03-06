/*-----------------------------------------------------------------------------
*version:1.0  , 时间：2013-09-14
*desktop需引入myLib.js创建命名空间，和jquery 及 jquery ui,contextMenu jquery插件
-----------------------------------------------------------------------------*/
//声明desktop空间,封装相关操作
myLib.NS("desktop");
myLib.desktop={
	portlets : [],
	roles :[],
	layoutObject : {"bgimg":"themes/default/images/blue_glow.jpg","taskbar":true,"navbar":4,"deskindex":1,"desktops":[{"index":1,"portlets":[]}]},
	winWH:function(){
		$('body').data('winWh',{'w':$(window).width(),'h':$(window).height()});
 	},
	desktopPanel:function(){
		$('body')
		.data('panel',{
					   'taskBar':{
					   '_this':$('#taskBar'),
					   'task_lb':$('#task_lb')
										},
					   'navBar':$('#navBar'),
					   'wallpaper':$('#wallpapers'),
					   'lrBar':{
					   '_this':$('#lr_bar'),	   
					   'default_app':$('#default_app'),
				       'start_block':$('#start_block'),
				       'start_btn':$('#start_btn'),
				       'add_icon':$('#add_icon'),
					   'start_item':$('#start_item'),
					   'add_item':$('#add_item'),
					   'role_item':$('#role_item'),
					   'save_icon':$('#save_icon'),
					   'default_tools':$('#default_tools')
							},		
					   'desktopPanel':{
							'_this':$('#desktopPanel'),
							'innerPanel':$('#desktopInnerPanel'),
							'deskIcon':$('ul.deskIcon')
							},
						'powered_by':$('a.powered_by')
						});
		},
	iconDataInit:function(data){
		 for(var a in data){
			 $("#"+a).data("iconData",data[a]);
			 }
		},	
	getMydata:function(){
		return $('body').data();
		},
	mouseXY:function(){
		var mouseXY=[];
		$(document).bind('mousemove',function(e){ 
			mouseXY[0]=e.pageX;
			mouseXY[1]=e.pageY;
           });
		return mouseXY;
		},	
	contextMenu:function(jqElem,data,menuName,textLimit){
		  var _this=this
		      ,mXY=_this.mouseXY();
		  
          jqElem
		  .smartMenu(data,{
            name: menuName,
			textLimit:textLimit,
			afterShow:function(){
				var menu=$("#smartMenu_"+menuName);
				var myData=myLib.desktop.getMydata(),
		            wh=myData.winWh;//获取当前document宽高
 				var menuXY=menu.offset(),menuH=menu.height(),menuW=menu.width();
				if(menuXY.top>wh['h']-menuH){
					menu.css('top',mXY[1]-menuH-2);
					}
				if(menuXY.left>wh['w']-menuW){
					menu.css('left',mXY[0]-menuW-2);
					}	
				}
           });
		  $(document.body).click(function(event){
			event.preventDefault(); 			  
			$.smartMenu.hide();
						  });
		}	
	};
	
//弹出窗口，支持拖曳，改变大小，关闭，最大化，最小化
myLib.NS("desktop.win");
myLib.desktop.win={
	wins : [],
	addWinData:function(obj){
		//添加窗口数据
		var _win = obj;
		var myData=obj.data(),winLocation=myData.winLocation,id=myData._id;
		var newdata = {"id":id,"width":winLocation['w'],"height":winLocation['h'],"left":winLocation['left'],"top":winLocation['top']};
		var portlets = myLib.desktop.layoutObject.desktops[0].portlets;
		var ishas = false;
		for(var i in portlets){
			if(portlets[i] != null && id == portlets[i].id){
				ishas = true;
			}
		}
		this.wins[this.wins.length] = newdata;
		if(!ishas) saveUserLayout();
	},
	removeWinData:function(obj){
		//移除窗口数据
		var _win = obj;
		var myData=obj.data(),winLocation=myData.winLocation,id=myData._id;
		for(var i in this.wins){
			if(this.wins[i] != null){				
				var _id = this.wins[i].id;
				if(id == _id){
					this.wins[i] = null;
					saveUserLayout();
					return;
				}
			}
		}
	},
	changeWinData:function(obj){
		//改变窗口数据
		var _win = obj;
		var myData=obj.data(),winLocation=myData.winLocation,id=myData._id;
		var newdata = {"id":id,"width":winLocation['w'],"height":winLocation['h'],"left":winLocation['left'],"top":winLocation['top']};
		for(var i in this.wins){
			if(this.wins[i] != null){				
				var _id = this.wins[i].id;
				if(id == _id){
					this.wins[i] = newdata;
					saveUserLayout();
					return;
				}
			}
		}
	},
	winHtml:function(title,url,id){
		return "<div class='windows corner' id="
		+id
		+"><div class='win_title'><b>"
		+title
		+"</b><span class='win_btnblock'><a href='#' class='winMinimize' title='最小化'></a><a href='#' class='winMaximize' title='最大化'></a><a href='#' class='winHyimize' title='还原'></a><a href='#' class='winClose' title='关闭'></a></span></div><iframe frameborder='0' name='myFrame_"
		+id
		+"' id='myFrame_"
		+id
		+"' class='winframe' scrolling='auto' width='100%' src=''></iframe></div>";
		},
	 //添加遮障层，修复iframe 鼠标经过事件bug	
	iframFix:function(obj){
		obj.each(function(){
		var o=$(this);								
		if(o.find('.zzDiv').size()<=0)
		o.append($("<div class='zzDiv' style='width:100%;height:"+(o.innerHeight()-26)+"px;position:absolute;z-index:900;left:0;top:26px;'></div>"));
				 })
		},	
	//获取当前窗口最大的z-index值
	maxWinZindex:function($win){
		   return Math.max.apply(null, $.map($win, function (e, n) {
           if ($(e).css('position') == 'absolute')
            return parseInt($(e).css('z-index')) || 1;
              }));
			},
	//获取当前最顶层窗口		
	findTopWin:function($win,maxZ){
		var topWin;
		$win.each(function(index){
 						   if($(this).css("z-index")==maxZ){
							   topWin=$(this);
							   return false;
							   } 
 						   });
		return topWin;  
		},		
	//关闭窗口	
	closeWin:function(obj){
		var _this=this,$win=$('div.windows').not(".hideWin"),maxZ,topWin;
 		myLib.desktop.taskBar.delWinTab(obj);
		obj.hide(200,function(){
			$(this).remove();
				         });
		//当关闭窗口后寻找最大z-index的窗口并使其出入选择状态
		if($win.size()>1){
		maxZ=_this.maxWinZindex($win.not(obj));
		topWin=_this.findTopWin($win,maxZ);
		_this.switchZindex(topWin);
		}
		myLib.desktop.win.removeWinData(obj);
		},
	//最小化窗口	
	minimize:function(obj){
		var _this=this,$win=$('div.windows').not(".hideWin"),maxZ,topWin,objTab;
		//obj.hide();
		obj.css({"left":obj.position().left-10000,"visibility":"hidden"}).addClass("hideWin");
		
		//最小化窗口后，寻找最大z-index窗口至顶
		if($win.size()>1){
		maxZ=_this.maxWinZindex($win.not(obj));
		topWin=_this.findTopWin($win,maxZ);
		_this.switchZindex(topWin);
		}else{
			objTab=myLib.desktop.taskBar.findWinTab(obj);
			objTab.removeClass('selectTab').addClass('defaultTab');
			}
		},	
	//最大化窗口函数	
	maximizeWin:function(obj){
		var myData=myLib.desktop.getMydata(),
		    panel=$("#desktopInnerPanel").offset(), 
		    wh=myData.winWh;//获取当前document宽高
		obj
		.css({'width':wh['w'],'height':wh['h'],'left':-panel.left,'top':-panel.top})
		.draggable( "disable" )
		.resizable( "disable" )
		.fadeTo("fast",1)
		.find(".winframe")
		.css({'width':wh['w'],'height':wh['h']-26});
		},
	//还原窗口函数	
	hyimizeWin:function(obj){
		var myData=obj.data(),
		    winLocation=myData.winLocation;//获取窗口最大化前的位置大小
			
		obj.css({'width':winLocation['w'],'height':winLocation['h'],'left':winLocation['left'],'top':winLocation['top']})
		.draggable( "enable" )
		.resizable( "enable" ) 
		.find(".winframe")
		.css({'width':winLocation['w'],'height':winLocation['h']-26});
		},	
	//交换窗口z-index值		
	switchZindex:function(obj){
		var myData=myLib.desktop.getMydata()
		    ,$topWin=myData.topWin
			,$topWinTab=myData.topWinTab
		    ,curWinZindex=obj.css("z-index")
			,maxZ=myData.maxZindex
			,objTab=myLib.desktop.taskBar.findWinTab(obj);
			
		if(!$topWin.is(obj)){
			
		obj.css("z-index",maxZ);
		objTab.removeClass('defaultTab').addClass('selectTab');
		
		$topWin.css("z-index",curWinZindex);
		$topWinTab.removeClass('selectTab').addClass('defaultTab');
		this.iframFix($topWin);
		//更新最顶层窗口对象
		$('body').data("topWin",obj).data("topWinTab",objTab);
		}
		},
	//新建一个窗口	
    newWin:function(options){
		
		var myData=myLib.desktop.getMydata(),
		    wh=myData.winWh,//获取当前document宽高
			$windows=$("div.windows"),
			_this=this,
			curwinNum=myLib._is(myData.winNum,"Number")?myData.winNum:0;//判断当前已有多少窗口
			_this.iframFix($windows);
			
		//默认参数配置
        var defaults = {
            WindowTitle:          null,
			WindowsId:            null,
            WindowPositionTop:    'center',                          /* Posible are pixels or 'center' */
            WindowPositionLeft:   'center',                          /* Posible are pixels or 'center' */
            WindowWidth:          Math.round(wh['w']*0.47),           /* Only pixels */
            WindowHeight:         Math.round(wh['h']*0.47),           /* Only pixels */
            WindowMinWidth:       250,                               /* Only pixels */
            WindowMinHeight:      250,                               /* Only pixels */
		    iframSrc:             null,                              /* 框架的src路径*/ 
            WindowResizable:      true,                              /* true, false*/
            WindowMaximize:       false,                              /* true, false*/
            WindowMinimize:       false,                              /* true, false*/
            WindowClosable:       false,                              /* true, false*/
            WindowDraggable:      true,                              /* true, false*/
            WindowStatus:         'regular',                         /* 'regular', 'maximized', 'minimized' */
            WindowAnimationSpeed: 500,
            WindowAnimation:      ''
        };
		  
		var options = $.extend(defaults, options);
 		 
		//判断窗口位置，否则使用默认值
		var dxy=Math.floor((Math.random()*100))+30;
		var panelLeft=$("#desktopInnerPanel").position();
		 
		var wLeft=myLib._is(options['WindowPositionLeft'],"Number")?options['WindowPositionLeft']+panelLeft.left:(wh['w']-options['WindowWidth'])/2+dxy-panelLeft.left;
		var wTop=myLib._is(options['WindowPositionTop'],"Number")?options['WindowPositionTop']:(wh['h']-options['WindowHeight'])/2+dxy/2;
 		 
		//给窗口赋予新的z-index值
		var zindex=curwinNum+500;
		var id="myWin_"+options['WindowsId'];//根据传来的id将作为新窗口id
 		$('body').data("winNum",curwinNum+1);//更新窗口数量
 
		
		//判断如果此id的窗口存在，则不创建窗口
		if($("#"+id).size()<=0){
			//在任务栏里添加tab
			myLib.desktop.taskBar.addWinTab(options['WindowTitle'],options['WindowsId']);
			//初始化新窗口并显示
			$(_this.winHtml(options['WindowTitle'],options['iframSrc'],id)).appendTo('#desktopInnerPanel');
		
		var $newWin=$("#"+id)
		   ,$icon=$("#"+options['WindowsId'])
		   ,$iconOffset=$icon.offset()
		   ,$fram=$newWin.find(".winframe")
		   ,$winTitle=$newWin.find(".win_title")
		   ,winMaximize_btn=$newWin.find('a.winMaximize')//最大化按钮
		   ,winMinimize_btn=$newWin.find('a.winMinimize')//最小化按钮
		   ,winClose_btn=$newWin.find('a.winClose')//关闭按钮
		   ,winHyimize_btn=$newWin.find('a.winHyimize');//还原按钮
		   
		   winHyimize_btn.hide();
		   if(!options['WindowMaximize']) winMaximize_btn.hide();
		   if(!options['WindowMinimize']) winMinimize_btn.hide();
		   if(!options['WindowClosable']) winClose_btn.hide();
		
		//存储窗口最大的z-index值,及最顶层窗口对象
		$('body').data({"maxZindex":zindex,"topWin":$newWin});
		
		//判断窗口是否启用动画效果
		if(options.WindowAnimation=='none'){
			
		 $newWin
		 .css({"width":options['WindowWidth'],"height":options['WindowHeight'],"left":wLeft,"top":wTop,"z-index":zindex})
		 .addClass("loading")
		 .show(10,function(){
				$(this).find(".winframe").attr("src",options['iframSrc']).load(function(){
																						$(this).show();
																						});
						   });
		 
			}else{
	 		
		 $newWin
		 .css({"left":$iconOffset.left,"top":$iconOffset.top,"z-index":zindex})
		 .addClass("loading")
		 .show()
		 .animate({ 
            width: options['WindowWidth'], 
            height:options['WindowHeight'],
            top: wTop, 
            left: wLeft}, 100,function(){
				$(this).find(".winframe").attr("src",options['iframSrc']).load(function(){
																						$(this).show();
																						});
				});
 				}
				
        $newWin
        .data('_id',options['WindowsId'])
		//存储窗口当前位置大小
		.data('winLocation',{
			  'w':options['WindowWidth'],
			  'h':options['WindowHeight'],
			  'left':wLeft,
			  'top':wTop
			  })
		//鼠标点击，切换窗口，使此窗口显示到最上面
		.bind({
			"mousedown":function(event){  
			_this.switchZindex($(this));
					},
			"mouseup":function(){
			$(this).find('.zzDiv').remove();
						}		
				})
		.find(".winframe")
		.css({"width":options['WindowWidth'],"height":options['WindowHeight']-26});
					   
 		 //调用窗口拖动,参数可拖动的范围上下左右，窗口id和，浏览器可视窗口大小
		 if(options['WindowDraggable']){
		   _this.drag([0,0,wh['w']-options['WindowWidth']-10,wh['h']-options['WindowHeight']-35],$newWin,wh);
		  }
		//调用窗口resize,传递最大最小宽度和高度，新窗口对象id，浏览器可视窗口大小
		if(options['WindowResizable']){
		   _this.resize(options['WindowMinWidth'],options['WindowMinHeight'],wh['w']-wLeft,wh['h']-wTop-35,$newWin,wh);
		 }
        
		//双击窗口标题栏
		$winTitle.dblclick(function(){
								var hasMaximizeBtn=$(this).find(winMaximize_btn);
								
									if(!hasMaximizeBtn.is(":hidden")){
										winMaximize_btn.trigger("click");
									}else{
 										winHyimize_btn.trigger("click");
										}
										
									});
  	    		
		//窗口最大化，最小化，及关闭
		
		$winTitle.mouseover(function(event){
			winClose_btn.show();
			winMinimize_btn.show();
			winMaximize_btn.show();
		});
		
		$winTitle.mouseout(function(event){
			winClose_btn.hide();
			winMinimize_btn.hide();
			winMaximize_btn.hide();
		});
		winClose_btn.click(function(event){
					 event.stopPropagation();
 					 _this.closeWin($newWin);
									  });
		//最大化
		winMaximize_btn.click(function(event){
					 event.stopPropagation();			   
					 if(options['WindowStatus']=="regular"){								 
					 _this.maximizeWin($newWin);
					 $(this).hide();
					 winHyimize_btn.show();
					 options['WindowStatus']="maximized";
					 $("#desktopPanel").css("z-index",95);
					 }
 						});
		
		//如果浏览器窗口大小改变，则更新窗口大小
		$(window).wresize(function(){
							if(options['WindowStatus']=="maximized"){	   
                              _this.maximizeWin($newWin);
							}
								   });
		//还原窗口
		winHyimize_btn.click(function(event){
					 event.stopPropagation();				  
					 if(options['WindowStatus']=="maximized"){								 
					 _this.hyimizeWin($newWin);
					 $(this).hide();
					 winMaximize_btn.show();
					 options['WindowStatus']="regular";
					 $("#desktopPanel").css("z-index",70);
					 }		  
									  });
		//最小化窗口
		winMinimize_btn.click(function(){
						_this.minimize($newWin);		   
									   });
		myLib.desktop.win.addWinData($newWin);
		             }else{
  						 
						 //如果已存在此窗口，判断是否隐藏
					     var wins=$("#"+id),objTab=myLib.desktop.taskBar.findWinTab(wins);
						 if(wins.is(":hidden")){
							  wins.show();
							  objTab.removeClass('defaultTab').addClass('selectTab');//当只有一个窗口时
						      myLib.desktop.win.switchZindex(wins);
							 }else{
								 
								 }
 						 }
		},
	upWinResize_block:function(win){
		    
			//更新窗口可改变大小范围,wh为浏览器窗口大小
            var offset=win.offset();
		    win.resizable( "option" ,{'maxWidth':$(window).width()-offset.left-10,'maxHeight':$(window).height()-offset.top-35})
		},
 	drag:function(arr,$newWin,wh){
		var _this=this;
		$newWin
		.draggable({ 
	    handle:'div.win_title',
	    iframeFix:false,
		scroll: false
		})
		.bind("dragstart",function(event,ui){
 					_this.iframFix($(this));
					$("#desktopPanel").css("z-index",95);
						  })
		.bind( "dragstop", function(event, ui) {
			$("#desktopPanel").css("z-index",70);	
			
			var obj_this=$(this);	
			
 			//计算可拖曳范围
			_this.upWinResize_block(obj_this);
			
		    obj_this
			//更新窗口存储的位置属性
			.data('winLocation',{
			'w':obj_this.width(),
			'h':obj_this.height(),
			'left':obj_this.position().left,
			'top':obj_this.position().top
			})
			.find('.zzDiv')
			.remove();
			 
			if(event.pageY>wh.h-50){
							  $(this).css("top",event.pageY-90);
 		    }else if(event.pageY<-35){
							  $(this).css("top",-35);  
								  }
			myLib.desktop.win.changeWinData($newWin);
         }); 
		
		   $("div.win_title").css("cursor","move");
		},
	resize:function(minW,minH,maxW,maxH,$newWin,wh){
		var _this=this;
		$newWin
		.resizable({
		minHeight:minH,
		minWidth:minW,
		containment:'document',
		maxWidth:maxW,
		maxHeight:maxH
		})
		.css("position","absolute")
		.bind( "resize", function(event, ui) {
			var h=$(this).innerHeight(),w=$(this).innerWidth(); 	
 			 _this.iframFix($(this));
			 
			//拖曳改变窗口大小，更新iframe宽度和高度，并显示iframe					 
			$(this).children(".winframe").css({"width":w,"height":h-26});
				
        })
	   .bind( "resizestop", function(event, ui) {					 
			var obj_this=$(this);
 			var h=obj_this.innerHeight(),w=obj_this.innerWidth();
  			
		    obj_this
			//更新窗口存储的位置属性
			.data('winLocation',{
			'w':w,
			'h':h,
			'left':obj_this.position().left,
			'top':obj_this.position().top
			  })
			 //删除遮障iframe的层
			.find(".zzDiv")
			.remove();
		    myLib.desktop.win.changeWinData($newWin);
       });
		}
	}
	
//侧边工具栏
myLib.NS("desktop.lrBar");
myLib.desktop.lrBar={
	contextMenu:function(roleId){
			var _this=this;
			myLib.desktop.contextMenu($("#role_"+roleId),myLib.desktop.role_right_button,"role_menu"+roleId,10);
	},
	upLrBar:function(){
		var myData=myLib.desktop.getMydata()
 			,$lrBar=myData.panel.lrBar['_this']
			,wh=myData.winWh;
		    $lrBar.css({'top':Math.floor((wh['h']-$lrBar.height())/2)-60});
 			
		},
	init:function(iconData){
		//读取元素对象数据
		var myData=myLib.desktop.getMydata()
	        ,$default_tools=myData.panel.lrBar['default_tools']
		    ,$def_tools_Btn=$default_tools.find('span')
			,$start_btn=myData.panel.lrBar['start_btn']
			,$add_icon=myData.panel.lrBar['add_icon']
			,$start_block=myData.panel.lrBar.start_block
			,$start_item=myData.panel.lrBar['start_item']
			,$add_item=myData.panel.lrBar['add_item']
			,$role_item=myData.panel.lrBar['role_item']
			,$save_icon=myData.panel.lrBar['save_icon']
			,$default_app=myData.panel.lrBar['default_app']
			,$lrBar=myData.panel.lrBar['_this']
			,wh=myData.winWh
			,_this=this;
  	
		//初始化侧栏位置
		_this.upLrBar();
		
		//附加data数据
		myLib.desktop.iconDataInit(iconData);
		
		//如果窗口大小改变，则更新侧边栏位置
		$(window).wresize(function(){
				 myLib.desktop.winWH();//更新窗口大小数据			   
 				_this.upLrBar();
								   });
		
		//任务栏右边默认组件区域交互效果	
		$def_tools_Btn.hover(function(){
							$(this).css("background-color","#999");	
								},function(){
									$(this).css("background-color","transparent");
									});	
		//默认应用程序区
		$default_app
		.find('li')
		.hover(function(){
						    $(this).addClass('btnOver');
								 },function(){
									$(this).removeClass('btnOver');		  
										});
		$("#role_portlets").click(function(event){
			event.preventDefault();
			event.stopPropagation()
			if($role_item.is(":hidden")){				
				$role_item.show();
			}else{				
				$role_item.hide();
				$('#role_portlets_item').hide();
			}
		});
		$("#add_portlets").click(function(event){
			event.preventDefault();
			event.stopPropagation()
			if($add_item.is(":hidden")){				
				$add_item.show();
			}else{				
				$add_item.hide();
			}
		});
		//开始按钮、菜单交互效果
		$start_btn.click(function(event){
								  event.preventDefault();
								  event.stopPropagation()
								  if($start_item.is(":hidden"))
								  $start_item.show();
								  else
								  $start_item.hide();
								  });
		//添加portlet
		$save_icon.click(function(event){
			var form = $add_item.find("form");
			var title = $add_item.find("input[name='title']").val();
			var url = $add_item.find("input[name='url']").val();
			var vali = true;
			if(url == null || url == ""){
				$add_item.find("#url_error").text("portlet URL不能为空！");
				$add_item.find("input[name='url']").focus();
				vali = false;
			}else{
				$add_item.find("#url_error").text("");
			}
			if(title == null || title == ""){
				$add_item.find("#title_error").text("portlet名称不能为空！");
				$add_item.find("input[name='title']").focus();
				vali = false;
			}else{
				$add_item.find("#title_error").text("");				
			}
			if(vali){
				$.ajax({
					type : "POST",
					dataType : "json",
					url : ctx + "/portlet/saveSysPortlet",
					data : form.serialize(),
					success : function(data, textStatus) {

						if (data.success) {
							var portlet = data.result;
							myLib.desktop.deskIcon.addIcon({id:portlet.id,iconSrc:portlet.icon != null && portlet.icon != ''?portlet.icon:"icon/icon7.png",title:portlet.title,url:portlet.url});
							$add_item.find(":text").val("");
						} 
					}
				});
			}
		});
		$("body").click(function(event){
			 event.preventDefault();  
			 $role_item.hide();
			 $('#role_portlets_item').hide();
	    });
		//全屏
		 $("#showZm_btn")
		 .toggle(function(){
							myLib.fullscreenIE();	
							myLib.fullscreen();
						},
				function(){
							myLib.fullscreenIE();
							myLib.exitFullscreen();
					});
		}
 	}
/*----------------------------------------------------------------------------------	
//声明任务栏空间，任务栏相关js操作
----------------------------------------------------------------------------------*/
myLib.NS("desktop.taskBar");
myLib.desktop.taskBar={
	timer:function(obj){
		 var curDaytime=new Date().toLocaleString().split(" ");
		 obj.innerHTML=curDaytime[1];
		 obj.title=curDaytime[0];
		 setInterval(function(){obj.innerHTML=new Date().toLocaleString().split(" ")[1];},1000);
		},
	upTaskWidth:function(){
		var myData=myLib.desktop.getMydata()
		    ,$task_bar=myData.panel.taskBar['_this'];
		var maxHdTabNum=Math.floor($(window).width()/100);
		    //计算任务栏宽度
		    $task_bar.width(maxHdTabNum*100);	
			//存储活动任务栏tab默认组数
			$('body').data("maxHdTabNum",maxHdTabNum-2);
		},	
	init:function(){
		//读取元素对象数据
		var myData=myLib.desktop.getMydata();
 		var $task_lb=myData.panel.taskBar['task_lb']
		    ,$task_bar=myData.panel.taskBar['_this']
			,wh=myData.winWh;
 
		 var _this=this;
		 _this.upTaskWidth();
		 //当改变浏览器窗口大小时，重新计算任务栏宽度
		 $(window).wresize(function(){
						_this.upTaskWidth();   
								   });
  		 
 		},
	contextMenu:function(tab,id){
		var _this=this;
		 //初始化任务栏Tab右键菜单
		 var data=[
					[{
					text:"最大化",
					func:function(){
 						$("#myWin_"+tab.data('win')).find('a.winMaximize').trigger('click');
						}
					  },{
					text:"最小化",
					func:function(){
						myLib.desktop.win.minimize($("#myWin_"+tab.data('win')));
						}
						  }]
					,[{
					  text:"关闭",
					  func:function(){
						  $("#smartMenu_taskTab_menu"+id).remove();
 						  myLib.desktop.win.closeWin($("#myWin_"+tab.data('win')));
						  } 
					  }]
					];
		 myLib.desktop.contextMenu(tab,data,"taskTab_menu"+id,10);
		},
	addWinTab:function(text,id){
		var myData=myLib.desktop.getMydata();
 		var $task_lb=myData.panel.taskBar['task_lb']
		    ,$task_bar=myData.panel.taskBar['_this']
			,$navBar=myData.panel.navBar
 			,$navTab=$navBar.find("a")
		    ,tid="myWinTab_"+id
			,allTab=$task_lb.find('a')
			,curTabNum=allTab.size()
		    ,docHtml="<a href='#' id='"+tid+"'>"+text+"</a>";
			
			//添加新的tab
		    $task_lb.append($(docHtml));
			var $newTab=$("#"+tid);
			//右键菜单
			this.contextMenu($newTab,id);
			
			$task_lb
			.find('a.selectTab')
			.removeClass('selectTab')
			.addClass('defaultTab');
			 
			$newTab
			.data('win',id)
			.addClass('selectTab')
			.click(function(){
					var win=$("#myWin_"+$(this).data('win')),
					    tabId=this.id,
						iconId=tabId.split("_")[1],
						desk=$("#"+iconId).parent(),
 						i=desk.index("ul.deskIcon");	//判断窗口在那个桌面区域
 				    
					if(i<0){
						i=$("#"+iconId).data("currPanel");
						}
						
 					//如果是当前桌面
					if(desk.is(".currDesktop")){
						if(win.is(".hideWin")){
						//win.show();
						win.css({"left":win.position().left+10000,"visibility":"visible"}).removeClass("hideWin");
						
 						$(this).removeClass('defaultTab').addClass('selectTab');//当只有一个窗口时
						myLib.desktop.win.switchZindex(win);
  						}else{
							if($(this).hasClass('selectTab')){
							myLib.desktop.win.minimize(win);
  							}else{
								myLib.desktop.win.switchZindex(win);
								} 
							  }
							  
				    //如果不在当前窗口			  
				    }else{
					 if(win.is(".hideWin")){
						//win.show();
						win.css({"left":win.position().left+10000,"visibility":"visible"}).removeClass("hideWin");
						
 						$(this).removeClass('defaultTab').addClass('selectTab');//当只有一个窗口时
						myLib.desktop.win.switchZindex(win);
  						}	
					 $navTab.eq(i).trigger("click");
							}
 							  
 							});
			
			$('body').data("topWinTab",$newTab);
			
			//当任务栏活动窗口数超出时
			if(curTabNum>myData.maxHdTabNum-1){
				var LeftBtn=$('#leftBtn')
				    ,rightBtn=$('#rightBtn')
					,bH;
				
                LeftBtn
				.show()
				.find("a")
				.click(function(){
							        var pos=$task_lb.position();
									if(pos.top<0){
										$task_lb.animate({
                                                  "top":pos.top+40
                                                      }, 50);
										}
									 });
				
				rightBtn
				.show()
				.find("a")
				.click(function(){
									var pos=$task_lb.position(),h=$task_lb.height(),row=h/40;
									if(pos.top>(row-1)*(-40)){
									$task_lb.animate({
                                                  "top": pos.top-40
                                                      }, 50); 
									}
									   });
				
				$task_lb.parent().css("margin","0 100");
				}
	 
		},
	delWinTab:function(wObj){
		var myData=myLib.desktop.getMydata()
 		    ,$task_lb=myData.panel.taskBar['task_lb']
			,$task_bar=myData.panel.taskBar['_this']
			,LeftBtn=$('#leftBtn')
			,rightBtn=$('#rightBtn')
		    ,pos=$task_lb.position();
			
		this.findWinTab(wObj).remove();
		
		var newH=$task_lb.height();
		if(Math.abs(pos.top)==newH){
			LeftBtn.find('a').trigger("click");
			}
		if(newH==40){
			LeftBtn.hide();
			rightBtn.hide();
			$task_lb.parent().css("margin",0);
			}	
		},
	findWinTab:function(wObj){
		var myData=myLib.desktop.getMydata(),
		    $task_lb=myData.panel.taskBar['task_lb'],
		    objTab;
		    $task_lb.find('a').each(function(index){
								var id="#myWin_"+$(this).data("win");		 
								if($(id).is(wObj)){
									objTab=$(this);
									}		 
 										 });
		    return objTab;
		}	
	}
//navbar
myLib.NS("desktop.navBar");
myLib.desktop.navBar={
	init:function(){
		 var myData=myLib.desktop.getMydata()
			 ,$navBar=myData.panel.navBar
			 ,$innerPanel=myData.panel.desktopPanel.innerPanel
			 ,$navTab=$navBar.find("a")
			 ,$deskIcon=myData.panel.desktopPanel['deskIcon']
			 ,desktopWidth=$deskIcon.width()
			 ,lBarWidth=myData.panel.lrBar["_this"].outerWidth();
			 
			 $navBar
			 .draggable({
 					scroll:false
						});
			 
			 $navTab
			 .droppable({
				scope:'a',
				over:function(event,ui){
					$(this).trigger("click");
					var i=$navTab.index($(this));
					//ui.draggable
					//.css({left:event.pageX+$deskIcon.width()*i});
 					},
                drop: function(event,ui) {
				var i=$navTab.index($(this));	
 				ui.draggable
				.addClass("desktop_icon")
				.insertBefore($deskIcon.eq(i).find(".add_icon"))
				.find("span")
				.addClass("icon"); 
                myLib.desktop.deskIcon.init();
				myLib.desktop.lrBar.init();
					}
			 })
			 .click(function(event){
					event.preventDefault();
					event.stopPropagation();
					var i=$navTab.index($(this));
					desktopWidth=$deskIcon.width();
 					myLib.desktop.deskIcon.desktopMove($innerPanel,$deskIcon,$navTab,500,desktopWidth+lBarWidth,i);
							 });
		}
	};

//桌面背景
myLib.NS("desktop.wallpaper");
myLib.desktop.wallpaper={
	init:function(imgUrl){
		
		    //将当前窗口宽度和高度数据存储在body元素上
		    myLib.desktop.winWH();
			
		    var myData=myLib.desktop.getMydata()
		         ,winWh=myData.winWh
			     ,wallpaper=myData.panel.wallpaper
				 ,_this=this;
 				 
				 if(imgUrl!==null){
				 wallpaper.html("<img src='"+imgUrl+"'></img>");
			     var img=wallpaper.find("img");	
 				
					 myLib.getImgWh(imgUrl,function(imgW,imgH){
 								 if(imgW<=winWh.w){
								      img.css('width',winWh.w);
									}else{
										img.css({"margin-left":-(imgW-winWh.w)/2});
										}
								if(imgH<=winWh.h){
								img.css('height',winWh.h);
									}else{
										img.css({"margin-top":-(imgH-winWh.h)/2});
										}	
												});	
				 }
				 
		//如果窗口大小改变，更新背景布局大小
		 window.onresize=function(){
     							_this.init(imgUrl);
								};
		}
	};

//桌面图标区域
myLib.NS("desktop.deskIcon");
myLib.desktop.deskIcon={
	Menu:function(id,text,data){
		this.text = text;
		this.func = function(){
			addPortletToRole(id,data);
		}
	},
	contextMenu:function(data){
		var _this=this;
		var _roles = myLib.desktop.roles; 
		var temparray = new Array(_roles.length);
		var roleIds = ''; 
		var valuearray = new Array();
		if(temparray.length > 0){
			for(var i=0;i<temparray.length;i++){
				roleIds += _roles[i].rid + ',';
				var tt = "关联到「"+_roles[i].name+"」";
				
				temparray[i] =new this.Menu(_roles[i].rid,tt,data);
			}
		}
		var icon_right_button=[[{
				text:"关联到所有角色",
					func:function(){
						addPortletToRole(roleIds,data);
						}
					  }]
					,[]
   					,[{
   					  text:"与所有角色解除关系",
   					  func:function(){
   						  removePortletToAllRole(roleIds,data.id);
   						  } 
   					  }]
   					,[{
   						text:"删除此portlet",
   						func:function(){
   							removePortlet(roleIds,data.id);
   						} 
   					}]
   					];
		icon_right_button[1] = temparray;
		myLib.desktop.contextMenu($("#"+data.id),icon_right_button,"icon_menu"+data.id,20);
	},
	roleRightMenu:function(roleId){
		var role_right_button=[[{
			text:"解除与所有portlet的关系",
			func:function(){
				removeAllInRole(roleId);
			} 
		}],[{
			text:"设置角色默认portlet布局",
			func:function(){
				setRoleLayout(roleId);
			} 
		}]];
		myLib.desktop.contextMenu($("#rolePortlets_"+roleId),role_right_button,"role_menu"+roleId,20);
	},
	roleIconMenu:function(roleId,portletId){
		var role_portlets_right_button=[[{
			text:"解除与该角色的关系",
			func:function(){
				removeRolePortlet(roleId,portletId);
			} 
		}]];
		myLib.desktop.contextMenu($("#roleIcon"+roleId+"_"+portletId),role_portlets_right_button,"role_icon_menu"+roleId+"_"+portletId,20);
	},
	addRolePortlets:function(data){
		var _this=this;
		if(!$("#rolePortlets_"+data.rid).size()){
			//初始化角色列表
			var roleHtml="<li id='rolePortlets_"+data.rid+"'><span class='adminImg'></span>"+data.name+"</li>"; 
			$(roleHtml).appendTo("#role_item .item");
			//初始化角色icon块
			var roleIconContent = "<ul id='role_portlets_"+data.rid+"' class='deskIcon' style='display:none;'></ul>";
			$(roleIconContent).appendTo("#role_portlets_item");
			//初始化角色icon块中的icon
			var rportlets = data.portlets;
			if(rportlets != null && rportlets.length > 0){
				for(var i in rportlets){
					var portlet = rportlets[i];
					this.addRoleIcon(data.rid,portlet);
				}
			}
			$('#rolePortlets_'+data.rid).bind('click',function(event){
				  event.preventDefault();
				  event.stopPropagation()
				  var rps = $('#role_portlets_'+data.rid);
				  $('#role_portlets_item ul').hide();
				  $('#role_portlets_item').hide();
				  if(rps.is(":hidden")){					  
					  rps.show();
					  $('#role_portlets_item').show();
				  }
				  });
		}
		this.roleRightMenu(data.rid);
		},
	removeRoleIcons:function(roleId){
		if($("#role_portlets_"+roleId + " li").size() > 0){
			$("#role_portlets_"+roleId + " li").remove();
		}
	},
	removeRoleIcon:function(roleId,portletId){
		$("#roleIcon"+roleId + "_"+portletId).remove();
		$("#role_icon_menu"+roleId+"_"+portletId).remove();
	},
	removeIconInRoles:function(roleIds,portletId){
		if(roleIds != null && roleIds != ''){
			var rs = roleIds.split(',');
			if(rs != null && rs.length > 0){
				for(var i in rs){
					if(rs[i] != null && rs[i] != ''){						
						this.removeRoleIcon(rs[i],portletId);
					}
				}
			}
		}
	},
	removePortletIcons:function(roleIds,portletId){
		var _this = this;
		$("#"+portletId).remove();
		$("#icon_menu"+portletId).remove();
		this.removeIconInRoles(roleIds,portletId);
		_this.arrangeIcons($(this));
	},
	addRoleIcon:function(roleId,data){
		if(!$("#roleIcon"+roleId + "_"+data.id).size()){
			var iconSrc = data.icon != null && data.icon != ''?data.icon:data.iconSrc != null && data.iconSrc != ''?data.iconSrc:"icon/icon7.png"
			var iconHtml="<li class='desktop_icon' id='roleIcon"+roleId+"_"+data.id+"'><span class='icon'><img src='"+iconSrc+"'/></span><div class='text'>"+data.title+"<s></s></div></li>"; 
			$(iconHtml).appendTo("#role_portlets_"+roleId);
			
			$("#roleIcon"+roleId+"_"+data.id).data("iconData",{
								'title':data.title,
						        'url':data.url
								});
			this.roleIconMenu(roleId,data.id);
		}
	},
	addIcon:function(data){
		var _this=this;
		if(!$("#"+data.id).size()){
		var iconHtml="<li class='desktop_icon' id='"+data.id+"'><span class='icon'><img src='"+data.iconSrc+"'/></span><div class='text'>"+data.title+"<s></s></div></li>"; 
		$(iconHtml).appendTo("#start_item .deskIcon");
		_this.init();
		
		$("#"+data.id).data("iconData",{
							'title':data.title,
					        'url':data.url
							});
		
		}
		this.contextMenu(data);
		},
 	//桌面图标排列
	arrangeIcons:function(desktop){
          var myData=myLib.desktop.getMydata()
		     ,winWh=myData.winWh
			 ,$navBar=myData.panel.navBar
			 ,navBarHeight=$navBar.outerHeight()
		     //计算一共有多少图标
		     ,iconNum=desktop.find("li").size();
			
		 //存储当前总共有多少桌面图标
		 desktop.data('deskIconNum',iconNum);
		 
		 var gH=120;//一个图标总高度，包括上下margin
		 var gW=180;//图标总宽度,包括左右margin
		 var rows=Math.floor((winWh['h']-navBarHeight-75)/gH);
		 var cols=Math.ceil(iconNum/rows);
		 var curcol=0,currow=0;

		 desktop.
		 find("li")
		 .css({
				   "position":"absolute",
				   "margin":0,
				   "left":function(index,value){
					       var v=curcol*gW+0;
					           if((index+1)%rows==0){
							       curcol=curcol+1;
					              }
						   return v;	 
 						},
					"top":function(index,value){
 							var v=(index-rows*currow)*gH+10;
								if((index+1)%rows==0){
									 currow=currow+1;
									}
						    return v;
							}});
		},
	upDesktop:function($deskIcon,$deskIconBlock,$innerPanel,$deskIconNum,navBarHeight,lBarWidth){
		 var myData=myLib.desktop.getMydata()
		    ,winWh=myData.winWh
		    ,w=winWh['w']
		    ,h=(winWh['h'])
		    ,_this=this;
		 
		//设置桌面图标容器元素区域大小
		 $innerPanel.css({"width":((w+lBarWidth)*$deskIconNum)+"px","height":h+"px"});
		 $deskIcon.css({"width":w+"px","height":h+"px"});
		 //$deskIconBlock.css({"width":w+"px","height":h+"px","margin-top":navBarHeight,'margin-left':lBarWidth+'px','margin-bottom':75+"px"});
		 
		 $deskIcon.each(function(){
				_this.arrangeIcons($(this));
				
				$(this)
				.droppable({
				scope:'a',
                drop: function(event,ui) {
 				ui.draggable
				.addClass("desktop_icon")
				.insertBefore($(this).find(".add_icon"))
				.find("span")
				.addClass("icon"); 
                _this.init();
				myLib.desktop.lrBar.init();
					}
					});
								 });
		},
	desktopMove:function($innerPanel,$deskIcon,$navTab,dates,moveDx,nextIndex){
		 $innerPanel
		 .stop()
		 .animate({
				 left:-(nextIndex)*moveDx
				},dates,function(){
							$deskIcon
							.removeClass("currDesktop")
							.eq(nextIndex)
							.addClass("currDesktop");
												 
							$navTab
							.removeClass("currTab")
							.eq(nextIndex)
							.addClass("currTab");
 							});
		},	
	init:function(iconData){
 		 
 		 var myData=myLib.desktop.getMydata()
		    ,winWh=myData.winWh
			,$deskIconBlock=myData.panel.desktopPanel['_this']
			,$innerPanel=myData.panel.desktopPanel.innerPanel
			,$deskIcon=myData.panel.desktopPanel['deskIcon']
			,$deskIconNum=$deskIcon.size()
			,$navBar=myData.panel.navBar
			,navBarHeight=$navBar.outerHeight()
			,$navTab=$navBar.find("a")
			,lBarWidth=myData.panel.lrBar["_this"].outerWidth()
			,_this=this;
  		 
		 _this.upDesktop($deskIcon,$deskIconBlock,$innerPanel,$deskIconNum,navBarHeight,lBarWidth);
		
		 //如果窗口大小改变，则重新排列图标
		 $(window).wresize(function(){
							myLib.desktop.winWH();//更新窗口大小数据
							_this.upDesktop($deskIcon,$deskIconBlock,$innerPanel,$deskIconNum,navBarHeight,lBarWidth);
   								   });
 		 //附加data数据
		 myLib.desktop.iconDataInit(iconData);
 		 
		 //桌面可使用鼠标拖动切换
		 var timeStart,timeEnd,dxStart,dxEnd;
		 
		 $innerPanel
		 .draggable({
					axis:'x',
					start:function(event,ui){
						 
						$(this).css("cursor","move");
						timeStart=new Date().getTime();
						dxStart=event.pageX;
						},
					stop:function(event,ui){
						$(this).css("cursor","inherit");
						timeEnd=new Date().getTime();
						dxEnd=event.pageX;
						var timeCha=timeEnd-timeStart
						    ,dxCha=dxEnd-dxStart
							,currDesktop=$(this).find("ul.currDesktop")
							,deskIndex=$deskIcon.index(currDesktop)
							,moveDx=$deskIcon.width()+lBarWidth
							,dates=1000+timeCha;
						
						//左移	
						if(dxCha < -150 && deskIndex<3){
 						_this.desktopMove($(this),$deskIcon,$navTab,dates,moveDx,deskIndex+1);
						//右移	 
 						}else if(dxCha > 150 && deskIndex>0){
 						_this.desktopMove($(this),$deskIcon,$navTab,dates,moveDx,deskIndex-1);
 						}else{
						$(this)
						.animate({
								left:-(deskIndex)*moveDx
								},500);
						}
 						}	
					});
		 
 		 
		 //图标鼠标经过效果
		 $deskIcon
		 .find("li")
 		 .hover(function(){
						 $(this).addClass("desktop_icon_over");
						 },
						 function(){
							  $(this).removeClass("desktop_icon_over");
							 })
		 .not("li.add_icon")
 		 .draggable({
					helper: "clone",
					scroll:false,
					opacity: 0.7,
					scope:'a',
					appendTo: 'body' ,
					zIndex:91,
					start: function(event, ui) {
 						ui.helper.removeClass("desktop_icon_over");
						} 
					})
		 .droppable({
				scope:'a',
                drop: function(event,ui) {
 				ui.draggable
				.unbind("dblclick")
				.addClass("desktop_icon")
				.insertBefore($(this))
				.find("span")
				.addClass("icon"); 
                _this.init();
				myLib.desktop.lrBar.init();
					}
           });
		 
 		 
		 //初始化桌面右键菜单
		 var data=[
					[{
					text:"显示桌面",
					func:function(){}
						}]
					];
		 myLib.desktop.contextMenu($(document.body),data,"body",10);
		}
	}
