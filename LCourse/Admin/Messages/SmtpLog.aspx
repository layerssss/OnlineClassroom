<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Messages.master" AutoEventWireup="true" CodeBehind="SmtpLog.aspx.cs" Inherits="LCourse.Admin.Messages.SmtpLog" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="待发送邮件队列">

    </cc1:WidgetPanel>
<cc1:WidgetPanel
        ID="WidgetPanel1" runat="server" Text="邮件发送错误日志">
    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    </cc1:WidgetPanel>
</asp:Content>
