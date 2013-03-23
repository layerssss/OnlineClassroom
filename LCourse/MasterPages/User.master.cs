using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.MasterPages
{
    public partial class User : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Literal1.Text = "欢迎" ;
            try
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                Literal1.Text += "：" + d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name).showname;
            }
            catch { }
        }
    }
}