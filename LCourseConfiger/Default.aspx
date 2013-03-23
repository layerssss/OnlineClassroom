<%@ Page Title="主页" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="LCourseConfiger._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        欢迎使用 ASP.NET!
    </h2>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="key" DataSourceID="SqlDataSource1" AllowSorting="True" 
            Width="852px">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="key" HeaderText="key" ReadOnly="True" 
                    SortExpression="key" />
                <asp:TemplateField HeaderText="value" SortExpression="value">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("value") %>' 
                            Width="600px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("value") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        键：<asp:TextBox ID="TextBox1" runat="server" Width="380px"></asp:TextBox>
    </p>
    <p>
        值：<asp:TextBox ID="TextBox3" runat="server" Width="380px"></asp:TextBox>
    </p>
    <p>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="新建" />
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="保存" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConflictDetection="CompareAllValues" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            DeleteCommand="DELETE FROM [config] WHERE [key] = @original_key AND (([value] = @original_value) OR ([value] IS NULL AND @original_value IS NULL))" 
            InsertCommand="INSERT INTO [config] ([key], [value]) VALUES (@key, @value)" 
            OldValuesParameterFormatString="original_{0}" 
            SelectCommand="SELECT * FROM [config]" 
            UpdateCommand="UPDATE [config] SET [value] = @value WHERE [key] = @original_key AND (([value] = @original_value) OR ([value] IS NULL AND @original_value IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_key" Type="String" />
                <asp:Parameter Name="original_value" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox1" ConvertEmptyStringToNull="False" 
                    Name="key" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBox3" ConvertEmptyStringToNull="False" 
                    Name="value" PropertyName="Text" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="value" Type="String" />
                <asp:Parameter Name="original_key" Type="String" />
                <asp:Parameter Name="original_value" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        密码：<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </p>
    <p>
        <asp:FileUpload ID="FileUpload1" runat="server" />
        <asp:Button ID="Button3" runat="server" onclick="Button3_Click" Text="打开" />
    </p>
<p>
        若要了解关于 ASP.NET 的详细信息，请访问 <a href="http://www.asp.net/cn" title="ASP.NET 网站">www.asp.net/cn</a>。
    </p>
    <p>
        您还可以找到 <a href="http://go.microsoft.com/fwlink/?LinkID=152368"
            title="MSDN ASP.NET 文档">MSDN 上有关 ASP.NET 的文档</a>。
    </p>
</asp:Content>
