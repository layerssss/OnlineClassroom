<%@ Page Title="实时讨论" Language="C#" MasterPageFile="~/MasterPages/Board.master" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="LCourse.Board.Chat" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
<style type="text/css">
#panelContent
{
    height:310px;
    overflow:scroll;
}
#textSend
{
    width:600px;
    height:26px;
}
#butSend
{
    width:120px;
    height:26px;
    vertical-align:bottom;
}
#textLID
{
    display:none;
}
</style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="panelContent" ClientIDMode="Static" runat="server" Text="消息历史(双击清屏)" >
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="panelSend" runat="server" Text="发送消息">
    <input type="text" id="textSend" />
    <input type="submit" value="发言(Enter)" id="butSend" />
    </cc1:WidgetPanel>
    <asp:TextBox ID="textLID" ClientIDMode="Static" runat="server"></asp:TextBox>
    <script type="text/javascript" language="javascript">
        onlineListAtChat = true;
        $(function () {
            $(".notNeat").hide();
            $("#main").css("margin-left", 10);
            $("#panelContent").parent().dblclick(function () {
                $("#panelContent").html("消息历史已清空……<br/>");
            });
            chatPing();
            sizeChange();
            $("#form1").submit(chatSend);
        });
        function chatSend() {
            $("#textSend").attr("disabled", "disabled");
            $("#butSend").attr("disabled", "disabled").val("正在发送……");
            $.ajax({
                "type": "POST",
                "url": "ChatSend.aspx",
                "dataType": "text",
                "data": {
                    "lid": $("#textLID").val(),
                    "content": $("#textSend").val()
                },
                "success": function (data) {
                    if (data == "SUCCESS") {
                        $("#textSend").removeAttr("disabled");
                        $("#butSend").removeAttr("disabled").val("发送(Enter)");
                        $("#textSend").val("").trigger("focus");
                    }
                    else {
                        msgBox(data, null, "消息发送失败");
                    }
                }
            });
            return false;
        }
        function chatPing() {
            $.ajax({
                "url": "ChatPing.aspx?lid=" + $("#textLID").val() + "&time=" + escape((new Date()).getTime()),
                "dataType": "json",
                "success": function (json) {
                    if (json.msg) {
                        $("#panelContent").html(json.msg + "<br/>" + $("#panelContent").html());
                        setTimeout("chatPing();", 200);
                    } else {
                        setTimeout("chatPing();", 500);
                    }
                },
                "error": function () {
                    msgBox("发生错误。", function () { location.href = "chat.aspx"; }, "错误");
                }
            });
        }
    </script>
</asp:Content>
