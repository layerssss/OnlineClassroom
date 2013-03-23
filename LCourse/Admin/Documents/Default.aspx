<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Documents.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LCourse.Admin.Documents.Default" %>
<%@ Register assembly="CKFinder" namespace="CKFinder" tagprefix="CKFinder" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
<style type="text/css">
    #main
    {
        margin-left:10px;
    }
    #menu
    {
        display:none;
    }
</style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <CKFinder:FileBrowser ID="FileBrowser1" BasePath="/Admin/Documents/ckfinder/" 
        runat="server" Height="500px">
    </CKFinder:FileBrowser>
    注意：“媒体文件”文件夹内不能存放带有中文名或者特殊字符的文件或者子文件夹。
    
</asp:Content>
