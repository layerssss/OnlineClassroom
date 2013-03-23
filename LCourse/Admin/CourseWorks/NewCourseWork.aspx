<%@ Page Title="" ValidateRequest="false" Language="C#" MasterPageFile="~/Admin/MasterPages/CourseWorks.master" AutoEventWireup="true" CodeBehind="NewCourseWork.aspx.cs" Inherits="LCourse.Admin.CourseWorks.NewCourseWork" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Admin/Documents/ckfinder/ckfinder.js" type="text/javascript"></script>
    <script src="/Admin/ckeditor/ckeditor.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
    $(function () {
        CKFinder.setupCKEditor(CKEDITOR.replace("TextBox1", {
            resize_dir: "vertical",
            resize_enabled: true,
            height: "200px",
            width: "98%",
            fullPage: false
        }), {
            basePath: '/Admin/Documents/ckfinder/',
            rememberLastFolder: false
        }, "嵌入图片", "嵌入Flash");
    });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc2:WidgetPanel ID="WidgetPanel1" runat="server" Text="布置作业">
        标题：<asp:TextBox ID="TextBox2" runat="server" Width="412px"></asp:TextBox>
        <br />
    <asp:TextBox ID="TextBox1" runat="server" ClientIDMode="Static"
        TextMode="MultiLine"></asp:TextBox>
        <br />
        要求上传附件扩展名（例如“.rar”，不要上传附件则该项留空）：<asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    <br />
        班级：<asp:DropDownList ID="DropDownList1" runat="server" 
        DataSourceID="LinqDataSource1" DataTextField="name" DataValueField="id">
    </asp:DropDownList>
    <asp:Button ID="Button1" runat="server" Text="布置" onclick="Button1_Click" />
    </cc2:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="class">
    </asp:LinqDataSource>
    <br />
</asp:Content>
