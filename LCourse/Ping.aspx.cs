using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse
{
    public partial class Ping : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.User.Identity.IsAuthenticated)
            {
                return;
            }
            DataClasses1DataContext d = new DataClasses1DataContext();
            user u = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name);
            if ((DateTime.Now - u.lastaccesstime).TotalSeconds > 20)
            {
                u.onlinecount++;
            }
            u.lastaccesstime = DateTime.Now;
            d.SubmitChanges();
            Response.AddHeader("Content-Type", "application/json");
            if (u.user_msg.Any())
            {
                Response.Write("{\"id\":" + u.user_msg.First().id.ToString() + ",\"showname\":\"" + u.user_msg.First().user1.showname + "\"}");
            }
        }
    }
}