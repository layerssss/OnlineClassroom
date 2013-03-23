using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class Chat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.chat_logon.DeleteAllOnSubmit(d.chat_logon.Where(tl => (DateTime.Now - tl.lastaccesstime.Value).TotalSeconds > 3));
            d.SubmitChanges();
            var u = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name);
            var ll = d.chat_logon.Where(tl => tl.user_id == u.id);
            if (ll.Any())
            {
                Response.Redirect("/Error.aspx?message=" + Server.HtmlEncode("你已经打开了一个实时讨论窗口，请勿同时打开多个实时讨论窗口"));
            }
            else
            {
                var newl = new chat_logon()
                {
                    lastaccesstime = DateTime.Now,
                    user_id = u.id
                };
                d.chat_msg.InsertOnSubmit(new chat_msg()
                {
                    content ="登录成功！点击右上角的“在线”按钮可以随时查看在线名单",
                    chat_logon=newl
                });
                d.chat_logon.InsertOnSubmit(newl);
                d.SubmitChanges();
                textLID.Text = newl.id.ToString();
            }
        }
    }
}