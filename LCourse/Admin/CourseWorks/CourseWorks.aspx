<%@ Page Title="" Language="C#" ValidateRequest="false" MasterPageFile="~/Admin/MasterPages/CourseWorks.master" AutoEventWireup="true" CodeBehind="CourseWorks.aspx.cs" Inherits="LCourse.Admin.CourseWorks.CourseWorks" %>

<%@ Register Assembly="CustomControl" Namespace="CustomControl" TagPrefix="cc2" %>
<%@ Register assembly="LCourse" namespace="LCourse" tagprefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <cc2:WidgetPanel ID="WidgetPanel2" runat="server" Text="选择作业">班级：<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
        DataSourceID="LinqDataSource1" DataTextField="name" DataValueField="id" 
        onselectedindexchanged="DropDownList1_SelectedIndexChanged">
    </asp:DropDownList>
        <br />
        作业：<asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
        DataSourceID="LinqDataSource2"  DataTextField="title" DataValueField="id" 
        onselectedindexchanged="DropDownList2_SelectedIndexChanged">
    </asp:DropDownList>
    </cc2:WidgetPanel>
    <cc2:WidgetPanel ID="WidgetPanel1" Text="作业详情" runat="server">
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="id" 
        DataSourceID="LinqDataSource4" Width="98%">
        <EditItemTemplate>
            标题:
            <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' />
            <br />
            <asp:TextBox ID="contentTextBox" runat="server" ClientIDMode="Static" Text='<%# Bind("content") %>' 
                TextMode="MultiLine" />
                <script src="/Admin/Documents/ckfinder/ckfinder.js" type="text/javascript"></script>
    <script src="/Admin/ckeditor/ckeditor.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
    $(function () {
        CKFinder.setupCKEditor(CKEDITOR.replace("contentTextBox", {
            resize_dir: "vertical",
            resize_enabled: true,
            height: "200px",
            width: "98%",
            fullPage: false
        }), {
            basePath: '/Admin/Documents/ckfinder/',
            rememberLastFolder: false
        }, "嵌入图片", "嵌入Flash");
    });
</script>
            <br />
            <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="更新" />
&nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                CommandName="Cancel" Text="取消" />
        </EditItemTemplate>
        <InsertItemTemplate>
            content:
            <asp:TextBox ID="contentTextBox" runat="server" Text='<%# Bind("content") %>' />
            <br />
            time:
            <asp:TextBox ID="timeTextBox" runat="server" Text='<%# Bind("time") %>' />
            <br />
            class_id:
            <asp:TextBox ID="class_idTextBox" runat="server" 
                Text='<%# Bind("class_id") %>' />
            <br />
            title:
            <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>' />
            <br />
            coursework_submission:
            <asp:TextBox ID="coursework_submissionTextBox" runat="server" 
                Text='<%# Bind("coursework_submission") %>' />
            <br />
            class:
            <asp:TextBox ID="classTextBox" runat="server" Text='<%# Bind("class") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="插入" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="取消" />
        </InsertItemTemplate>
        <ItemTemplate>
            <h3> 布置时间:
            <asp:Label ID="timeLabel" runat="server" Text='<%# Bind("time") %>' /></h3>
             <h3> 完成情况(概况)：<asp:Label ID="Label5" runat="server" 
                Text='<%# this.GetSubmissionStatus(Eval("coursework_submission")) %>'></asp:Label></h3>
             <h3>标题:
            <asp:Label ID="titleLabel" runat="server" Text='<%# Bind("title") %>' /> </h3>
            <asp:Literal ID="Literal1" runat="server" Mode="PassThrough" 
                Text='<%# Eval("content") %>'></asp:Literal>
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# "/Admin/CourseWorks/GetUploads.aspx?path="+Server.UrlEncode(LCourse.Transactions.GetAbsSubmissionsUploadRoot()+(string)Eval("class.name")+"\\"+(string)Eval("title")+"\\") %>' 
                        Text='<%# Eval("uploadext","打包下载该次作业所有格式为{0}的附件") %>'></asp:HyperLink><br />
            <asp:Button ID="EditButton" runat="server" CausesValidation="False" 
                CommandName="Edit" Text="编辑" />
        </ItemTemplate>
    </asp:FormView>
    </cc2:WidgetPanel>
    <cc2:WidgetPanel ID="WidgetPanel3" Text="作业完成情况（每次批阅都会发邮件通知学生，并且学生将不能再更改回答）" runat="server">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="LinqDataSource3" AllowPaging="True" 
            AllowSorting="True" BorderColor="Black" BorderStyle="Solid" 
            BorderWidth="3px" PageSize="20" onrowupdated="GridView1_RowUpdated">
        <Columns>
            <asp:CommandField EditText="批阅" ShowEditButton="True" UpdateText="确定" 
                ButtonType="Button" >
            <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" 
                Width="35px" />
            </asp:CommandField>
            <asp:TemplateField HeaderText="姓名" SortExpression="user.showname">
                <EditItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("user.showname") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("user.showname") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" 
                    Width="60px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="学号" SortExpression="user.stno">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("user.stno") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("user.stno") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" 
                    Width="90px" />
            </asp:TemplateField>
            <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="回答" 
                SortExpression="content">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Server.HtmlEncode((string)Eval("content")).Replace("\n","<br/>") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Server.HtmlEncode((string)Eval("content")).Replace("\n","<br/>") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
            </asp:TemplateField>
            <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="附件上传时间">
                <EditItemTemplate>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#GetUploadNav(Eval("user"),Eval("coursework")) %>' Text='<%#GetUploadStatus(Eval("user"),Eval("coursework")) %>'></asp:HyperLink>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#GetUploadNav(Eval("user"),Eval("coursework")) %>' Text='<%#GetUploadStatus(Eval("user"),Eval("coursework")) %>'></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
            </asp:TemplateField>
            <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="批阅" 
                SortExpression="review">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" TextMode="MultiLine" runat="server" 
                        Text='<%# Bind("review") %>' Height="170px" Width="375px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Server.HtmlEncode((string)Eval("review")).Replace("\n","<br/>") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle BorderColor="#333333" BorderStyle="Solid" BorderWidth="1px" />
            </asp:TemplateField>
        </Columns>
        <RowStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" />
    </asp:GridView>
    <asp:LinqDataSource ID="LinqDataSource3" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="coursework_submission" Where="coursework_id == @coursework_id" 
        EnableUpdate="True">
        <WhereParameters>
            <asp:ControlParameter ControlID="DropDownList2" Name="coursework_id" 
                PropertyName="SelectedValue" DefaultValue="0" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
            <asp:ScriptManager runat="server">
            </asp:ScriptManager></ContentTemplate>
        </asp:UpdatePanel>
    </cc2:WidgetPanel>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="class">
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource2" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EntityTypeName="" 
        TableName="coursework" Where="class_id == @class_id" 
        Select="new(title+&quot;(&quot;+time+&quot;布置)&quot; as title,id) " >
        <WhereParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="class_id" 
                PropertyName="SelectedValue" DefaultValue="0" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="LinqDataSource4" runat="server" 
        ContextTypeName="LCourse.DataClasses1DataContext" EnableUpdate="True" 
        EntityTypeName="" TableName="coursework" Where="id == @id">
        <WhereParameters>
            <asp:ControlParameter ControlID="DropDownList2" DefaultValue="0" Name="id" 
                PropertyName="SelectedValue" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</asp:Content>
