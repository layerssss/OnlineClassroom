using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class Class : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            WidgetPanel1.Text = d.@class.First(tc => tc.id == Convert.ToInt32(Request.QueryString["cid"])).name;
        }
    }
}