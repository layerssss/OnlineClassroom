using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.User
{
    public partial class Msg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                if (Request.QueryString["mid"] == null)
                {
                    this.Page.Title = WidgetPanel2.Text = "发送消息给：" + d.user.First(tu => tu.id == Convert.ToInt32(Request.QueryString["uid"])).showname;
                    WidgetPanel1.Visible = false;
                    HiddenField1.Value = Request.QueryString["uid"];
                }
                else
                {
                    user_msg msg = d.user_msg.First(tm => tm.id == Convert.ToInt32(Request.QueryString["mid"]));
                    if (Request.QueryString["delete"] == null)
                    {
                        this.Page.Title = WidgetPanel1.Text = "来自 " + msg.user1.showname + " 的消息("+msg.time+")";
                        Literal1.Text = Server.HtmlEncode(msg.content).Replace("\n", "<br/>") + "<br/>点此查看<a target='_blank' title='查看资料' href=\"/Board/ViewUser.aspx?uid="+msg.user1.id+"\">" + msg.user1.showname + "</a>的更多信息";
                        WidgetPanel2.Text = "回复消息给：" + msg.user1.showname;
                        HiddenField1.Value = msg.user1.id.ToString();
                    }
                    else
                    {
                        d.user_msg.DeleteAllOnSubmit(d.user_msg.Where(tm => tm.id == Convert.ToInt32(Request.QueryString["mid"])));
                        d.SubmitChanges();
                    }
                }
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            DataClasses1DataContext d = new DataClasses1DataContext();
            if (d.user.First(tu => tu.id == Convert.ToInt32(HiddenField1.Value)).aspnetdb_uname == Page.User.Identity.Name)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "close", "$(function(){alert('不可以给自己发送消息！');});", true);
                return;
            }
            if (d.user_msg.Any(tm=>tm.user1.aspnetdb_uname==Page.User.Identity.Name&&tm.user.id==Convert.ToInt32(HiddenField1.Value)))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "close", "$(function(){alert('对方还未查收你的上一条消息，在对方查收之前无法发送新消息，如果一直出现此提示，则对方可能已下线。');});", true);
                return;
            }
            d.user_msg.InsertOnSubmit(new user_msg()
            {
                from_user_id = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name).id,
                content = TextBox1.Text,
                time = DateTime.Now,
                user_id = Convert.ToInt32(HiddenField1.Value)
            });
            d.SubmitChanges();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "close", "window.close();", true);
        }
    }
}