<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Students.master" AutoEventWireup="true" CodeBehind="StudentMail.aspx.cs" Inherits="LCourse.Admin.Students.StudentMail" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server">
        <asp:TextBox ID="TextBox1" runat="server" 
    TextMode="MultiLine" ClientIDMode="Static" Rows="15" Width="98%"></asp:TextBox>
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
        <br />
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="发送" />
    </cc1:WidgetPanel>
</asp:Content>