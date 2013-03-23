using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Students
{
    public partial class Student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var u = d.user.First(tu => tu.id == Convert.ToInt32(Request.QueryString["uid"]));
                Label3.Text = u.showname;
                Label4.Text = u.@class.name;
                Label5.Text = (DateTime.Now - u.lastaccesstime).TotalSeconds > 20 ? "离线" : "在线";
                Label6.Text = u.stno;
                Label7.Text = System.Web.Security.Membership.GetUser(u.aspnetdb_uname).Email;
                Label8.Text = u.aspnetdb_uname;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            DataClasses1DataContext d = new DataClasses1DataContext();
            var u = d.user.First(tu => tu.id == Convert.ToInt32(Request.QueryString["uid"]));
            string newpwd = System.Web.Security.Membership.GetUser(u.aspnetdb_uname).ResetPassword();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function(){$(document.createElement(\"div\")).appendTo(\"body\").html(\"<br />" + Server.HtmlEncode("密码重置成功,现在请记下新密码，新密码为：" + newpwd) + "\").dialog({modal:true,title:'提示',buttons:{'确定':function(){location.href='';}}});});", true);
        }
    }
}