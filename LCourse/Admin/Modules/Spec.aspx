<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/Admin/MasterPages/Modules.master" AutoEventWireup="true" CodeBehind="Spec.aspx.cs" Inherits="LCourse.Admin.Modules.Spec" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FormView RenderOuterTable="false" ID="FormView1" runat="server" DataKeyNames="id" 
        DataSourceID="LinqDataSource2">
        <EditItemTemplate>
            <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text='<%#Eval("title") %>'>
                <script src="/Admin/Documents/ckfinder/ckfinder.js" type="text/javascript"></script>
                <script src="/Admin/ckeditor/ckeditor.js" type="text/javascript"></script>
                <script type="text/javascript" language="javascript">
                    $(function () {
                        CKFinder.setupCKEditor(CKEDITOR.replace("TextBox1", {
                            resize_dir: "vertical",
                            resize_enabled: true,
                            height: "500px",
                            width: "98%",
                            fullPage: false
                        }), {
                            basePath: '/Admin/Documents/ckfinder/',
                            rememberLastFolder: false
                        }, "嵌入图片", "嵌入Flash");
                    });
                </script>
                <asp:TextBox ID="TextBox1" runat="server" ClientIDMode="Static" Text='<%#Bind("content") %>'
                    TextMode="MultiLine"></asp:TextBox>
                <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="更新" />
                &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
                    CommandName="Cancel" Text="取消" />
            </cc1:WidgetPanel>
        </EditItemTemplate>
        <ItemTemplate>
            <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text='<%#Eval("title") %>'>
                <asp:Literal ID="Literal1" runat="server" Mode="PassThrough" Text='<%# Eval("content") %>'></asp:Literal><br />
                <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                    Text="编辑" />
            </cc1:WidgetPanel>
        </ItemTemplate>
    </asp:FormView>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableUpdate="True" 
        EntityTypeName="" TableName="module_spec" Where="id == @id">
        <WhereParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="sid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
