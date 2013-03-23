<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Board.master" AutoEventWireup="true" CodeBehind="Class.aspx.cs" Inherits="LCourse.Board.Class" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text=""><asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
        AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="LinqDataSource2">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="id" 
                DataNavigateUrlFormatString="ViewUser.aspx?uid={0}" DataTextField="showname" 
                HeaderText="姓名" SortExpression="showname" />
            <asp:BoundField DataField="lastaccesstime" HeaderText="上次登录" 
                SortExpression="lastaccesstime" />
            <asp:TemplateField HeaderText="讨论区主题" SortExpression="post.Count">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("post.Count") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("post.Count") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="讨论区回复" SortExpression="reply.Count">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("reply.Count") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("reply.Count") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        OrderBy="showname" TableName="user" Where="class_id == @class_id">
        <WhereParameters>
            <asp:QueryStringParameter Name="class_id" QueryStringField="cid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
