<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/Admin/MasterPages/Test.master"
    AutoEventWireup="true" CodeBehind="Subs.aspx.cs" Inherits="LCourse.Admin.Test.Subs" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Admin/Documents/ckfinder/ckfinder.js" type="text/javascript"></script>
    <script src="/Admin/ckeditor/ckeditor.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript"></script>
    <script type="text/javascript" language="javascript">
        function myReload(first) {
            if (first) {
                if ($("#testTextBox").length > 0) {
                    CKFinder.setupCKEditor(CKEDITOR.replace("testTextBox", {
                        resize_dir: "vertical",
                        resize_enabled: true,
                        height: "200px",
                        width: "98%",
                        fullPage: false
                    }), {
                        basePath: '/Admin/Documents/ckfinder/',
                        rememberLastFolder: false
                    }, "嵌入图片", "嵌入Flash");
                }
            } else {
                if ($("#test_subTextBox").length > 0) {
                    CKFinder.setupCKEditor(CKEDITOR.replace("test_subTextBox", {
                        resize_dir: "vertical",
                        resize_enabled: true,
                        height: "200px",
                        width: "98%",
                        fullPage: false
                    }), {
                        basePath: '/Admin/Documents/ckfinder/',
                        rememberLastFolder: false
                    }, "嵌入图片", "嵌入Flash");
                }
            }
            addJUI();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource1"
        RenderOuterTable="False">
        <EditItemTemplate>
            <cc2:WidgetPanel ID="WidgetPanel1" runat="server" Text='<%# Eval("title","“{0}”介绍") %>'>
                <asp:TextBox ID="testTextBox" runat="server" Text='<%# Bind("content") %>' ClientIDMode="Static"
                    TextMode="MultiLine" />
                <br />
    <script type="text/javascript" language="javascript">
        $(myReload(true));
    </script>
                <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="更新" />
                &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
                    CommandName="Cancel" Text="取消" />
            </cc2:WidgetPanel>
            <br />
        </EditItemTemplate>
        <ItemTemplate>
            <cc2:WidgetPanel ID="WidgetPanel1" runat="server" Text='<%# Eval("title","“{0}”介绍") %>'>
                <asp:Literal ID="Literal1" runat="server" Mode="PassThrough" Text='<%# Eval("content") %>'></asp:Literal>
                <br />
                <asp:Button ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                    Text="编辑" />
            </cc2:WidgetPanel>
            <br />
        </ItemTemplate>
    </asp:FormView>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" DataSourceID="LinqDataSource2"
        OnItemUpdating="ListView1_ItemUpdating" OnItemCommand="ListView1_ItemCommand">
        <EditItemTemplate>
            <cc2:WidgetPanel ID="WidgetPanel1" runat="server" Text="修改问题">
                问题编号：<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sort") %>' />
                <asp:TextBox ID="test_subTextBox" runat="server" Text='<%# Bind("content") %>' ClientIDMode="Static"
                    TextMode="MultiLine" />
    <script type="text/javascript" language="javascript">
        $(myReload(false));
    </script>
                <br />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="HiddenFieldOptions" Value='<%# Bind("options") %>' runat="server" />
                        <cc2:WidgetPanel ID="WidgetPanel3" runat="server" Text="可选选项（每行一项）">
                            <asp:TextBox ID="TextBoxOptions" Width="98%" TextMode="MultiLine" Rows="5" Text='<%# this.TransformOptionsString((string)Eval("options"),false) %>'
                                runat="server" AutoPostBack="True" OnTextChanged="TextBox2_TextChanged" OnPreRender="TextBoxOptions_PreRender"></asp:TextBox>
                        </cc2:WidgetPanel>
                        <cc2:WidgetPanel ID="WidgetPanel4" runat="server" Text="正确选项">
                            <asp:DropDownList ID="DropDownListOptions" runat="server">
                            </asp:DropDownList>
                        </cc2:WidgetPanel>
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="更新" />
                &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
                    CommandName="Cancel" Text="取消" />
            </cc2:WidgetPanel>
            <br />
        </EditItemTemplate>
        <ItemTemplate>
            <cc2:WidgetPanel ID="WidgetPanel1" runat="server" Text='<%# Eval("sort","问题编号：{0}") %>'>
                <asp:Literal ID="contentLabel" runat="server" Mode="PassThrough" Text='<%# Eval("content") %>' />
                <br />
                <cc2:WidgetPanel ID="WidgetPanel5" runat="server" Text="问题选项">
                    <asp:Literal ID="Literal2" runat="server" Mode="Passthrough" Text='<%# this.TransformOptionsString((string)Eval("options"),true)  %>'></asp:Literal>
                </cc2:WidgetPanel>
                <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="编辑" />
                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="删除" />
            </cc2:WidgetPanel>
            <br />
        </ItemTemplate>
        <LayoutTemplate>
            <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
        </LayoutTemplate>
    </asp:ListView>
    <cc2:WidgetPanel ID="WidgetPanel2" runat="server" Text="其他操作">
        <asp:Button ID="Button1" runat="server" Text="添加一道问题" OnClick="Button1_Click" />
    </cc2:WidgetPanel>
    <p>
        <br />
    </p>
    <p>
        <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
            EnableUpdate="True" EntityTypeName="" TableName="test" Where="id == @id">
            <WhereParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="tid" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>
        <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="LCourse.DataClasses1DataContext"
            EnableDelete="True" EnableUpdate="True" EntityTypeName="" OrderBy="sort" TableName="test_sub"
            Where="test_id == @test_id">
            <WhereParameters>
                <asp:QueryStringParameter Name="test_id" QueryStringField="tid" Type="Int32" />
            </WhereParameters>
        </asp:LinqDataSource>
    </p>
</asp:Content>
