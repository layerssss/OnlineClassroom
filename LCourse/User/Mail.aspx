<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true" CodeBehind="Mail.aspx.cs" Inherits="LCourse.User.Mail" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainPlaceHolder" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="邮件信息">
        收件人电子邮箱：<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        发送时间：<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
    </cc1:WidgetPanel>
        <cc1:WidgetPanel ID="WidgetPanel2" runat="server">
            <asp:Literal ID="Literal2" runat="server" Mode="PassThrough"></asp:Literal>
        </cc1:WidgetPanel>
    <br />
</asp:Content>
