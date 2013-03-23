<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Students.master" AutoEventWireup="true" CodeBehind="Classes.aspx.cs" Inherits="LCourse.Admin.Students.Classes" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc2:WidgetPanel ID="WidgetPanel1" Text="班级管理" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="LinqDataSource1">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:TemplateField HeaderText="所有作业附件打包下载">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# "/Admin/CourseWorks/GetUploads.aspx?path="+Server.UrlEncode(LCourse.Transactions.GetAbsSubmissionsUploadRoot()+(string)Eval("name")+"\\") %>' 
                        Text="下载"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="id" 
                DataNavigateUrlFormatString="ClassMail.aspx?cid={0}" Text="班级通知" />
            <asp:BoundField DataField="name" HeaderText="班级名称" SortExpression="name" />
            <asp:TemplateField HeaderText="已注册人数">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("user.Count") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("user.Count") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="未注册人数" SortExpression="stdprof">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("stdprof.Count") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("stdprof.Count") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Button ID="Button1" runat="server" Text="添加" onclick="Button1_Click" />
    </cc2:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" EntityTypeName="" 
        TableName="class" ondeleted="LinqDataSource1_Deleted">
    </asp:LinqDataSource>
    </asp:Content>
