<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Board.Master" AutoEventWireup="true" CodeBehind="AddBoard.aspx.cs" Inherits="LCourse.Board.Manage.Struct.AddBoard" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="添加新板块">
    新讨论版名称：<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="添加" />
    </cc1:WidgetPanel>
</asp:Content>
