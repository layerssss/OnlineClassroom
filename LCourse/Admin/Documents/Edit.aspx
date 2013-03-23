<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="LCourse.Admin.Documents.Edit" %>

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
        $(function () {
            CKFinder.setupCKEditor(CKEDITOR.replace("TextBox1", {
                resize_dir: "vertical",
                resize_enabled: true,
                height: "520px",
                width: "1010px",
                fullPage: false
            }), {
                basePath: '/Admin/Documents/ckfinder/',
                rememberLastFolder: false
            },"嵌入图片","嵌入Flash");
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:TextBox ID="TextBox1" runat="server"
            TextMode="MultiLine"></asp:TextBox>
    
    </div>
    <div class="widget-header" style="text-align:right;">
        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="button" 
            onclick="LinkButton1_Click">确定</asp:LinkButton><a class="button" href="javascript:window.close();">取消</a></div>
    </form>
</body>
</html>
