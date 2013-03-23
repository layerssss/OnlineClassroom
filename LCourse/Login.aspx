<%@ Page Title="用户登录" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="LCourse.Login" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainPlaceHolder" runat="server">
    <asp:Login ID="Login23" runat="server" RenderOuterTable="false" 
        onloggingin="Login23_LoggingIn" FailureText="密码或用户名错误">
        <LayoutTemplate>
            <div id="dialog">
                <table cellpadding="0" style="width: 98%;">
                    <tr>
                        <td align="right" style="width: 100px;">
                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">用户名:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                ErrorMessage="必须填写“用户名”。" ToolTip="必须填写“用户名”。" ValidationGroup="Login23">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">密码:</asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                ErrorMessage="必须填写“密码”。" ToolTip="必须填写“密码”。" ValidationGroup="Login23">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" >
                           <asp:Label ID="Label1" runat="server" AssociatedControlID="CheckCode">验证码:</asp:Label>
                            </td>
                        <td>
                            <asp:TextBox ID="CheckCode" Width="50px" runat="server"></asp:TextBox>(字母，不区分大小写)
                            </td>
                    </tr>
                    <tr>
                        <td align="right" >
                        </td>
                        <td><a href="#" onclick="$('#ccode').attr('src',$('#ccode').attr('src')+'1');return false"><img alt="点击刷新验证码" src="/Checkcode.aspx?1" style="border:none;" id="ccode" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" >
                        </td>
                        <td>
                            <asp:CheckBox ID="RememberMe" runat="server" Text="下次记住我。" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2" style="color: Red;">
                           
                        </td>
                    </tr>
                    <tr style="">
                        <td align="right" colspan="2">
                            <br /><br /><br /><br /><br />
                            <asp:Label ID="FailureText" TabIndex="-1" ClientIDMode="Static" runat="server" EnableViewState="False"></asp:Label>
                            <asp:Button ID="LoginButton" runat="server" ClientIDMode="Static" CommandName="Login"
                                Text="登录" TabIndex="-1" ValidationGroup="Login23" />
                        </td>
                    </tr>
                </table>
            </div>
            <script language="javascript" type="text/javascript">
                $(function () {
                    $("#dialog").dialog({
                        "modal": true,
                        "width": 370,
                        "height": 300,
                        "title": "登录",
                        "close": function () {
                            location.href = String($("#UrlReferrer").val());
                        },
                        "resizable":false,
                        "buttons": {
                            "登录": function () {
                                $("#LoginButton").trigger("click");
                            },
                            "注册": function () {
                                location.href = "/Register.aspx";
                            },
                            "取消": function () {
                                $(this).dialog("close");
                            }
                        }
                    }).css({ "overflow": "hidden" }).parent().appendTo("form:first");
                    $("#UrlReferrer").hide();
                    if ($("#FailureText").text().length != 0) {
                        msgBox($("#FailureText").text(), null, "登录失败");
                    }
                });
            </script>
        </LayoutTemplate>
    </asp:Login>
    <asp:TextBox ID="UrlReferrer" ClientIDMode="Static" Text="/" runat="server"></asp:TextBox>
</asp:Content>
