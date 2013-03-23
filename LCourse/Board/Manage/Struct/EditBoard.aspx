<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Board.master" AutoEventWireup="true" CodeBehind="EditBoard.aspx.cs" Inherits="LCourse.Board.Manage.Struct.EditBoard" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc1:WidgetPanel ID="WidgetPanel1" runat="server" Text="编辑板块">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" 
        DataSourceID="LinqDataSource2" DefaultMode="Edit" RenderOuterTable="False" 
        onmodechanging="FormView1_ModeChanging">
        <EditItemTemplate>
            版块标题：
            <br /><asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' 
                Width="100%" />
            <br />
            版块介绍：
            <br />
            <asp:TextBox ID="textTextBox" runat="server" Rows="10" 
                Text='<%# Bind("text") %>' TextMode="MultiLine" Width="100%" />
            <br />
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" Font-Size="XX-Small" CssClass="button"  CausesValidation="True" 
                CommandName="Update" Text="更新" />
            &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" Font-Size="XX-Small" CssClass="button" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </EditItemTemplate>
    </asp:FormView>
    </cc1:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableUpdate="True" 
        EntityTypeName="" TableName="board" Where="id == @id">
        <WhereParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="bid" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>
