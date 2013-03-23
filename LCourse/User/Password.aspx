<%@ Page Title="个人设置" Language="C#" MasterPageFile="~/MasterPages/User.Master" AutoEventWireup="true" CodeBehind="Password.aspx.cs" Inherits="LCourse.User.Password" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainPlaceHolder" runat="server">
    <asp:ChangePassword ID="ChangePassword1" runat="server" 
        RenderOuterTable="false" onchangedpassword="ChangePassword1_ChangedPassword">
        <ChangePasswordTemplate>
                                <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="修改密码">
                        <table cellpadding="0" style="width:98%;">
                            <tr>
                                <td align="right">
                                    <asp:Label ID="CurrentPasswordLabel" runat="server" 
                                        AssociatedControlID="CurrentPassword">密码:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" 
                                        ControlToValidate="CurrentPassword" ErrorMessage="必须填写“密码”。" 
                                        ToolTip="必须填写“密码”。" ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="NewPasswordLabel" runat="server" 
                                        AssociatedControlID="NewPassword">新密码:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" 
                                        ControlToValidate="NewPassword" ErrorMessage="必须填写“新密码”。" ToolTip="必须填写“新密码”。" 
                                        ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="ConfirmNewPasswordLabel" runat="server" 
                                        AssociatedControlID="ConfirmNewPassword">确认新密码:</asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" 
                                        ControlToValidate="ConfirmNewPassword" ErrorMessage="必须填写“确认新密码”。" 
                                        ToolTip="必须填写“确认新密码”。" ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:CompareValidator ID="NewPasswordCompare" runat="server" 
                                        ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" 
                                        Display="Dynamic" ErrorMessage="“确认新密码”与“新密码”项必须匹配。" 
                                        ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="color:Red;">
                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Button ID="ChangePasswordPushButton" runat="server" 
                                        CommandName="ChangePassword" Text="更改密码" ValidationGroup="ChangePassword1" />
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                                </cc1:WidgetPanel>
        </ChangePasswordTemplate>
        <SuccessTemplate>
            <table cellpadding="1" cellspacing="0" style="border-collapse:collapse;display:none;">
                <tr>
                    <td>
                        <table cellpadding="0">
                            <tr>
                                <td align="center" colspan="2">
                                    密码更改完成</td>
                            </tr>
                            <tr>
                                <td>
                                    您的密码已更改!</td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="ContinuePushButton" runat="server" CausesValidation="False" 
                                        CommandName="Continue" Text="继续" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </SuccessTemplate>
    </asp:ChangePassword>
    <br />
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="修改我的电子邮箱地址">
    我的电子邮箱地址：<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        Text="修改电子邮箱地址" />
    </cc1:WidgetPanel>
</asp:Content>
