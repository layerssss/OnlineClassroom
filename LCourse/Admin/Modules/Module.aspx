<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/Admin/MasterPages/Modules.master"
    AutoEventWireup="true" CodeBehind="Module.aspx.cs" Inherits="LCourse.Admin.Modules.Module" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FormView RenderOuterTable="false" ID="FormView1" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource1">
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
    <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="放置的位置">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id" DataSourceID="LinqDataSource2" Width="185px" 
            onrowdeleted="GridView1_RowDeleted">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" >
                <ItemStyle Width="40px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="位置" SortExpression="location_id">
                    <ItemTemplate><asp:HyperLink ID="HyperLink1" runat="server" 
                            NavigateUrl='<%# Eval("module_location.path") %>' Target="_blank" 
                            Text='<%# Bind("module_location.name") %>'></asp:HyperLink>
                    </ItemTemplate>
                    
                </asp:TemplateField>
            </Columns>
        </asp:GridView>添加新放置位置：
        <asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="LinqDataSource3" DataTextField="name" DataValueField="id">
        </asp:DropDownList>
        ‘<asp:Button ID="Button1" runat="server" Text="添加" onclick="Button1_Click" />
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EnableUpdate="True" EntityTypeName="" TableName="module_article" Where="id == @id">
        <WhereParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="aid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
        EnableDelete="True" EntityTypeName="" TableName="module_deploy" Where="article_id == @article_id">
        <WhereParameters>
            <asp:QueryStringParameter Name="article_id" QueryStringField="aid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource3" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="module_location" onselecting="LinqDataSource3_Selecting">
    </asp:LinqDataSource>
</asp:Content>
