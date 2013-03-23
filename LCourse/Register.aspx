<%@ Page Title="用户注册" Language="C#" MasterPageFile="~/MasterPages/User.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LCourse.Register" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainPlaceHolder" runat="server">
   <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 
        oncreateduser="CreateUserWizard1_CreatedUser" 
        oncreatinguser="CreateUserWizard1_CreatingUser">
        <LayoutTemplate><div class="widget">
        <div class="widget-header">注册新用户</div>
        <div class="widget-content">
        <div id="wizardStepPlaceholder" runat="server"></div></div>
        <div class="widget-content">
        <div id="navigationPlaceholder" runat="server"></div></div>
        </div>
        </LayoutTemplate>
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                <ContentTemplate>
                    <table width="98%">
                        <tr>
                            <td align="right">
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">用户名:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                    ControlToValidate="UserName" ErrorMessage="必须填写“用户名”。" ToolTip="必须填写“用户名”。" 
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">密码:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                    ControlToValidate="Password" ErrorMessage="必须填写“密码”。" ToolTip="必须填写“密码”。" 
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" 
                                    AssociatedControlID="ConfirmPassword">确认密码:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" 
                                    ControlToValidate="ConfirmPassword" ErrorMessage="必须填写“确认密码”。" 
                                    ToolTip="必须填写“确认密码”。" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">电子邮件:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Email" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" 
                                    ControlToValidate="Email" ErrorMessage="必须填写“电子邮件”。" ToolTip="必须填写“电子邮件”。" 
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question">安全提示问题:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Question" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="QuestionRequired" runat="server" 
                                    ControlToValidate="Question" ErrorMessage="必须填写“安全提示问题”。" 
                                    ToolTip="必须填写“安全提示问题”。" ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer">安全答案:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Answer" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="AnswerRequired" runat="server" 
                                    ControlToValidate="Answer" ErrorMessage="必须填写“安全答案”。" ToolTip="必须填写“安全答案”。" 
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right">
                                真实姓名：</td>
                            <td>
                                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="AnswerRequired0" runat="server" 
                                    ControlToValidate="TextBox2" ErrorMessage="必须填写“真实姓名”" ToolTip="必须填写“真实姓名”" 
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                学号：</td>
                            <td>
                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="AnswerRequired1" runat="server" 
                                    ControlToValidate="TextBox3" ErrorMessage="必须填写“学号”。" ToolTip="必须填写“学号”。" 
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                验证码：</td>
                            <td>
                                <asp:TextBox ID="TextBox4" runat="server" Width="74px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="AnswerRequired2" runat="server" 
                                    ControlToValidate="TextBox4" ErrorMessage="必须填写“验证码”。" ToolTip="必须填写“验证码”。" 
                                    ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                               <a href="#" onclick="$('#checkcode').attr('src',$('#checkcode').attr('src')+'1');return false"><img alt="点击刷新验证码" src="/Checkcode.aspx?1" style="border:none;" id="checkcode" /></a></td>
                            <td>
                               (字母，不区分大小写)</td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:CompareValidator ID="PasswordCompare" runat="server" 
                                    ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                    Display="Dynamic" ErrorMessage="“密码”和“确认密码”必须匹配。" 
                                    ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="color:Red;">
                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                                <asp:Literal ID="ErrorMessage0" runat="server"></asp:Literal>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:CreateUserWizardStep>
            <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" >
                <ContentTemplate>
                    <div id="dialog"><table width="98%">
                        <tr>
                            <td align="center" colspan="2">
                                完成</td>
                        </tr>
                        <tr>
                            <td>
                                已成功创建您的帐户。</td>
                        </tr>
                    </table></div>
                    <script type="text/javascript" language="javascript">
                        $(function () {
                            var msg = $("#dialog").hide();
                            msgBox(msg.html(), function () { location.href = "/"; });
                        });
                    </script>
                </ContentTemplate>
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>
