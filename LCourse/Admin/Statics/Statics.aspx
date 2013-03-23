<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Statics.master" AutoEventWireup="true" CodeBehind="Statics.aspx.cs" Inherits="LCourse.Admin.Statics.Statics" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <cc1:WidgetPanel ID="WidgetPanel3" runat="server" Text="现有统计项目"><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="LinqDataSource1">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:BoundField DataField="name" HeaderText="统计项目名称" SortExpression="name" />
            <asp:TemplateField HeaderText="实际路径" SortExpression="path">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("path") %>' 
                        Target="_blank" ToolTip='<%# Eval("path") %>' Text="点击打开"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="访问次数" SortExpression="statics_visit.Count">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" 
                        Text='<%# Bind("statics_visit.Count") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("statics_visit.Count") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="增加特殊统计项目">
    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="LinqDataSource2" 
            DataTextField="name" DataValueField="path">
    </asp:DropDownList>
    <asp:Button ID="Button1" runat="server" Text="增加" onclick="Button1_Click" />
        <br />
        对三个内容模块中的内容的访问统计请从内容管理页面内添加（右键点击文件或文件夹）。
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableDelete="True" 
        EntityTypeName="" OrderBy="name" TableName="statics_item">
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="module_location">
    </asp:LinqDataSource>
    <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="其他操作">
        <asp:Button ID="Button2" runat="server" Text="重置全部访问次数" 
            onclick="Button2_Click" />
    </cc1:WidgetPanel>
</asp:Content>
