<%@ Page Language="C#" MasterPageFile="~/MasterPages/Board.master" AutoEventWireup="true"
    CodeBehind="Board.aspx.cs" Inherits="LCourse.Board.Board" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource3"
        RenderOuterTable="False">
        <ItemTemplate>
            <div class="widget">
                <div class="widget-header" style="padding: 7px 10px; margin: 10px 0 0px 0;">
                    <asp:Label ID="titleLabel" runat="server" Text='<%# Bind("title") %>' />
                    <asp:HyperLink Font-Size="XX-Small" CssClass="button admin" ID="HyperLink4" runat="server" 
                        NavigateUrl='<%# Eval("id","Manage/Struct/EditBoard.aspx?bid={0}") %>'>Edit</asp:HyperLink>
                </div>
                <div class="widget-content" style="margin-bottom: 10px;">
                    <asp:Literal ID="textLabel" Mode="PassThrough" runat="server" Text='<%#Server.HtmlEncode((string)Eval("text")).Replace("\n","<br />") %>' />
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource2">
        <EmptyDataTemplate>
            <span>该讨论区没有任何话题。</span>
        </EmptyDataTemplate>
        <ItemTemplate>
            <h2>
                <asp:Literal ID="Literal1" Text='<%#Eval("title","{0}") %>' runat="server"></asp:Literal><asp:Label
                    ID="Label1" runat="server" Text='<%#Eval("user.showname","--{0}") %>'></asp:Label><asp:Label
                        ID="Label2" runat="server" Text='<%#Eval("time","({0})") %>'></asp:Label>
            </h2>
            <asp:Panel ID="Panel1" runat="server">
                <asp:Literal ID="Literal2" runat="server" Text='<%#Server.HtmlEncode((string)Eval("text")).Replace("\n","<br />") %>'></asp:Literal>
                <asp:HyperLink ID="HyperLink3" Font-Size="XX-Small" runat="server" CssClass="button admin"
                    NavigateUrl='<%# Eval("id", "/Board/Manage/DelPost.aspx?pid={0}") %>'>Del</asp:HyperLink>
                    <br />
                    <br />
                <asp:HyperLink ID="HyperLink1" runat="server" Font-Size="Smaller" NavigateUrl='<%#Eval("id","Post.aspx?pid={0}") %>' Text='<%#Eval("reply.Count","查看该话题的{0}条回复") %>'></asp:HyperLink>
            </asp:Panel>
        </ItemTemplate>
        <LayoutTemplate>
            <div id="itemPlaceholderContainer" runat="server" class="accordion" style="width:100% !important;width:99%;">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="">
                <asp:DataPager ID="DataPager1" PageSize="10" runat="server">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:Panel ID="Panel8" CssClass="widget" runat="server">
        <asp:Panel ID="Panel9" CssClass="widget-header" runat="server">
            发表新话题
        </asp:Panel>
        <asp:Panel ID="Panel10" CssClass="widget-content" runat="server">
            <asp:TextBox ID="TextBox3" runat="server" Width="100%"></asp:TextBox>
            <asp:TextBox ID="TextBox2" runat="server" Rows="10" TextMode="MultiLine" Width="100%"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="发表" OnClick="Button1_Click" />
        </asp:Panel>
    </asp:Panel>
    <br />
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EnableDelete="True" EntityTypeName="" OrderBy="time desc" TableName="post" Where="board_id == @board_id">
        <WhereParameters>
            <asp:QueryStringParameter Name="board_id" QueryStringField="bid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource3" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="board" Where="id == @id">
        <WhereParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="bid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
