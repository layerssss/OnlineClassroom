<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Test.master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="LCourse.Admin.Test.Test" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc2:WidgetPanel ID="WidgetPanel1" runat="server" Text="试卷">
        <asp:GridView ID="GridView1" runat="server" 
    AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="LinqDataSource1">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="title" HeaderText="试卷标题" SortExpression="title" />
                <asp:HyperLinkField DataNavigateUrlFields="id" 
                    DataNavigateUrlFormatString="Subs.aspx?tid={0}" Text="管理题目" />
            </Columns>
        </asp:GridView>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="添加" />
    </cc2:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableDelete="True" 
        EnableUpdate="True" EntityTypeName="" TableName="test">
    </asp:LinqDataSource>
</asp:Content>
