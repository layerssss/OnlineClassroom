<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeBehind="Msg.aspx.cs" Inherits="LCourse.User.Msg" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/theme/jquery-ui-1.8.6.custom.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.6.custom.min.js" type="text/javascript"></script>
    <script src="../Scripts/JScript.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function haha() {
            $.ajax({
                "url": location.href + "&delete=yes&time=" + escape((new Date()).getTime()),
                "dateType": "text",
                "success": function () {
                }
            });
        }
        function haha1() {
        haha();haha = function () { };
        }
        $(function () { $("body").hover(haha1); });
    </script>
    <style type="text/css">
        .widget
        {
            padding-top:0px;
            padding-bottom:10px;
        }
        #WidgetPanel1
        {
            overflow:scroll;
            height:120px;
        }
    </style>
</head>
<body >
    <form id="form1" runat="server">
    <div>
        <cc1:WidgetPanel ID="WidgetPanel1" ClientIDMode="Static" runat="server">
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        </cc1:WidgetPanel>
        <cc1:WidgetPanel ID="WidgetPanel2" runat="server">
            <asp:TextBox ID="TextBox1" runat="server" Height="180px" TextMode="MultiLine" 
                Width="98%"></asp:TextBox>
            <br />
            <asp:LinkButton ID="LinkButton1"
                runat="server" CssClass="button" onclick="LinkButton1_Click">发送</asp:LinkButton><a href="#" class="button" onclick="javascript:window.close()">关闭</a><asp:HiddenField 
                ID="HiddenField1" runat="server" />
                <br />
                <br />
                <br />
        </cc1:WidgetPanel>
    </div>
    </form>
</body>
</html>
