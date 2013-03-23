<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Students.master"
    AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="LCourse.Admin.Students.Student" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="基本资料">
        姓名：<asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
        <br />
        学号：<asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
        <br />
        班级：<asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
        <br />
        电子邮件地址：<asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>
        <br />
        登录用户名：<asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>
        <br />
        当前状态：<asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="重置密码" />
        <br />
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanel4" Text="作业完成情况（请在作业管理内查看作业具体具体内容）" runat="server">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id"
            DataSourceID="LinqDataSource1" AllowPaging="True" AllowSorting="True" BorderColor="Black"
            BorderStyle="Solid" BorderWidth="3px" PageSize="20">
            <Columns>
                <asp:TemplateField HeaderText="作业" SortExpression="coursework.title">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("coursework.title") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("coursework.title") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="布置时间" SortExpression="coursework.time">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("coursework.time") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("coursework.time") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="回答" SortExpression="content">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Server.HtmlEncode((string)Eval("content")).Replace("\n","<br/>") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Server.HtmlEncode((string)Eval("content")).Replace("\n","<br/>") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
                </asp:TemplateField>
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="附件上传时间">
                <EditItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#LCourse.Admin.CourseWorks.CourseWorks.GetUploadNav(Eval("user"),Eval("coursework")) %>' Text='<%#LCourse.Admin.CourseWorks.CourseWorks.GetUploadStatus(Eval("user"),Eval("coursework")) %>'></asp:HyperLink>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#LCourse.Admin.CourseWorks.CourseWorks.GetUploadNav(Eval("user"),Eval("coursework")) %>' Text='<%#LCourse.Admin.CourseWorks.CourseWorks.GetUploadStatus(Eval("user"),Eval("coursework")) %>'></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
            </asp:TemplateField>
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="批阅" SortExpression="review">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" TextMode="MultiLine" runat="server" Text='<%# Bind("review") %>'
                            Height="170px" Width="375px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Server.HtmlEncode((string)Eval("review")).Replace("\n","<br/>") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
                </asp:TemplateField>
            </Columns>
            <RowStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" />
        </asp:GridView>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanel5" runat="server" Text="访问统计">
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="LinqDataSource4">
            <Columns>
                <asp:BoundField DataField="Count" HeaderText="访问次数" ReadOnly="True" 
                    SortExpression="Count" />
                <asp:TemplateField HeaderText="统计项目名称" SortExpression="statics_item">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("statics_item.name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="统计项目路径" SortExpression="statics_item">
                    <ItemTemplate>
                        <asp:HyperLink ID="Label1" runat="server" Text="点击打开" Target="_blank" NavigateUrl='<%# Bind("statics_item.path") %>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:LinqDataSource ID="LinqDataSource4" runat="server" 
            ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
            GroupBy="statics_item"
            Select="new (key as statics_item,  Count() as Count)" 
            TableName="statics_visit" Where="user.aspnetdb_uname == @uname">
            <WhereParameters>
                <asp:ControlParameter ControlID="Label8" Name="uname" PropertyName="Text" 
                    Type="String" />
            </WhereParameters>
        </asp:LinqDataSource>
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
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EntityTypeName="" TableName="coursework_submission" OrderBy="coursework.time desc"
        Where="user_id == @user_id">
        <WhereParameters>
            <asp:QueryStringParameter Name="user_id" QueryStringField="uid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
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
