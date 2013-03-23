<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Messages.master" AutoEventWireup="true" CodeBehind="Mails.aspx.cs" Inherits="LCourse.Admin.Messages.Mails" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="邮件消息日志">
        <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="查看类型">
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                DataSourceID="LinqDataSource2" DataTextField="type" DataValueField="type" 
                onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
                ondatabound="DropDownList1_DataBound"><asp:ListItem Text="(全部)" Value=""></asp:ListItem>
        </asp:DropDownList>
        </cc1:WidgetPanel>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id" DataSourceID="LinqDataSource1" AllowPaging="True" 
            AllowSorting="True" PageSize="20">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" runat="server" 
                            NavigateUrl='<%# Eval("id", "Mail.aspx?mid={0}") %>' Text="查看"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="type" HeaderText="类型" SortExpression="type" />
                <asp:BoundField DataField="email" HeaderText="收件人邮箱" SortExpression="email" />
                <asp:BoundField DataField="time" HeaderText="时间" SortExpression="time" />
                <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="学生姓名" 
                    SortExpression="user.showname">
                    <EditItemTemplate>
                        <asp:DynamicControl ID="DynamicControl1" runat="server" 
                            DataField="user.showname" Mode="Edit" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("user.showname") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </cc1:WidgetPanel>
    <cc1:WidgetPanel ID="WidgetPanel3" runat="server" Text="其他操作">
        <asp:Button ID="Button1" runat="server" Text="全部清空" onclick="Button1_Click" />
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableDelete="True" 
        EntityTypeName="" OrderBy="time desc" TableName="msg_mails" 
        Where="@type==&quot;&quot;||type == @type">
        <WhereParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="type" 
                PropertyName="SelectedValue" Type="String" 
                ConvertEmptyStringToNull="False" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        Select="new (type)" TableName="msg_mails" 
        onselecting="LinqDataSource2_Selecting">
    </asp:LinqDataSource>
</asp:Content>
