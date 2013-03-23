<%@ Page Title="在线讨论" Language="C#" MasterPageFile="~/MasterPages/Board.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="LCourse.Board.Default" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ListView ID="ListViewModules" runat="server" DataSourceID="LinqDataSourceModules"
        DataKeyNames="id">
        <ItemTemplate>
            <cc1:WidgetPanel ID="WidgetPanelModules" runat="server" Text='<%#Eval("module_article.title") %>'>
                <asp:Literal ID="LiteralModules" Mode="PassThrough" Text='<%#Eval("module_article.content") %>'
                    runat="server"></asp:Literal>
            </cc1:WidgetPanel>
        </ItemTemplate>
    </asp:ListView>
    <asp:HiddenField ID="HiddenFieldModules" runat="server" />
    <asp:LinqDataSource ID="LinqDataSourceModules" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EntityTypeName="" OrderBy="module_article.sort desc" TableName="module_deploy"
        
        Where="module_location.path == @module_location &amp;&amp; module_article.show &amp;&amp; module_article.sort&gt;=&quot;5&quot;">
        <WhereParameters>
            <asp:ControlParameter ControlID="HiddenFieldModules" Name="module_location" PropertyName="Value"
                Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
    <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="最新话题">
        <asp:ListView ID="ListView2" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource1">
            <ItemTemplate>
                <li style="white-space: nowrap; overflow: hidden;">
                    <asp:HyperLink ID="post_idLabel" runat="server" Text='<%# Eval("title") %>' NavigateUrl='<%#Eval("id","/Board/Post.aspx?pid={0}") %>' />
                    --<asp:HyperLink ID="userLabel" runat="server" Text='<%# Eval("user.showname") %>' NavigateUrl='<%#Eval("user.id","/Board/ViewUser.aspx?uid={0}") %>' />@
                    <asp:HyperLink ID="Label2" runat="server" NavigateUrl='<%#Eval("board.id","/Board/Board.aspx?bid={0}") %>'
                        Text='<%# Eval("board.title") %>'></asp:HyperLink>
                    （<asp:Label ID="timeLabel" runat="server" Text='<%# Eval("time") %>' />）</li>
            </ItemTemplate>
            <LayoutTemplate>
                <ul id="itemPlaceholderContainer" runat="server" style="">
                    <li runat="server" id="itemPlaceholder" />
                </ul>
                <asp:DataPager ID="DataPager1" runat="server" PageSize="5">
                </asp:DataPager>
            </LayoutTemplate>
        </asp:ListView>
        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
            EntityTypeName="" OrderBy="time desc" TableName="post">
        </asp:LinqDataSource>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="最新回复">
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource2">
            <ItemTemplate>
                <li style="white-space: nowrap; overflow: hidden;">RE:<asp:HyperLink ID="post_idLabel" NavigateUrl='<%#Eval("post.id","/Board/Post.aspx?pid={0}") %>'
                    runat="server" Text='<%# Eval("post.title") %>' />
                    --<asp:HyperLink ID="userLabel" runat="server" Text='<%# Eval("user.showname") %>' NavigateUrl='<%#Eval("user.id","/Board/ViewUser.aspx?uid={0}") %>' />@
                    <asp:HyperLink ID="Label2" runat="server" NavigateUrl='<%#Eval("post.board.id","/Board/Board.aspx?bid={0}") %>'
                        Text='<%# Eval("post.board.title") %>'></asp:HyperLink>
                    （<asp:Label ID="timeLabel" runat="server" Text='<%# Eval("time") %>' />）：
                    <asp:Label ID="textLabel" runat="server" Text='<%# Eval("text") %>' /></li>
            </ItemTemplate>
            <LayoutTemplate>
                <ul id="itemPlaceholderContainer" runat="server" style="">
                    <li runat="server" id="itemPlaceholder" />
                </ul>
                <asp:DataPager ID="DataPager1" runat="server" PageSize="5">
                </asp:DataPager>
            </LayoutTemplate>
        </asp:ListView>
        <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
            EntityTypeName="" OrderBy="time desc" TableName="reply">
        </asp:LinqDataSource>
    </cc1:WidgetPanel>
    <asp:ListView ID="ListView3" runat="server" DataSourceID="LinqDataSource3"
        DataKeyNames="id">
        <ItemTemplate>
            <cc1:WidgetPanel ID="WidgetPanelModules" runat="server" Text='<%#Eval("module_article.title") %>'>
                <asp:Literal ID="LiteralModules" Mode="PassThrough" Text='<%#Eval("module_article.content") %>'
                    runat="server"></asp:Literal>
            </cc1:WidgetPanel>
        </ItemTemplate>
    </asp:ListView>
    <asp:LinqDataSource ID="LinqDataSource3" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EntityTypeName="" OrderBy="module_article.sort desc" TableName="module_deploy"
        
        Where="module_location.path == @module_location &amp;&amp; module_article.show &amp;&amp; module_article.sort&lt;&quot;5&quot;">
        <WhereParameters>
            <asp:ControlParameter ControlID="HiddenFieldModules" Name="module_location" PropertyName="Value"
                Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
