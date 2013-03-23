using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class ViewUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var u = d.user.First(tu => tu.id == Convert.ToInt32(Request.QueryString["uid"]));
                Label3.Text = u.showname;
                link4.Text = u.@class.name;
                link4.NavigateUrl = "Class.aspx?cid=" + u.class_id;
                Label5.Text = (DateTime.Now - u.lastaccesstime).TotalSeconds > 20 ? "离线" : "在线";
                HyperLink5.NavigateUrl = "javascript:openMsgWin(\"/User/Msg.aspx?uid=" + u.id + "\",270);";
            }
        }
    }
}