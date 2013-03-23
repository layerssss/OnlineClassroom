using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.MasterPages
{
    public partial class Board : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();

            HyperLink4.NavigateUrl = "/Board/Class.aspx?cid=" + d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name).class_id;
        }
    }
}