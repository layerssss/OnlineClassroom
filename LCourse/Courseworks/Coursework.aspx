<%@ Page Language="C#" MasterPageFile="~/MasterPages/CourseWorks.master" AutoEventWireup="true" CodeBehind="Coursework.aspx.cs" Inherits="LCourse.Courseworks.Coursework" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanelContent" runat="server">
        <asp:Literal Mode="PassThrough" ID="LiteralContent" runat="server"></asp:Literal>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanelStatus" runat="server" Text="作业状态">
        说明：<asp:Literal ID="LiteralStatus" runat="server"></asp:Literal>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanelUpload" runat="server">
        <asp:FileUpload ID="FileUpload1" runat="server" /><asp:Button ID="ButtonUpload" 
            runat="server" Text="上传" onclick="ButtonUpload_Click" />
        <asp:HiddenField ID="HiddenFieldUpload" runat="server" />
        <asp:HiddenField ID="HiddenFieldUploadPath" runat="server" />
        <br />
        <asp:Label ID="LabelUpload" runat="server"
            Text="Label"></asp:Label>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanelSubmission" runat="server" Text="我的回答">
        <asp:TextBox ID="TextBoxSubmission" runat="server" Rows="10" 
            TextMode="MultiLine" Width="98%"></asp:TextBox>
        <br />
        <asp:LinkButton ID="LinkButtonSubmission"
            runat="server" CssClass="button" onclick="LinkButtonSubmission_Click">提交</asp:LinkButton>
        <asp:Literal ID="LiteralSubmission"
            runat="server"></asp:Literal>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanelReview" runat="server" Text="老师的批阅">
        <asp:Literal ID="LiteralReview" runat="server"></asp:Literal>
    </cc1:WidgetPanel>
</asp:Content>
