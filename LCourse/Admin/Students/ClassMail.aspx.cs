using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Students
{
    public partial class ClassMail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                WidgetPanel1.Text = "给" + d.@class.First(tc => tc.id == Convert.ToInt32(Request.QueryString["cid"])).name + "发送班级通知";

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            var users = d.@class.First(tc => tc.id == Convert.ToInt32(Request.QueryString["cid"])).user;
            foreach (var u in users)
            {
                Transactions.SendEmail(d, "班级通知", "我收到了来自老师的一份班级通知", TextBox1.Text, u);
            }
            d.SubmitChanges();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function(){$(document.createElement(\"div\")).appendTo(\"body\").html(\"<br />" + Server.HtmlEncode("发送成功") + "\").dialog({modal:true,title:'提示',buttons:{'确定':function(){location.href='';}}});});", true);
        }
    }
}