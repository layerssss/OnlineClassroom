<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Messages.master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="LCourse.Admin.Messages.Error" %>
<%@ Register assembly="CustomControl" namespace="CustomControl" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:FormView RenderOuterTable="false" ID="FormView1" runat="server" DataKeyNames="id" 
        DataSourceID="LinqDataSource1">
        <EditItemTemplate>
            id:
            <asp:Label ID="idLabel1" runat="server" Text='<%# Eval("id") %>' />
            <br />
            time:
            <asp:TextBox ID="timeTextBox" runat="server" Text='<%# Bind("time") %>' />
            <br />
            content:
            <asp:TextBox ID="contentTextBox" runat="server" Text='<%# Bind("content") %>' />
            <br />
            rawurl:
            <asp:TextBox ID="rawurlTextBox" runat="server" Text='<%# Bind("rawurl") %>' />
            <br />
            ip:
            <asp:TextBox ID="ipTextBox" runat="server" Text='<%# Bind("ip") %>' />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="更新" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </EditItemTemplate>
        <InsertItemTemplate>
            time:
            <asp:TextBox ID="timeTextBox" runat="server" Text='<%# Bind("time") %>' />
            <br />
            content:
            <asp:TextBox ID="contentTextBox" runat="server" Text='<%# Bind("content") %>' />
            <br />
            rawurl:
            <asp:TextBox ID="rawurlTextBox" runat="server" Text='<%# Bind("rawurl") %>' />
            <br />
            ip:
            <asp:TextBox ID="ipTextBox" runat="server" Text='<%# Bind("ip") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="插入" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </InsertItemTemplate>
        <ItemTemplate>
            <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="时间">
                <asp:Label ID="timeLabel" runat="server" Text='<%# Bind("time") %>' />
            </cc1:WidgetPanel>
            <cc1:WidgetPanel ID="WidgetPanel2" runat="server" Text="错误信息">
                <asp:Literal ID="contentLabel" runat="server" Text='<%# Bind("content") %>' 
                    Mode="PassThrough" />
            </cc1:WidgetPanel>
            <cc1:WidgetPanel ID="WidgetPanel3" runat="server" Text="原始URL">
                <asp:Label ID="rawurlLabel" runat="server" Text='<%# Bind("rawurl") %>' />
            </cc1:WidgetPanel>
            <cc1:WidgetPanel ID="WidgetPanel4" runat="server" Text="IP">
                <asp:Label ID="ipLabel" runat="server" Text='<%# Bind("ip") %>' />
            </cc1:WidgetPanel>
            <br />

        </ItemTemplate>
    </asp:FormView>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="msg_error" Where="id == @id">
        <WhereParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="eid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
