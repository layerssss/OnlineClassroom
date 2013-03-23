<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Students.master" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="LCourse.Admin.Students.Students" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <cc2:WidgetPanel ID="WidgetPanel2" runat="server" Text="已注册学生">
    <cc2:WidgetPanel  Text="筛选条件" ID="WidgetPanel1" runat="server"><asp:CheckBox ID="CheckBox1" runat="server" Text="班级" />
    <asp:DropDownList ID="DropDownList1" runat="server" 
        DataSourceID="LinqDataSource1" DataTextField="name" DataValueField="id">
    </asp:DropDownList>
    <br />
    <asp:CheckBox ID="CheckBox2" runat="server" Text="姓名的一部分" />
    <asp:TextBox ID="TextBox1" runat="server" Width="103px"></asp:TextBox>
    <br />
    <asp:Button ID="Button1" runat="server" Text="筛选" onclick="Button1_Click" />
    </cc2:WidgetPanel><asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="LinqDataSource2" AllowPaging="True" 
        AllowSorting="True">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:HyperLinkField DataNavigateUrlFields="id" 
                DataNavigateUrlFormatString="StudentMail.aspx?uid={0}" Text="个人通知" />
            <asp:BoundField DataField="showname" HeaderText="姓名" 
                SortExpression="showname" />
            <asp:BoundField DataField="stno" HeaderText="学号" SortExpression="stno" />
            <asp:TemplateField HeaderText="班级" SortExpression="class_id">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("class.name") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("class.name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="mail" HeaderText="电子邮箱" 
                SortExpression="mail" />
            <asp:BoundField DataField="aspnetdb_uname" HeaderText="登录用户名" 
                SortExpression="aspnetdb_uname" ReadOnly="True" />
            <asp:BoundField DataField="onlinecount" HeaderText="上线次数" 
                SortExpression="onlinecount" ReadOnly="True" />
            <asp:TemplateField HeaderText="讨论区主题" SortExpression="post.Count">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("post.Count") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("post.Count") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="讨论区回复" SortExpression="reply.Count">
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("reply.Count") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("reply.Count") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="id" 
                DataNavigateUrlFormatString="Student.aspx?uid={0}" Text="作业/其他" />
        </Columns>
    </asp:GridView>
    
    </cc2:WidgetPanel>
    
    <cc2:WidgetPanel ID="WidgetPanel3" runat="server" Text="未注册学生">
    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" 
        DataSourceID="LinqDataSource3">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
            <asp:BoundField DataField="stdno" HeaderText="学号" SortExpression="stdno" />
            <asp:TemplateField HeaderText="班级" SortExpression="class.name">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("class.name") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("class.name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    在<asp:DropDownList ID="DropDownList2" runat="server" 
        DataSourceID="LinqDataSource1" DataTextField="name" DataValueField="id">
    </asp:DropDownList>
    <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
        Text="添加未注册学生" />
    </cc2:WidgetPanel>
    
    <cc2:WidgetPanel ID="WidgetPanel4" runat="server" Text="批量添加学生">
    
    </cc2:WidgetPanel>
    <br />
    <br />
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="class">
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableDelete="True" 
        EnableUpdate="True" EntityTypeName="" Where="(showname.Contains(@showname)||!@c2) &amp;&amp; (class_id == @class_id ||!@c1)" TableName="user" 
        ondeleted="LinqDataSource2_Deleted">
        <WhereParameters>
        
            <asp:ControlParameter ControlID="TextBox1" ConvertEmptyStringToNull="false" Name="showname" PropertyName="Text" 
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="class_id" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="CheckBox1" Name="c1" PropertyName="Checked" />
            <asp:ControlParameter ControlID="CheckBox2" Name="c2" PropertyName="Checked" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource3" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableDelete="True" 
        EnableUpdate="True" EntityTypeName="" TableName="stdprof">
    </asp:LinqDataSource>
</asp:Content>
