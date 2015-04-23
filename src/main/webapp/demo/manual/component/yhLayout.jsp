<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>布局</title>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metadoc.jsp" %>
</head>
<body>
<div class="container">
        <h1>yhLayout, yhui 的布局</h1>
        <div class="content">
            <h2>概述</h2>
            <div class="panel">
              <p>底层来自 <a href="http://layout.jquery-dev.net/">jquery layout</a>。</p>
              <p>布局组件，可以轻松地将页面分成几个部分并可以调整大小。可以嵌套布局，理论上可以无限嵌套。</p> 
            </div>
            <h3>特有名词</h3>
            <div class="panel">
            <p><strong>容器(container)</strong>：要创建布局的元素，比如 body 。</p>
            <p><strong>面板(panes)</strong>：很好理解，就是 north, west, south, east, center 五个主体部分。</p>
            <p><strong>空隙(spacing)</strong>：面板之间的空间，通常会放入一个 div 做为 拖动栏。</p>
            <p><strong>拖动栏(resizer-bar)</strong>：充满了 spacing，可以拖动改变面板大小。</p>
            <p><strong>滑动栏(slider-bar)</strong>：面板关闭时，拖动栏就变成了滑动栏，鼠标单击时，面板会滑开，鼠标移开时，面板关闭。</p>
            <p><strong>切换按钮(toggler-button)</strong>：拖动栏中间的箭头，点击可以展开/关闭对应的面板。</p>
            </div>

             <h2>使用方法</h2>
             <div class="panel">
                <pre class="brush:js">
                     //通用方式。
                    $( document.body ).yhLayout(); 
               </pre> 
               <pre class="brush:js">
                     //当需要设置某属性时使用。
                    $(document.body ).yhLayout({
                       ......
                     });
               </pre>
               <pre class="brush:js">
                     //需要嵌套布局时使用。
                    $(document.body ).yhLayout({
                       ......
                     });
                    $("#mainContent").yhLayout({
                            north:{ 
                              size:54
                            },
                            center:{
                              size:400
                            },  
                            center__onresize: function() {
                                grid.yhGrid( "refresh" );
                            }
                    });
               </pre>
             </div>


            <h2>案例</h2>
            <div class="panel">
              <table class="infotable">
                <tr>
                  <th>布局大类</th>
                  <th>布局细分</th>
                  <th>图例</th>                  
                  <th>案例</th>
                  <!-- <th>备注</th> -->
                </tr>
                <tr>
                  <td rowspan="5">基本布局</td>
                  <td>上下</td>
                  <td><img src="../images/layout/jc_01.gif" alt=""></td>                  
                  <td>
                      <pre class="brush:js">
                          <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                          <div class = 'ui-layout-center' >   
                            <div class="ui-layout-content">内容区</div>
                          </div>
                      </pre>                      
                  </td>
                </tr>
                <tr>
                  <td>左右</td>
                  <td><img src="../images/layout/jc_02.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="ui-layout-west">    
                          <div class="ui-layout-content">左侧栏</div>    
                        </div>
                        <div class="ui-layout-center">
                          <div class="ui-layout-content">右侧栏</div>
                        </div>
                    </pre>                      
                  </td>
                </tr>
                <tr>
                  <td>上中下</td>
                  <td><img src="../images/layout/jc_03.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                        <div class = 'ui-layout-center' >中心区</div>
                        <div class = 'ui-layout-south' >底部区</div>
                    </pre>                      
                  </td>
                </tr>                
                <tr>
                  <td>左中右</td>
                  <td><img src="../images/layout/jc_04.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                        <div class="ui-layout-west">左侧栏</div>
                        <div class="ui-layout-center">中心区</div>
                        <div class="ui-layout-east">右侧栏</div>
                      </pre>     
                  </td>
                </tr>
                <tr>
                  <td>上-左右</td>
                  <td><img src="../images/layout/jc_05.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                        <div class="ui-layout-west">左侧栏</div>
                        <div class="ui-layout-center">中心区</div>
                      </pre>                      
                  </td>                    
                </tr>
                <tr>
                  <td rowspan="3">嵌套布局</td>
                  <td>嵌套布局-纵向</td>
                  <td><img src="../images/layout/qt_01.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                        <div class="ui-layout-west">左侧栏</div>
                        <div id="mainContent" class="ui-layout-center" >
                          <div class="ui-layout-center">
                            嵌套-上
                          </div>
                          <div class="ui-layout-south">
                            嵌套-下
                          </div>
                        </div>
                      </pre>                      
                  </td>
                </tr>
                <tr>
                  <td>嵌套布局-横向</td>
                  <td><img src="../images/layout/qt_02.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                        <div class="ui-layout-west">左侧栏</div>
                        <div id="mainContent" class="ui-layout-center" >
                          <div class="ui-layout-west">
                            嵌套-左
                          </div>
                          <div class="ui-layout-center">
                            嵌套-右
                          </div>
                        </div>
                      </pre>                      
                  </td>
                </tr>
                <tr>
                  <td>嵌套布局-iframe</td>
                  <td><img src="../images/layout/qt_03.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">
                          头部区
                        </div>
                        <div class="ui-layout-west">    
                          <iframe src="" frameborder="0" class="ui-layout-content"></iframe>
                        </div>
                        <div id="mainContent" class="ui-layout-center" >
                          <div class="ui-layout-center" style = 'overflow:hidden;'>
                            <iframe src="" frameborder="0" class="ui-layout-content"></iframe>        
                          </div>
                          <div class="ui-layout-south">
                            <iframe src="" frameborder="0" class="ui-layout-content"></iframe>
                          </div>
                        </div>
                      </pre>                       
                  </td>
                </tr>
                <tr>
                  <td rowspan="3">自适应布局</td>
                  <td>主体自适应</td>
                  <td><img src="../images/layout/zsy_01.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                          <div class="ui-layout-center">
                            <div id = 'toolbar' class = 'yhToolbar'>    
                            </div>
                            <div class="ui-layout-content">
                              ......
                            </div>
                          </div>
                      </pre>                      
                  </td>
                </tr>
                <tr>
                  <td>表格自适应</td>
                  <td><img src="../images/layout/zsy_02.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                          <div class = "ui-layout-west">
                              tree...
                          </div>
                          <div id="mainContent" class="ui-layout-center" >
                            <div class="ui-layout-north">
                              form...
                              <div id = 'toolbar' class = 'yhToolbar'></div>
                            </div>  
                            <div class="ui-layout-center">    
                                <table id="list"></table>
                                <div id="pager"></div>  
                            </div>
                          </div>
                      </pre>                      
                  </td>
                </tr>
                <tr>
                  <td>局部自适应</td>
                  <td><img src="../images/layout/zsy_02.gif" alt=""></td>
                  <td>
                      <pre class="brush:js">
                        <div class="yhui-header ui-layout-north ui-helper-clearfix">头部区</div>
                        <div id="mainContent" class="ui-layout-center" >
                          <div class="ui-layout-center">
                            <div id = 'toolbar' class = 'yhToolbar'>        
                            </div>
                            <div class="ui-layout-content">
                              ......
                            </div>
                          </div>
                          <div class="ui-layout-south">
                            <div id = 'toolbar1' class = 'yhToolbar'>       
                            </div>
                            <div class="ui-layout-content">
                              ......
                            </div>      
                          </div>
                        </div>
                      </pre>                      
                  </td>
                </tr>
              </table>
            </div> 
            <h2>属性</h2>
            <div class="panel">          
              <table class="infotable">
                    <tr>
                      <th>属性</th>
                      <th >描述</th>
                      <th >值</th>
                      <th >默认值</th>
                    </tr>
                    <tr>
                      <td><a href="#closable">closable</a></td>
                      <td>pane是否可以关闭。设置该属性为false时，面板关闭按钮不可见，可拖拽调整尺寸。</td>
                      <td>布尔值。true；false</td>
                      <td>true。具有关闭按钮。</td>
                    </tr>
                      <tr>
                        <td><a href="#initClosed">initClosed</a></td>
                        <td>初始化时是否关闭 pane 。true时，初始面板关闭（即尺寸为0）。</td>
                        <td>布尔值。true;false</td>
                        <td>false。不关闭面板。</td>
                      </tr>
                      <tr>
                        <td><a href="#maxSize">maxSize</a></td>
                        <td>面板可拖动时，能到达的最大尺寸。js中写数值即可，无需写单位。</td>
                        <td>数值，单位 &quot;px&quot;。可自定义。</td>
                        <td>未定义</td>
                      </tr>
                      <tr>
                        <td><a href="#minSize">minSize</a></td>
                        <td>面板可拖动时，能到达的最小尺寸。</td>
                        <td>数值，单位 &quot;px&quot;。可自定义</td>
                        <td>未定义</td>
                      </tr>
                      <tr>
                        <td><a href="#resizable">resizable</a></td>
                        <td>pane 是否可以拖动改变大小。</td>
                        <td>布尔值。true;false</td>
                        <td>true。可以改变尺寸。</td>
                      </tr>
                        <tr>
                          <td><a href="#size">size</a></td>
                          <td>面板大小。js中写数值即可，无需写单位。</td>
                          <td>数值。自定义</td>
                          <td>240px</td>
                        </tr>

                        <tr>
                          <td><a href="#slidable">slidable</a></td>
                          <td>是否可以滑动面板。即鼠标移到触发面板展开，移开自动关闭。</td>
                          <td>布尔值。true;false</td>
                          <td>默认值 true，可以滑动。</td>
                        </tr>

                        <tr>
                          <td><a href="#spacing_closed">spacing_closed</a></td>
                          <td>面板closed 时，伸缩栏spacing 的尺寸。</td>
                          <td>数值，单位 &quot;px&quot;。自定义</td>
                          <td>默认值 8 。</td>
                        </tr>

                        <tr>
                          <td><a href="#spacing_open">spacing_open</a></td>
                          <td>面板open时，伸缩栏spacing 的尺寸。</td>
                          <td>数值，单位 &quot;px&quot;。自定义</td>
                          <td>默认值 8 。</td>
                        </tr>

                      <tr>
                        <td><a href="#togglerLength_closed">togglerLength_closed</a></td>
                        <td>面板closed 时，toggler 按钮的长度。</td>
                        <td>数值，单位 &quot;px&quot;。自定义</td>
                        <td>默认值，上下伸缩按钮 64px，左右伸缩按钮 54px 。</td>
                      </tr>
                      <tr>
                        <td><a href="#togglerLength_open">togglerLength_open</a></td>
                        <td>面板open 时，toggler 按钮的长度。</td>
                        <td>数值，单位 &quot;px&quot;。自定义</td>
                        <td>默认值，上下伸缩按钮 64px，左右伸缩按钮 54px 。</td>
                      </tr>
                      </table>
                      <p >注意：含spacing、toggler的属性是针对拖动栏。其他属性是对面板有效。</p>
                      <div class="panel2">                        
                            <pre class="brush:js">
                                $(document.body).yhLayout({ 
                                  west: {
                                        closable: false,     // 左侧面板不可关闭
                                        initClosed: false,   // 左侧面板初始化就是打开的
                                        maxSize: 300,       // 左侧面板最大 300px
                                        minSize: 100,       // 左侧面板最大 100px
                                        resizable: true,    // 左侧面板可以拖动改变大小
                                        size: 200,        // 左侧面板 size 为 200px
                                        slidable: false,    // 左侧面板没有滑动效果
                                    }
                                });
                            </pre>
                        </div>
                </div>
                    


            <h2>方法</h2>
            
            <div class="panel">                    
                    <table class="infotable">
                      <tr>
                        <th width="173">属性</th>
                        <th width="451">描述</th>
                        <th width="451">使用</th>
                      </tr>
                      <tr>
                        <td>close( pane )</td>
                        <td width="451">关闭指定的 pane 。<br>
                          一个参数，字符串，表示 pane，如 north、west、south、east 。<br>
                          无返回值。
                        </td>
                        <td>
                            <pre class="brush:js">
                                <button>关闭</button>
                                // js
                                var $body = $( document.body ).yhLayout();
                                $("button").on( "click", function() {
                                    $body.yhLayout( "close", "west" );      //  点击按钮关闭左侧面板
                                });
                            </pre>
                        </td>
                      </tr>
                      <tr>
                        <td>open( pane )</td>
                        <td width="451">打开指定的 pane 。<br>
                          一个参数，字符串，表示 pane，如 north、west、south、east 。<br>
                          无返回值。</td>
                        <td>
                            <pre class="brush:js">
                                <button>打开</button>
                                // js
                                var $body = $( document.body ).yhLayout();
                                $("button").on( "click", function() {
                                    $body.yhLayout( "open", "west" );      //  点击按钮关闭左侧面板
                                });
                            </pre>
                        </td>
                      </tr>
                      <tr>
                        <td>toggle( pane )</td>
                        <td width="451">打开指定的 pane 。<br>
                          一个参数，字符串，表示 pane，如 north、west、south、east 。<br>
                          无返回值。</td>
                        <td>
                            <pre class="brush:js">
                                <button>切换</button>
                                // js
                                var $body = $( document.body ).yhLayout();
                                $("button").on( "click", function() {
                                    $body.yhLayout( "toggle", "west" );      //  点击切换左侧面板的开关状态
                                });
                            </pre>
                        </td>
                      </tr>
                    </table>
            </div>

            <h2>回调函数</h2>
            <div class="panel">
                <table class="infotable">
                  <tr>
                    <th width="173">回调函数</th>
                    <th width="451">描述</th>
                    <th width="118">使用</th>
                  </tr>
                  <tr>
                    <td>onresize</td>
                    <td width="451">onresize，在面板大小改变后运行这个函数。<br>
                      这个回调多用在计算各组件的尺寸，使之高宽自适应。<br>
                      理论上所有的面板都有这个回调，但是我们只需要给 center 绑定就可以了。</td>
                    <td >
                        <pre class="brush:js">
                            // 假如页面上有手风琴面板
                            var $a = $("#accordion").accordion({
                                        heightStyle: "fill"
                                    });
                            $( document.body ).yhLayout({
                                center: {
                                    onresize: function() {  // 高宽改变时执行
                                        $a.accordion( "refresh" );  // 刷新手风琴面板
                                    }
                                }
                            });
                        </pre>
                    </td>
                  </tr>
                </table>
            </div>
    </div>
</div>
    <script type="text/javascript">
        SyntaxHighlighter.defaults["toolbar"] = false;
        SyntaxHighlighter.all();
    </script>
</body>
</html>