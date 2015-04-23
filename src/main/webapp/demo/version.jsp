<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset = "UTF-8">
    <title>b版本说明</title>
    <style type = "text/css">
        span { font-family: 'Courier New', serif, sans-serif; font-size: 10pt; color: #000000; }
        a { color: #dc143c; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
    <script type = "text/javascript" src = "js/base/yhHead.js"></script>
    <script type = "text/javascript">
        var h;
        if ( parent && ( h = parent.Homepage ) ) {
            YHUI.use( "jquery", function() {
                $( document ).on( "click", "a", function(e) {
                    e.preventDefault();
                    h.tabs.yhTabs( "addTab", $(this), $( this ).attr( "href" ) );
                })
            } );
       }
    </script>
</head>
<body>
<div style = "float: left; white-space: pre; line-height: 1; background: #FFFFFF; "><span class = "sc0">
    yhui 1.3.0 beta 20130422


    1. yhHead js 加载器的进一步优化。现在自动探测路径，无需做过多配置。

    2. 所有的页面全部转为 jsp ，和开发组深度契合。

    3. 选项卡优化。加入属性 level ，选项卡嵌套时可以应用不同样式，易于区分。

    4. 新组件 yhLoading ，非常易于使。

    5. 新组件 yhSelectmenu ，直接作用于 select 元素的下拉框。

    6. 新组件 yhTreemenu ，开合式树形菜单。

    7. 新组件 yhPlaceholder ，在所有浏览器中实现 placeholder 效果。

    8. yhValidate 全面重构，更易使用，更好的体验。

    9. 优化右键菜单 (yhContextMenu) ，增加事件控制。

    10. 增强并美化 yhDialogTip 。

    11. yhui 1.3 的重头戏，表格组件全面实例化 —— jqGrid 。







    yhui 1.2.1 20130131

    1. yhui 的 <a href = "manual/docx/index.html">文档</a> 全面改版。

    2. 优化 yhHead。
        a. 优化 js 的依赖算法。

    3. 优化yhLayout。
        a. 进一步删除 yhui 自身拓展的代码，精简结构。
        b. 方法调用统一为传入字符串形式，不再支持传统调用模式。

    4. 优化 datepikcer 。
        a. 代码重构。
        b. 修复 1.2 中的 bug 。
        c. 提升用户体验。

    5. 修复 yhDropDown 中的 bug 。

    6. 修复 yhMenu 中的 bug 。

    7. 修复 yhPortlet 中的 bug 。

    8. 修复“用户角色”的 bug 。





    YHUI 正式版 1.2 20121224

    从 1.0 发布到现在已经有四个月了，感谢大家对YHUI的支持。
    四个越来发布了不少 1.0 的小版本，用以修复已知的 bug ，YHUI 当然不会止步于修复 bug 。
    时隔四个月 1.2 发布：
    
    1. 核心 jquery、jqueryui、ztree 分别升级到 1.8.3、1.9.2、3.4 。
    
    2. 全面规范样式表。
        a. 规范命名，以前杂乱无章 规范为现在的 "yhui-(组件名)-(特定区域)" 的形式。
        b. 合并并压缩css。 项目组只用引入 yhui-structure.css 和 yhui-skin.css 两个文件。
        c. 为特定浏览器加样式，以前使用 "_"、"*" 这些不标准的符号，规范为浏览器嗅探。
            比如以前给 IE6 加样式是加 "_"，现在， ".yhui-ie6"。
    
    3. 优化换肤机制。
        a. 换肤代码单独成一个模块。
        b. 修复 IE6 中不能换肤的 bug 。
    
    4. 重构 js 加载器。
        a. 由以前的 yhLab 更名为 yhHead 。
        b. js 加载过程不再是阻塞的，而是并行加载，顺序执行，最大化加载速度的同时，保证依赖的正确性。
        c. 强化自定义配置系统，不再需要进入源码配置。
    
    5. 优化 yhTabs。
        a. 提供 add 方法，让大家<a href="Components/yhTabsPlain.html">一句代码添加选项卡</a>。
        b. 调整标题气泡提示的位置。
        c. 如果 500ms 内加载页面完成，不出现 loading 覆盖层。
    
    6. 优化 yhLayout 。
        a. 剔除以前版本中 upDown 这些让人疑惑的 API， 统一为 yhLayout()。
        b. 代码量由先前的 300+ 行减少到 50 行。

    7. 新组件 yhContextMenu，<a href = "Components/yhContextMenu.html">右键菜单</a>。
        a. yhui 所有使用右键菜单的地方都是用 yhContextMenu。

    8. 新组件 yhValidate，<a href = "form/yhValidate.html">验证</a>。
        a. 为公司各项目组量身打造，基本涵盖所有需要表单验证的情况。
        b. 针对 yhDropDown 和 yhDatePicker 做过特别处理，三者无缝集成。

    9. 新组件 yhDatePicker，<a href = "form/yhDatePicker.html">日期时间选择器</a>。
        a. jqueryui 的日期选择器太大太杂、使用太不方便了。
        b. 该组件应该是面前市面上同类组件中最漂亮的，感谢设计曾锐。

    10. 新组件 yhSearchBox，<a href = "Components/yhSearchBox.html">搜索框</a>。
        a. 可以过滤 zTree 的节点。
        b. 以后慢慢扩充功能，使之达到万能搜索框的状态。

    11. 重构 yhPortlet，<a href = "Components/yhPortlet.html">页面构件</a>。
        a. 自动适应一到三列的布局。
        b. 自定义 弹窗、关闭、折叠 按钮。
        c. 提供 获取位置 的方法，方便保存各面板的位置。

    12. 重构 yhDropDown， <a href = "form/yhDropDown.html">下拉框</a>。
        a. 使用最多、也是诟病最多的组件。
        b. 点击 箭头 才构建下拉树，避免以前一次构建十多个树而让页面加载太慢。
        c. 优化 联动 机制。现在只需 几句代码 就可以做出联动的下拉框。
        d. 优化 onClick 回调。
            ▲ 扩充 onClick 回调函数中的参数属性，新增 input 和 hidden 表示当前文本框和隐藏域。
            ▲ 返回值为 false 时，阻止 click 的默认行为，也就是不会给 input 和 hidden 赋值。
            两者都是为了更好的自定义下拉框的值。
        e. 修复 IE6 中下拉框没有宽度限制的 bug 。

    13. 修复 <a href="Components/yhMenu.html">yhMenu</a> 一闪即逝的 bug 。



YHUI 正式版1.13 20121129

1. 下拉框。
    a. 修复IE6中下拉div没有宽度限制的问题。

2. 重构portlet。

3. $.address在IE6、7中因报错而禁用。

4. 修复validateEngine(验证插件)提示气泡的错位问题。

5. yhCore 增加方法 getUserInfo，以便快速方便的或得用户浏览器类型、版本和屏幕分辨率的信息。

6. 增加在线文档。



YHUI 正式版1.12.2 bug修复版

1. 修复yhLayout。
    a. 在IE6在页面崩溃的bug。

2. 修复yhFormField。
    a. 验证模块， 提示框在IE6、7下被覆盖的bug。

3. 修复yhDropDown。
    a. 修复下拉div被覆盖的bug。
    b. 修复单选模式下，点击“请选择”时，隐藏域的值不变的bug。
    c. IE6下，“全选”、“全不选”按钮没有图片的bug。

4. 优化样式表，将所有注释改为英文，避免IE6中出现部分样式失效的问题。

5. 优化yhToolbar。
    a. 重新组织yhToolbar的代码。
    b. 新增customDom属性，用以自定义dom结构。

6. 优化yhLayout。
    a. 优化API。
        剔除什么upDown、upCenterDown之类的让人头昏眼花的API，
        现在直接在目标元素上布局，比如$("div").yhLayout()。
    b. 仍旧兼容upDown等方法调用，但是不建议使用，以后的版本会逐步移除。    
    
7. 新增组件yhContextMenu，删除插件jquery.contextmenu.js。
    a. yhTabs、yhWindow、jqGrid 的右键代码更新为调用 yhContextMenu。
    



YHUI 正式版1.12.1 bug修复版 20120927

1. 修复yhLayout没有返回值的bug。

2. 修复yhDropDown:
    a. hack IE9中hover增高的bug。
    b. hack IE8中maxHeight的bug。
    c. hack IE7、8下单选模式点击出现滚动条的bug。
    d. 修复文本框中的字体在部分机器上的部分IE中偏大的bug。

3. 优化yhWindow。
    a. 拖拽时提供一个拖拽助手选项。

4. 修复yhSwitchPanel:
    a. 自动加载iframe时，重复调用 showHeader 方法不执行iframe中的方法bug。



YHUI 正式版1.12 20120925

1. 优化yhDropDown。
    a. 修复设置下拉div的高宽无效的bug。
    b. 以更好的方式解决IE9中的自适应高度bug。
    c. 取消zIndex属性，因为从根本上解决了覆盖与被覆盖的问题。
    d. 单选列表添加“请选择”项。
    e. 多选列表和多选树添加“全选”和“全不选”按钮。
    f. 修复联动时传入 url 不执行的bug。
    g. 树形单选下拉框添加“自动完成”功能。
    h. 重新组织了yhDropDown的代码，使得绑定事件与初始化dom结构分离。
    
2. 修复yhTabs。
    a. 服务质量中部分页面不能加载出的bug。

3. 优化yhSwitchPanel。
    a. "showHeader"方法中添加回调，以便在自动加载iframe的过程中iframe加载完成时处理代码。
    b. 新增事件"iframeLoaded"，组件自动加载iframe的面板时，iframe加载完成触发此事件。

4. 优化yhLayout。
    a. 新增内嵌布局类型Left-UpDown。

         

YHUI 正式版1.11  20120917

1. 优化yhDropDown。
    a. 增加showPath属性，将父子节点显示成路径形式。
    b. 增加simpleData属性，可以将简单数据打印成节点。
    c. 增加type属性，异步请求的方式可以自定义为"get"或者"post"。
    d. 代码做了精简。

2. 优化yhFormField的验证模块。
    a. 添加了更为简洁的自定义验证规则的方法。
    b. 除了直接在dom中设置属性，可以完全用js控制验证。
    c. 增加了新页面 form/yhValidate.html，详细的介绍了各种需要验证的情况。

3. 修复yhButton在没有设置 "onClick" 属性时，单击按钮报错的bug。

4. yhWindow。
    a. 修复在showTaskBar为false的情况下最大化时出错的bug。

5. yhTabs。
    a. 修复 在选项卡中打开一个新选项卡，再次单击时不能跳转到对应选项卡的bug。

6. yhFormField。
    a. 验证模块可以自定义出错提示语。

    

YHUI 正式版1.10  20120907    ！！里程碑版本

1. 优化yhButton。按钮位置可以微调。

2. 优化yhDropDown。
    a. 可以控制input的宽度。
    b. 键盘上的“左右”键可控。

3. 优化yhMenu。
    a. 添加回调 beforeInit。
    b. 可以直接使用本地数据初始化菜单。
    c. 异步获取的数据也可以先操作所获得的数据，再初始化树。
    
4. 优化yhToolbar。
    a. 增加方法“enable”和“disable”。    
    b. 修复toolbar插件中该死的bug。
    
5. 重新编写了yhLayout的代码。
    a. 使之更适合做内嵌式地布局.
    b. 新增两个内嵌布局的实例页面。

6. 优化了yhWindow。
    a. 可以自定义是否出现Taskbar。
    b. 完善窗口的销毁过程，避免内存泄露。
    c. 新增一次性窗口实例，让后台的弹窗 插删改 更易实现。

7. 完善jqGrid。
    a. 实现jqGrid自定义的增删查改。
    b. 自定义表单域查询。
    
8. 修复 yhDialogTip 点关闭时也执行回调函数的bug。

9. 优化yhFormField。
    a. 验证错误气泡的位置可以控制的正底部。


10. YHUI 1.10 最大变化：
    a. 所有后台处理全都改由servlet。
    b. 所有前后端交互全部都由AJAX实现。
    



YHUI 正式版1.04 2012 08 24

1. yhTabs 选项卡添加tooltip取代以往的title提示。

2. 再次修复橙色皮肤出错样式。

3. 新增组件yhSelector，即左右互选。

4. 优化下拉框。增加异步请求出错提示。

5. zTree替换到最新的3.3。


YHUI 正式版1.03 2012 08 21

1. 修复橙色皮肤出错样式。

2. 新增组件yhSwitchPanel，可开关面板。区别于手风琴，本组件所有面板可同时展开。

3. 进一步增强左树与选项卡的联系。添加和删除选卡，随着焦点的不同，在左树中都有体现。


YHUI 正式版1.02 2012 08 15

1. 橙色皮肤一套，不解释。

2. 优化yhTabs。
    a. 精简代码。
    b. 可以将某个选项卡添加进收藏夹。
    
3. 表单验证。
    a. 调整提示气泡的位置。
    b. 新增自定义的电话号码验证实例。
    c. 新增“是否存在用户名的AJAX”验证。

4. 调整了菜单的动画时间，以防同时出现两个下一级菜单。

5. 调整若干地方的样式。


YHUI 正式版1.0 2012 08 09
    
    YHUI正式版终于出炉了。
    
    首先感谢服务质量的兄弟对YHUI的支持，正因为他们的不断地尝试和测试，YHUI才会慢慢变好。
    
    相比测试版，YHUI可以说是从头到位地重构了一遍，使其性能更好、代码更简练健壮，更易拓展，也更容易使用。
    
    下面就是YHUI1.0的几个重要变化。
    
    1. 核心换成 jQueryUI 1.9 beta + jqGrid + zTree，感谢各组件作者，有你们和你们的开源代码，生活很美好。
    
    2. 重构yhTabs，继承自jQueryUI的tabs。
        a. 提供API，使得单击任意元素都能添加选项卡。
        b. 提供API，刷新当前选项卡。
        c. 控制浏览器的前进和后退按钮，当然，也可以选择不控制。
        d. 刷新后，自动打开上一次最后选中的选项卡。

    3. 重构yhMenu。昱辉菜单现在是动态打印，初始化时只打印第一层节点，鼠标放上去才打印第二级节点。海量数据，轻松打印。
    
    4. 重构yhWindow。继承自jQueryUI的dialog。
    
    5. 重构昱辉下拉框。
        a. 原先的接受json格式数据变更为接受“链接”，所有的AJAX操作都在yhDropDown的内部完成。
        b. 加载数据时，增加“转圈圈效果”。
        c. 下拉框的高度在200px以下自适应，超过两百则出现滚动条。
        d. 添加“dropHidden”回调，关闭下拉框时触发。
    
    6. 重构yhLayout。我相信对后台来说，这是最美妙的重构。
        a. 兼容测试版时的API。
        b. 新增自定义布局的API，从而可以轻松的打造自适应的表单布局、jqGrid等等页面。
        c. 基于yhLayout，重构了jqGrid的插删改实例。现在只需简单套用就可彻底解决大小自适应的烦恼，没有比这个更简单了。
    
    7. 新增yhToolbar，由插件改装而来，但是比原插件更易使用，更符合YHUI的风格。
    
    8. 新增yhButton。没有最简单，只有更简单。模仿yhToolbar的风格，只需传参就能轻松定制按钮和绑定事件。
    
    9. 重构yhDatePicker。
        a. 有时间选择器。
        b. 有日期选择器。
        c. 有时间日期选择器。
        d. 有 yhDatePikcer，轻松搞定范围日期的选择。这点和测试版相比，变动较大，当然，没使用过测试版的无压力。
    
    10. 新增spinner（数字微调），相信服务质量的四点归一深有感触，数字微调不可少啊。
    
    11. 看了上面一大串表单组件，相信大家觉得繁琐，不要怕，“ yhFormField ” 也重构了，以前忽视了这块，现在一并补上。
         a. 表单布局与具体的表单初始化以及表单验证合而为一。
            没有看错，现在只需设置属性，就可以一次搞定表单的布局、表单组件的初始化以及表单的验证。
         b. 配合重构的yhLayout和yhToolbar以及高性能的jqGird，轻轻松松打造ajax増删查改。 
         c. 目前为止，yhDropDown的初始化还要单独进行，因为，它太复杂了。

    12. 正式版最大的变动是，js加载器。
            现在只用引入一个小小（不到10k，压缩后更小）的yhLab.js，其他的js按需加载。
            当然，这和以往的js模式完全不同，但是要简单，相信大家能很快上手并且爱不释手。
            </span></div>
</body>
</html>
