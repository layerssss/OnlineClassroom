﻿<%@ Page Title="帮助" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true" CodeBehind="Help.aspx.cs" Inherits="LCourse.Help" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainPlaceHolder" runat="server">
<asp:ListView ID="ListViewModules" runat="server" 
        DataSourceID="LinqDataSourceModules" DataKeyNames="id">
        <ItemTemplate>
            <cc1:WidgetPanel ID="WidgetPanelModules" runat="server" Text='<%#Eval("module_article.title") %>'>
                <asp:Literal ID="LiteralModules" Mode="PassThrough" Text='<%#Eval("module_article.content") %>' runat="server"></asp:Literal>
            </cc1:WidgetPanel>
        </ItemTemplate>
    </asp:ListView>
    <asp:HiddenField ID="HiddenFieldModules" runat="server" />
    <asp:LinqDataSource ID="LinqDataSourceModules" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        OrderBy="module_article.sort desc" TableName="module_deploy" 
        
        Where="module_location.path == @module_location &amp;&amp; module_article.show">
        <WhereParameters>
            <asp:ControlParameter ControlID="HiddenFieldModules" Name="module_location" 
                PropertyName="Value" Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>