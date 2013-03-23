using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.CourseWorks
{
    public partial class NewCourseWork : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var c = new coursework()
                {
                    time = DateTime.Now,
                    content = TextBox1.Text,
                    title = TextBox2.Text,
                    uploadext=TextBox3.Text,
                    class_id = Convert.ToInt32(DropDownList1.SelectedValue)
                };
                d.coursework.InsertOnSubmit(c);
                IEnumerable<user> stds = d.user.Where(tu => tu.class_id.ToString() == DropDownList1.SelectedValue);
                foreach (user std in stds)
                {
                    var s = new coursework_submission()
                    {
                        coursework = c,
                        user_id = std.id,
                        content = "",
                        review = ""
                    };
                    d.coursework_submission.InsertOnSubmit(s);
                    d.SubmitChanges();

                    Transactions.SendEmail(d, "新作业通知", "我有新的作业了","作业标题："+ Server.HtmlEncode(c.title) + "<br/>作业内容：" + c.content + "<br/><a target=\"_blank\" href=\"" + Server.HtmlEncode(Transactions.Setting_SysRootURI + "Courseworks/Coursework.aspx?sid=" + s.id) + "\">去完成这个作业</a>", std);
                }
                d.SubmitChanges();
                throw (new Exception("布置成功，并且向所有学生发送了通知"));
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function(){$(document.createElement(\"div\")).appendTo(\"body\").html(\"<br />" + Server.HtmlEncode(ex.Message) + "\").dialog({modal:true,title:'提示',buttons:{'确定':function(){location.href='';}}});});", true);
            }
        }
    }
}