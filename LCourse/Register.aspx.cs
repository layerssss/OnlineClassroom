using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
        {
            Literal err = (Literal)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("ErrorMessage0");
            try
            {
                if (((string)Session["checkcode"]).ToLower() != ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBox4")).Text.ToLower())
                {
                    err.Text = "验证码错误";
                    err.Visible = true;
                    e.Cancel = true;
                    return;
                }
            }
            catch
            {
                err.Text = "验证码超时";
                err.Visible = true;
                e.Cancel = true;
                return;
            }
            DataClasses1DataContext d = new DataClasses1DataContext();
            var stds = d.stdprof.Where(ts => ts.name == ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBox2")).Text && ts.stdno == ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBox3")).Text);
            if (stds.Count() == 0)
            {
                err.Text = "找不到你输入的真实姓名或学号，如确认无误后仍出现此提示请联系老师添加你的资料";
                err.Visible = true;
                e.Cancel = true;
                return;
            }
            
        }

        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            var stds = d.stdprof.Where(ts => ts.name == ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBox2")).Text && ts.stdno == ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("TextBox3")).Text);
            var std = stds.First();
            var user = new user()
            {
                showname = std.name,
                aspnetdb_uname = ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("UserName")).Text,
                stno = std.stdno,
                class_id = std.class_id,
                lastaccesstime = DateTime.Now,
                mail = ((TextBox)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Email")).Text,
            };
            foreach (coursework c in std.@class.coursework)
            {
                d.coursework_submission.InsertOnSubmit(new coursework_submission()
                {
                    content = "",
                    coursework_id = c.id,
                    review = "",
                    user = user
                });
            }
            d.user.InsertOnSubmit(user);
            d.stdprof.DeleteOnSubmit(std);
            d.SubmitChanges();
            Transactions.SendEmail(d, "用户注册通知", "欢迎加入课程网站", "收到这封邮件说明你能够收到系统的通知了，以后请留意系统的通知。", user);
            d.SubmitChanges();
        }
    }
}