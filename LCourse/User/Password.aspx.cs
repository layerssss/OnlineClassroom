using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.User
{
    public partial class Password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                TextBox1.Text = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name).mail;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var u = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name);
                u.mail = TextBox1.Text;
                d.SubmitChanges();
                Transactions.SendEmail(d, "邮箱更改通知", "我的邮箱已更改", "收到这封邮件说明你已经能够接收系统的通知了", u);
                d.SubmitChanges();
                throw (new Exception("修改成功"));
            }
            catch(Exception ex){
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function(){$(document.createElement(\"div\")).appendTo(\"body\").html(\"<br />" + Server.HtmlEncode(ex.Message) + "\").dialog({modal:true,title:'提示',buttons:{'确定':function(){$(this).dialog('close');}}});});", true);
            }
        }

        protected void ChangePassword1_ChangedPassword(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function(){msgBox('密码修改成功',function(){location.href='Password.aspx';});});", true);
        }
    }
}