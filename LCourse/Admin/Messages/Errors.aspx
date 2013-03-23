<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Messages.master" AutoEventWireup="true" CodeBehind="Errors.aspx.cs" Inherits="LCourse.Admin.Messages.Errors" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="错误消息日志">
        <asp:GridView ID="GridView1" runat="server" 
    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
    DataKeyNames="id" DataSourceID="LinqDataSource1" PageSize="30">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" />
                <asp:HyperLinkField 
            DataNavigateUrlFields="id" DataNavigateUrlFormatString="Error.aspx?eid={0}" 
            Text="查看消息" />
                <asp:BoundField DataField="time" HeaderText="时间" 
            SortExpression="time" />
                <asp:BoundField DataField="rawurl" HeaderText="原始URL" 
            SortExpression="rawurl" />
                <asp:BoundField DataField="ip" HeaderText="IP地址" 
            SortExpression="ip" />
            </Columns>
        </asp:GridView>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="其他操作">
        <asp:Button ID="Button1" runat="server" Text="全部清空" onclick="Button1_Click" />
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableDelete="True" 
        EntityTypeName="" OrderBy="time desc" TableName="msg_error">
    </asp:LinqDataSource>
</asp:Content>
