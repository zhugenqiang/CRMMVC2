﻿<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage<CRM.Model.bas_dict>" %>

<%@ Import Namespace="CRM.Web.Controllers" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Index</title>
    <link href="../../Styles/Shared/Shared.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/Shared/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="../../Scripts/Shared/Shared.js" type="text/javascript"></script>
</head>
<body>
    <!--标题部分-->
    <div id="divTitle">
        <span class="title">数据字典管理</span><br />
        <hr />
    </div>
    <div id="divTitleH">
    </div>
    <!--标题部分结束-->
    <%Html.BeginForm("Index", "DataDictManager", FormMethod.Post, new { id = "form1" }); %>
    <!--表头操作部分-->
    <div id="divListTop">
        <input type="button" onclick="javascript:window.location.href='<%=Url.Action("Add") %>'"
            class="transparent button" value="添加" />
        <input type="submit" class="transparent button" value="查询" />
    </div>
    <!--搜索条件部分-->
    <div class="divTable3">
        <table cellpadding="0" cellspacing="0">
            <tr>
                <th>
                    类别
                </th>
                <td>
                    <input name="dict_type" value='<%=Model.dict_type %>' type="text" class="text" />
                </td>
                <th>
                    条目
                </th>
                <td>
                    <input name="dict_item" value='<%=Model.dict_item %>' type="text" class="text" />
                </td>
                <th>
                    值
                </th>
                <td>
                    <input name="dict_value" value='<%=Model.dict_value %>' type="text" class="text" />
                </td>
            </tr>
        </table>
    </div>
    <!--列表部分-->
    <div id="divList">
        <% PageHelper<CRM.Model.bas_dict> pagerHelper = ViewData["pagerHelper"] as PageHelper<CRM.Model.bas_dict>;
           if (pagerHelper.TotalCount == 0)
           {
        %>
        <!--没有任何数据-->
        <div class="nodata">
        </div>
        <%
           }
           else
           {
        %>
        <!--数据列表-->
        <table cellpadding="0" cellspacing="0">
            <tr class="tblHead">
                <th>
                    序号
                </th>
                <th>
                    类别
                </th>
                <th>
                    条目
                </th>
                <th>
                    值
                </th>
                <th>
                    允许编辑
                </th>
                <th>
                    操作
                </th>
            </tr>
            <%
               int index = 1;
               foreach (var item in pagerHelper)
               {
            %>
            <tr class="tblItem">
                <td>
                    <%=index++ %>
                </td>
                <td>
                    <%=Html.Encode(item.dict_type) %>
                </td>
                <td>
                    <%=Html.Encode(item.dict_item) %>
                </td>
                <td>
                    <%=Html.Encode(item.dict_value) %>
                </td>
                <td>
                    <%=Html.Encode(item.dict_is_editable==1?"√":"×") %>
                </td>
                <td>
                    <a href='<%=Url.Action("Update") %>/<%=Html.Encode(item.dict_id) %>'>
                        <img src="../../Images/ico/bt_edit.gif" title="编辑" class="imgLink" />
                    </a>
                    <a href='<%=Url.Action("Delete") %>/<%=Html.Encode(item.dict_id) %>'>
                        <img src="../../Images/ico/bt_del.gif" title="删除" class="imgLink" />
                    </a>
                </td>
            </tr>
            <%
               }
            %>
        </table>
        <%  } %>
    </div>
    <!--分页部分-->
    <div id="divPager">
        <input type="hidden" id="inputCurPage" name="curPage" value="0" />
        <%=pagerHelper.PagerHtmlA %>
    </div>
</body>
</html>
