<%@ Page Language="C#" MasterPageFile="~/MasterPages/Frame.Master" AutoEventWireup="true"
    CodeBehind="Document.aspx.cs" Inherits="LCourse.Private.Document" %>
    
<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script type="text/javascript">
    
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MenuPlaceHolder" runat="server">
    <div class="menu">
        <h2>
            <asp:Literal ID="Literal1" runat="server"></asp:Literal></h2>
        <asp:Panel ID="Panel1" runat="server" CssClass="menuContentTight">
        </asp:Panel>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainPlaceHolder" runat="server">
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
