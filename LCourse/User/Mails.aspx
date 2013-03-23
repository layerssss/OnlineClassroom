<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/User.master" AutoEventWireup="true" CodeBehind="Mails.aspx.cs" Inherits="LCourse.User.Mails" %>

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
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="我的邮件记录">
        这里是最近的通知记录，通常，这些通知是已经发到你邮箱里去了的，但是并不是所有的通知都在这里能查得到，因为老师会不定期清空这些记录。<br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" 
        DataSourceID="LinqDataSource1">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="id" 
                DataNavigateUrlFormatString="Mail.aspx?mid={0}" DataTextField="title" 
                HeaderText="标题（点击查看）" SortExpression="title" />
            <asp:BoundField DataField="email" HeaderText="收件地址" SortExpression="email" />
            <asp:BoundField DataField="time" HeaderText="时间" SortExpression="time" />
        </Columns>
    </asp:GridView>
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        OrderBy="time desc" TableName="msg_mails" Where="user.aspnetdb_uname == @user">
        <WhereParameters>
            <asp:ControlParameter ControlID="HiddenField1" Name="user" PropertyName="Value" 
                Type="String" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>
