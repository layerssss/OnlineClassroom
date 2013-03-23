using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class ChatSend : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var ll = d.chat_logon.First(tl => tl.id == Convert.ToInt32(Request.Form["lid"]) && tl.user.aspnetdb_uname == Page.User.Identity.Name);
                foreach (var objl in d.chat_logon)
                {
                    d.chat_msg.InsertOnSubmit(new chat_msg()
                    {
                        logon_id = objl.id,
                        content = "["+DateTime.Now.ToShortTimeString()+"]"+ ll.user.showname + ":" + Server.HtmlEncode(Request.Form["content"])
                    });
                }
                d.SubmitChanges();
                Response.Write("SUCCESS");
            }
            catch {
                Response.Write("发送失败");
            }
        }
    }
}