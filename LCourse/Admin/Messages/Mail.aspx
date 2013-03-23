<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Messages.master" AutoEventWireup="true" CodeBehind="Mail.aspx.cs" Inherits="LCourse.Admin.Messages.Mail" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" 
        DataSourceID="LinqDataSource1" RenderOuterTable="False">
        <EditItemTemplate>
            id:
            <asp:Label ID="idLabel1" runat="server" Text='<%# Eval("id") %>' />
            <br />
            type:
            <asp:TextBox ID="typeTextBox" runat="server" Text='<%# Bind("type") %>' />
            email:
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
            <br />
            title:
            <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' />
            <br />
            subject:
            <asp:TextBox ID="subjectTextBox" runat="server" Text='<%# Bind("subject") %>' />
            <br />
            time:
            <asp:TextBox ID="timeTextBox" runat="server" Text='<%# Bind("time") %>' />
            <br />
            user_id:
            <asp:TextBox ID="user_idTextBox" runat="server" Text='<%# Bind("user_id") %>' />
            <br />
            user:
            <asp:TextBox ID="userTextBox" runat="server" Text='<%# Bind("user") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="更新" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </EditItemTemplate>
        <InsertItemTemplate>
            type:
            <asp:TextBox ID="typeTextBox" runat="server" Text='<%# Bind("type") %>' />
            <br />
            email:
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
            <br />
            title:
            <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' />
            <br />
            subject:
            <asp:TextBox ID="subjectTextBox" runat="server" Text='<%# Bind("subject") %>' />
            <br />
            time:
            <asp:TextBox ID="timeTextBox" runat="server" Text='<%# Bind("time") %>' />
            <br />
            user_id:
            <asp:TextBox ID="user_idTextBox" runat="server" Text='<%# Bind("user_id") %>' />
            <br />
            user:
            <asp:TextBox ID="userTextBox" runat="server" Text='<%# Bind("user") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="插入" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </InsertItemTemplate>
        <ItemTemplate>
            <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="类型">
            <asp:Label ID="typeLabel" runat="server" Text='<%# Bind("type") %>' />
            </cc1:WidgetPanel>
            <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="收件人邮箱">
            <asp:Label ID="emailLabel" runat="server" Text='<%# Bind("email") %>' />
            </cc1:WidgetPanel><cc1:WidgetPanel ID="WidgetPanel3" runat="server" Text="时间">
            <asp:Label ID="timeLabel" runat="server" Text='<%# Bind("time") %>' />
            </cc1:WidgetPanel><cc1:WidgetPanel ID="WidgetPanel4" runat="server" Text="学生姓名">
            <asp:Label ID="userLabel" runat="server" Text='<%# Bind("user.showname") %>' />
            </cc1:WidgetPanel><cc1:WidgetPanel ID="WidgetPanel6" runat="server" Text="学生学号">
            <asp:Label ID="Label1" runat="server" Text='<%# Bind("user.stno") %>' />
            </cc1:WidgetPanel><cc1:WidgetPanel ID="WidgetPanel5" runat="server" Text='<%# Bind("title") %>'>
            <asp:Literal Mode="PassThrough" ID="subjectLabel" runat="server" Text='<%# Bind("subject") %>' />
            </cc1:WidgetPanel>
        </ItemTemplate>
    </asp:FormView>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="msg_mails" Where="id == @id">
        <WhereParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="mid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
