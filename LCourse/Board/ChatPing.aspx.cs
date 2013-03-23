using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class ChatPing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var ll = d.chat_logon.First(tl => tl.id == Convert.ToInt32(Request.QueryString["lid"])&&tl.user.aspnetdb_uname==Page.User.Identity.Name);
                if (ll.chat_msg.Any())
                {
                    Response.Write("{\"msg\":\""+ll.chat_msg.First().content+"\"}");
                    d.chat_msg.DeleteOnSubmit(ll.chat_msg.First());
                    
                }
                else
                {
                    Response.Write("{\"msg\":null}");
                }
                ll.lastaccesstime = DateTime.Now;
                d.SubmitChanges();
            }
            catch {
                Response.Write("{\"msg\":\"登录已超时，请<a href='chat.aspx'>重新登录</a>！\"}");
            }
            Response.AddHeader("Content-Type", "application/json");
        }
    }
}