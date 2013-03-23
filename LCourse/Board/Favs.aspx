<%@ Page Title="我关注的话题" Language="C#" MasterPageFile="~/MasterPages/Board.master" AutoEventWireup="true" CodeBehind="Favs.aspx.cs" Inherits="LCourse.Board.Fav" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc2:WidgetPanel ID="WidgetPanel1" runat="server" Text="我关注的话题">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="5" CellSpacing="5" DataKeyNames="id" 
        DataSourceID="LinqDataSource1" GridLines="None">
        <Columns>
            <asp:TemplateField HeaderText="标题" SortExpression="post_id">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("post.Count") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("post.title") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="讨论区" SortExpression="post_id">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("post_id") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="Label2" runat="server" 
                        NavigateUrl='<%#Eval("post.board.id","/Board/Board.aspx?bid={0}") %>' 
                        Text='<%# Bind("post.board.title") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="最后回复" SortExpression="post_id">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("post_id") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
                        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
                        OrderBy="time desc" TableName="reply" 
                        Where='<%# Eval("post_id","post_id=={0}") %>'>
                    </asp:LinqDataSource>
                    <asp:FormView ID="FormView1" runat="server" DataSourceID="LinqDataSource2" 
                        RenderOuterTable="False">
                        <ItemTemplate>
                            <asp:HyperLink ID="userLabel" runat="server" Text='<%# Eval("user.showname") %>' NavigateUrl='<%#Eval("user.id","/Board/ViewUser.aspx?uid={0}") %>' />
                            :<asp:Literal runat="server" Mode="Encode" 
                                Text='<%# LCourse.Board.Fav.CutString((string)Eval("text"),20) %>'></asp:Literal>
                            (<asp:Label ID="timeLabel" runat="server" Text='<%# Bind("time") %>' />
                            )
                        </ItemTemplate>
                    </asp:FormView>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField ControlStyle-CssClass="button" 
                DataNavigateUrlFields="post_id" 
                DataNavigateUrlFormatString="/Board/Post.aspx?pid={0}" Text="查看">
            <ControlStyle CssClass="button" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="post_id" 
                DataNavigateUrlFormatString="/board/Delfav.aspx?pid={0}" Text="取消关注">
            <ItemStyle CssClass="button" />
            </asp:HyperLinkField>
        </Columns>
    </asp:GridView> </cc2:WidgetPanel>
    <br />
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="fav" Where="user.aspnetdb_uname == @username">
        <WhereParameters>
            <asp:ControlParameter ControlID="HiddenField1" Name="username" 
                PropertyName="Value" Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
