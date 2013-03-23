using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.User
{
    public partial class Mail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            var m = d.msg_mails.First(tm => tm.id == Convert.ToInt32(Request.QueryString["mid"]));
            Label1.Text = m.email;
            Label2.Text = m.time.ToString();
            WidgetPanel2.Text = m.title;
            Literal2.Text = m.subject;
        }
    }
}