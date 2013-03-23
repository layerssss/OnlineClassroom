<%@ Page Title="课程首页" Language="C#" MasterPageFile="~/MasterPages/Frame.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="LCourse.Default" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuPlaceHolder" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataSourceID="LinqDataSource1" RenderOuterTable="False">
        <ItemTemplate>
            <div style="overflow:hidden;" class="widget-content">
                <asp:Literal ID="Literal1" runat="server" Mode="PassThrough" Text='<%# Eval("content") %>'></asp:Literal>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EntityTypeName="" Select="new (content)" TableName="module_spec" Where="ident == @ident">
        <WhereParameters>
            <asp:Parameter DefaultValue="rootleft" Name="ident" Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainPlaceHolder" runat="server">
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
