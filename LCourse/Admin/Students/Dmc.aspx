<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPages/Students.master" AutoEventWireup="true" CodeBehind="Dmc.aspx.cs" Inherits="LCourse.Admin.Students.Dmc" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server"><asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            
            <cc1:WidgetPanel ID="WidgetPanel1" Text="第一步" runat="server">请复制点名册到此<br />
    <asp:TextBox ID="TextBox3" Width="95%" Rows="20" TextMode="MultiLine" runat="server"></asp:TextBox><br />
    <asp:Button ID="Button3" runat="server"
        Text="分析字段" onclick="Button3_Click" />
            </cc1:WidgetPanel>
            <cc1:WidgetPanel ID="WidgetPanel2" Text="第二步" runat="server">
    姓名字段：<asp:DropDownList ID="DropDownList1" runat="server">
    </asp:DropDownList><br />
    学号字段：<asp:DropDownList ID="DropDownList2" runat="server">
    </asp:DropDownList><br />
    班级字段：<asp:DropDownList ID="DropDownList3" runat="server">
    </asp:DropDownList><br />
    班级前缀：<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
    <asp:Button ID="Button1" runat="server" Text="生成添加指令" onclick="Button1_Click" 
                Enabled="False" />
            </cc1:WidgetPanel>
            <cc1:WidgetPanel ID="WidgetPanel3" Text="第三步" runat="server">已就绪添加指令：
    <asp:TextBox Width="95%" TextMode="MultiLine" Rows="20" ID="TextBox2" runat="server" 
                ReadOnly="True"></asp:TextBox>
    <asp:Button ID="Button2" runat="server" Text="确认批量添加" onclick="Button2_Click" 
                Enabled="False" />
            </cc1:WidgetPanel>
    <br />
    <br />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
