<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Documents.master"
    AutoEventWireup="true" CodeBehind="Browse.aspx.cs" Inherits="LCourse.Admin.Documents.Browse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:TreeView ID="TreeView1" runat="server" CssClass="floatleft overflowhidden" ImageSet="Simple"
                NodeIndent="10" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged" Width="300px">
                <HoverNodeStyle Font-Underline="True" ForeColor="#DD5555" />
                <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="0px"
                    NodeSpacing="0px" VerticalPadding="0px" />
                <ParentNodeStyle Font-Bold="False" />
                <SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px"
                    ForeColor="#DD5555" />
            </asp:TreeView>
            <div style="padding-left: 300px;">
                <asp:MultiView ID="MultiView1" runat="server">
                    <asp:View ID="viewBrowse" runat="server">
                        <div class="widget-header">
                            <asp:Label ID="labelBrowse" runat="server" Text="Label"></asp:Label>
                            <asp:LinkButton ID="butRenameFolder" CssClass="button" runat="server">重命名</asp:LinkButton>
                            <asp:LinkButton ID="butDelFolder" CssClass="button" runat="server" 
                                onclick="butDelFolder_Click">删除</asp:LinkButton>
                        </div>
                        <asp:Panel ID="panelBrowse" runat="server">
                        </asp:Panel>
                        <div class="widget-header">
                            <asp:TextBox ID="textNew" runat="server" Width="304px"></asp:TextBox>
                            <asp:LinkButton CssClass="button" ID="butNewFolder" runat="server" 
                                onclick="butNewFolder_Click">新建子文件夹</asp:LinkButton><asp:LinkButton
                                CssClass="button" ID="butNewHtml" runat="server" 
                                onclick="butNewHtml_Click">新建HTML页面</asp:LinkButton></div>
                    </asp:View>
                    <asp:View ID="viewEdit" runat="server">
                        <div class="widget-header">
                            <asp:Label ID="labelEdit" runat="server" Text="Label"></asp:Label>
                        </div>
                        <div class="widget-content">
                            <asp:TextBox ID="textEdit" runat="server" Rows="20" TextMode="MultiLine" Width="100%"></asp:TextBox></div>
                        <div class="widget-header">
                            <asp:LinkButton ID="butEditOk" CssClass="button" runat="server" OnClick="butEditOk_Click">保存</asp:LinkButton><asp:LinkButton
                                CssClass="button" ID="butEditCancel" runat="server" OnClick="butEditCancel_Click">取消</asp:LinkButton><asp:HiddenField
                                    ID="hidEdit" runat="server" />
                        </div>
                    </asp:View>
                    <asp:View ID="viewRenameFile" runat="server">
                        <div class="widget-header">
                            <asp:Label ID="labelRenameFile" runat="server" Text="Label"></asp:Label>
                        </div>
                        <div class="widget-content">
                            <asp:TextBox ID="textRenameFile" runat="server" Width="477px"></asp:TextBox>
                        </div>
                        <div class="widget-header">
                            <asp:LinkButton ID="butRenameFileOk" CssClass="button" runat="server" OnClick="butRenameFileOk_Click">确定</asp:LinkButton>
                            <asp:LinkButton CssClass="button" ID="butRenameFileCancel" runat="server" OnClick="butRenameFileCancel_Click">取消</asp:LinkButton><asp:HiddenField
                                ID="hidRenameFile" runat="server" />
                        </div>
                    </asp:View>
                    <asp:View ID="viewRenameFolder" runat="server">
                        <div class="widget-header">
                            <asp:Label ID="labelRenameFolder" runat="server" Text="Label"></asp:Label>
                        </div>
                        <div class="widget-content">
                            <asp:TextBox ID="textRenameFolder" runat="server" Width="472px"></asp:TextBox>
                        </div>
                        <div class="widget-header">
                            <asp:LinkButton ID="butRenameFolderOk" CssClass="button" runat="server">确定</asp:LinkButton>
                            <asp:LinkButton ID="butRenameFolderCancel" CssClass="button" runat="server" OnClick="butRenameFolderCancel_Click">取消</asp:LinkButton></div>
                    </asp:View>
                </asp:MultiView></div>
            <asp:ScriptManager EnablePartialRendering="true" ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
