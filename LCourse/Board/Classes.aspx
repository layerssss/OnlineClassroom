<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Board.master" AutoEventWireup="true" CodeBehind="Classes.aspx.cs" Inherits="LCourse.Board.Classes" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="班级列表">
        <asp:ListView ID="FormView1" runat="server" 
    DataKeyNames="id" DataSourceID="LinqDataSource2">
            <EditItemTemplate>
                id:
                <asp:Label ID="idLabel1" runat="server" 
            Text='<%# Eval("id") %>' />
                <br />
                name:
                <asp:TextBox ID="nameTextBox" runat="server" 
            Text='<%# Bind("name") %>' />
                <br />
                coursework:
                <asp:TextBox ID="courseworkTextBox" runat="server" 
            Text='<%# Bind("coursework") %>' />
                <br />
                stdprof:
                <asp:TextBox ID="stdprofTextBox" runat="server" 
            Text='<%# Bind("stdprof") %>' />
                <br />
                user:
                <asp:TextBox ID="userTextBox" runat="server" 
            Text='<%# Bind("user") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" 
            CausesValidation="True" CommandName="Update" Text="更新" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
            CausesValidation="False" CommandName="Cancel" Text="取消" />
            </EditItemTemplate>
            <InsertItemTemplate>
                name:
                <asp:TextBox ID="nameTextBox" runat="server" 
            Text='<%# Bind("name") %>' />
                <br />
                coursework:
                <asp:TextBox ID="courseworkTextBox" runat="server" 
            Text='<%# Bind("coursework") %>' />
                <br />
                stdprof:
                <asp:TextBox ID="stdprofTextBox" runat="server" 
            Text='<%# Bind("stdprof") %>' />
                <br />
                user:
                <asp:TextBox ID="userTextBox" runat="server" 
            Text='<%# Bind("user") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" 
            CausesValidation="True" CommandName="Insert" Text="插入" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
            CausesValidation="False" CommandName="Cancel" Text="取消" />
            </InsertItemTemplate>
            <ItemTemplate>
                <asp:HyperLink ID="HyperLink5" runat="server" 
            NavigateUrl='<%# Eval("id", "Class.aspx?cid={0}") %>' 
            Text='<%# Eval("name") %>'></asp:HyperLink>
                <br />
            </ItemTemplate>
        </asp:ListView>
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        OrderBy="name" TableName="class">
    </asp:LinqDataSource>
</asp:Content>
