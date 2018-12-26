<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
         String path = request.getContextPath();
         String basePath = request.getScheme() + "://"
                            + request.getServerName() + ":" + request.getServerPort()
                            + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html> 
<head>
<base href="<%=basePath%>">
<title>My JSP 'success.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!-- 下面是css和各种js的引用（注意：不要将css和js源文件放入WEB-INF中 -->
<!-- 否则会无法识别,很蛋疼的东西啊）-->
<link rel="stylesheet" href="pages/css/demo.css" type="text/css">
<link rel="stylesheet" href="pages/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="pages/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="pages/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="pages/js/jquery.ztree.exhide-3.5.js"></script>
<SCRIPT type="text/javascript">
         //下面开始进入复制阶段
         var setting = {
                            data : {
                                     key : {
                                               title : "title"
                                     },
                                     simpleData : {
                                               enable : true
                                     }
                            }
                   };
         function setTitle(node) {
                   var zTree = $.fn.zTree.getZTreeObj("treeDemo");
                   var nodes = node ? [ node ] : zTree.transformToArray(zTree.getNodes());
                   for ( var i = 0, l = nodes.length; i < l; i++) {
                            var n = nodes[i];
                            n.title = "[" + n.id + "] isFirstNode = " + n.isFirstNode
                                               + ", isLastNode = " + n.isLastNode;
                            zTree.updateNode(n);
                   }
         }
         function count() {
                   var zTree = $.fn.zTree.getZTreeObj("treeDemo"), hiddenCount = zTree
                                     .getNodesByParam("isHidden", true).length;
                   $("#hiddenCount").text(hiddenCount);
         }
         function showNodes() {
                   var zTree = $.fn.zTree.getZTreeObj("treeDemo"), nodes = zTree
                                     .getNodesByParam("isHidden", true);
                   zTree.showNodes(nodes);
                   setTitle();
                   count();
         }
         function hideNodes() {
                   var zTree = $.fn.zTree.getZTreeObj("treeDemo"), nodes = zTree
                                     .getSelectedNodes();
                   if (nodes.length == 0) {
                            alert("请至少选择一个节点");
                            return;
                   }
                   zTree.hideNodes(nodes);
                   setTitle();
                   count();
         }
         //以上可以直接复制，有兴趣的可以参考zTree文档进行研究
         //从后台读取数据用来保存结点的数组
         var treeNodes = [];
         //一切准备好后初始化树
                   $(document).ready(function() {
                   //初始化zNodes数组——treeNodes
                   $(function() {
                            //从后台获取json串的连接
                            var url = "http://localhost:8080/InspurUser/JsonRightServlet";
                            //right是从session获取并保存在jsp页面body中的一个hidden标签中
                            var right = document.getElementById("right").value;
                            $.ajax({
                                     url : url,
                                     type : 'post',
                                     //这个是传到后台的数据，后台就是根据它获取zTree结点信息的，它是一个json格式的串
                                     data : {right : right},
                                     async : false,
                                     success : function(data) {
                                               //这个data是ajax传回的数据一个json串
                                               /*
                                               json串={"right":[{"id":"1","isHidden":0,"name":"公司","open":1,"pId":"0","target":"","title":"","url":""},
                                                               {"id":"11","isHidden":0,"name":"超级管理员","open":0,"pId":"1","target":"mainF","title":"","url":""},
                                                               {"id":"111","isHidden":0,"name":"显示报表","open":0,"pId":"11","target":"mainF","title":"","url":"http://localhost:8080/InspurUser/chart/index.jsp"},
                                                               {"id":"112","isHidden":0,"name":"管理用户","open":0,"pId":"11","target":"mainF","title":"","url":"http://localhost:8080/InspurUser/DirectTo?method=toUserManager"}]}
                                               */
                                               var msg = eval('(' + data + ')');
                                               //非常强大的遍历函数
                                               $.each(msg, function(i, item) {
                                                        //此处i=right
                                                        //item是json串的后半部分
                                                        $.each(item,function(ii,iit){//遍历json数据（对我们有用的——树的节点的所有信息）
                                                                 treeNodes.push({"id":iit.id,"name":iit.name,"pId":iit.pId,"url":iit.url,"target":iit.target});
                                                        });
                                               });
                                     }
                            });
                   });
                   //一下是初始化zTree的函数，可以直接复制，
                   //但$("#treeDemo")中的treeDemo是要存放zTree的div的id
                   $.fn.zTree.init($("#treeDemo"), setting, treeNodes);
                   $("#hideNodesBtn").bind("click", {
                            type : "rename"
                   }, hideNodes);
                   $("#showNodesBtn").bind("click", {
                            type : "icon"
                   }, showNodes);
                   setTitle();
                   count();
         });
</script>
</head>
<body background="img/back.jpg">
         <div>
                   <table width="100%" height="100%">
                            <tr height="10%">
                                     <td colspan="2"><marquee direction="right">
                                                        <font color="#00FFFF" size="30px">浪潮内训图表</font>
                                               </marquee></td>
                            </tr>
                            <tr>
                                     <td rowspan="2" width="20%">
                                      <%--
                                               这就是要摆放zTree的地方
                                               --%>
                                               <div>
                                                        <ul id="treeDemo" class="ztree"></ul>
                                               </div>
                                               <%--
                                               这就是存放权限right的hidden标签，在穿到后面的时候用到
                                               --%>
                                               <input type="hidden" name="right" id="right"
                                               value="${sessionScope.user.right }"></td>
                                     <td width="1000px" height="530px"
                                               style="padding: 0px;text-align: center;"><iframe src=""
                                                        width="100%" height="100%" frameborder="0" name="mainF"
                                                        scrolling="auto" style="margin: 0px;"></iframe></td>
                            </tr>
                   </table>
         </div>
</body>
</html>