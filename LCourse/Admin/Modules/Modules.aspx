<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Modules.master" AutoEventWireup="true" CodeBehind="Modules.aspx.cs" Inherits="LCourse.Admin.Modules.Modules" %>
<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="所有模块">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id" DataSourceID="LinqDataSource1">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="title" HeaderText="标题" SortExpression="title" />
                <asp:CheckBoxField DataField="show" HeaderText="是否显示" SortExpression="show" />
                <asp:BoundField DataField="sort" HeaderText="排序优先级" 
                    SortExpression="sort" />
                    
                <asp:TemplateField HeaderText="放置位置">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" 
                            Text='<%# GetDeployString(Eval("module_deploy"),35) %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" 
                            Text='<%# GetDeployString(Eval("module_deploy"),35) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                    
                <asp:HyperLinkField  DataNavigateUrlFields="id" 
                    DataNavigateUrlFormatString="Module.aspx?aid={0}" Text="编辑更多" />
            </Columns>
        </asp:GridView>
        说明：在线讨论首页的最新回复模块的排序优先级为5<br />
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="添加" />
        <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
            ContextTypeName="LCourse.DataClasses1DataContext" EnableDelete="True" 
            EnableUpdate="True" EntityTypeName="" TableName="module_article" 
            OrderBy="sort desc">
        </asp:LinqDataSource>
    </cc1:WidgetPanel>
</asp:Content>
