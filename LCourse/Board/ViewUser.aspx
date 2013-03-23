<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Board.master" AutoEventWireup="true"
    CodeBehind="ViewUser.aspx.cs" Inherits="LCourse.Board.ViewUser" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="基本资料">
        姓名：<asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
        <br />
        班级：<asp:HyperLink ID="link4" runat="server" Text="Label"></asp:HyperLink>
        <br />
        当前状态：<asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:HyperLink ID="HyperLink5" runat="server">留言/发送即时消息</asp:HyperLink>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="在讨论区发布的主题">
        <asp:ListView ID="ListView2" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource2">
            <ItemTemplate>
                <li style="white-space: nowrap; overflow: hidden;">
                    <asp:HyperLink ID="post_idLabel" runat="server" Text='<%# Eval("title") %>' NavigateUrl='<%#Eval("id","/Board/Post.aspx?pid={0}") %>' />
                    --<asp:HyperLink ID="userLabel" runat="server" Text='<%# Eval("user.showname") %>'
                        NavigateUrl='<%#Eval("user.id","/Board/ViewUser.aspx?uid={0}") %>' />@
                    <asp:HyperLink ID="Label2" runat="server" NavigateUrl='<%#Eval("board.id","/Board/Board.aspx?bid={0}") %>'
                        Text='<%# Eval("board.title") %>'></asp:HyperLink>
                    （<asp:Label ID="timeLabel" runat="server" Text='<%# Eval("time") %>' />）</li>
            </ItemTemplate>
            <LayoutTemplate>
                <ul id="itemPlaceholderContainer" runat="server" style="">
                    <li runat="server" id="itemPlaceholder" />
                </ul>
                <asp:DataPager ID="DataPager1" runat="server">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False"
                            ShowPreviousPageButton="False" />
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False"
                            ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </LayoutTemplate>
        </asp:ListView>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanel3" runat="server" Text="在讨论区发布的回复">
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource3">
            <ItemTemplate>
                <li style="white-space: nowrap; overflow: hidden;">RE:<asp:HyperLink ID="post_idLabel"
                    NavigateUrl='<%#Eval("post.id","/Board/Post.aspx?pid={0}") %>' runat="server"
                    Text='<%# Eval("post.title") %>' />
                    --<asp:HyperLink ID="userLabel" runat="server" Text='<%# Eval("user.showname") %>'
                        NavigateUrl='<%#Eval("user.id","/Board/ViewUser.aspx?uid={0}") %>' />@
                    <asp:HyperLink ID="Label2" runat="server" NavigateUrl='<%#Eval("post.board.id","/Board/Board.aspx?bid={0}") %>'
                        Text='<%# Eval("post.board.title") %>'></asp:HyperLink>
                    （<asp:Label ID="timeLabel" runat="server" Text='<%# Eval("time") %>' />）：
                    <asp:Label ID="textLabel" runat="server" Text='<%# Eval("text") %>' /></li>
            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="">
                    <asp:DataPager ID="DataPager1" runat="server">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False"
                                ShowPreviousPageButton="False" />
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False"
                                ShowPreviousPageButton="False" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
        </asp:ListView>
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EntityTypeName="" OrderBy="time desc" TableName="post" Where="uid == @uid">
        <WhereParameters>
            <asp:QueryStringParameter Name="uid" QueryStringField="uid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource3" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EntityTypeName="" OrderBy="time desc" TableName="reply" Where="uid == @uid">
        <WhereParameters>
            <asp:QueryStringParameter Name="uid" QueryStringField="uid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <br />
    <br />
    <br />
</asp:Content>
