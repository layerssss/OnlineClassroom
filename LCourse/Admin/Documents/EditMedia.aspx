<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditMedia.aspx.cs" Inherits="LCourse.Admin.Documents.EditMedia" %>

<%@ Register Assembly="CKFinder" Namespace="CKFinder" TagPrefix="CKFinder" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title><link rel="stylesheet" type="text/css" href="../../Styles/theme/jquery-ui-1.8.6.custom.css" />
    <link href="../../Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-ui-1.8.6.custom.min.js" type="text/javascript"></script>
    <script src="../../Scripts/JScript.js" type="text/javascript"></script>
    <script src="../ckeditor/ckeditor.js" type="text/javascript"></script>
    <script src="ckfinder/ckfinder.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function browseOk(data) {
            $("#TextBox1").val(data);
        }
        function browse() {
            // You can use the "CKFinder" class to render CKFinder in a page:
            var finder = new CKFinder();

            // The path for the installation of CKFinder (default = "/ckfinder/").
            finder.basePath = 'ckfinder/';

            //Startup path in a form: "Type:/path/to/directory/"
            finder.startupPath = "媒体文件:/";
            finder.resourceType = "媒体文件";

            // Name of a function which is called when a file is selected in CKFinder.
            finder.selectActionFunction = browseOk;

            // Additional data to be passed to the selectActionFunction in a second argument.
            // We'll use this feature to pass the Id of a field that will be updated.
            //finder.selectActionData = functionData;

            // Name of a function which is called when a thumbnail is selected in CKFinder.
            //finder.selectThumbnailActionFunction = ShowThumbnails;

            // Launch CKFinder
            finder.popup();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="widget-content" style="height: 250px;">
        指向媒体文件：<asp:TextBox ID="TextBox1" runat="server" Width="529px"></asp:TextBox>
        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="button" 
            onclientclick="browse();return false;">浏览</asp:LinkButton>
        <br />
    </div>
    <div class="widget-header" style="text-align:right;">
        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="button" 
            onclick="LinkButton1_Click">确定</asp:LinkButton><a class="button" href="javascript:window.close();">取消</a></div>
    </form>
</body>
</html>
