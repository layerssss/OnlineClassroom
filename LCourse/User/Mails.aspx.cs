using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.User
{
    public partial class Mails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HiddenField1.Value = Page.User.Identity.Name;
                GridView1.DataBind();
                HiddenFieldModules.Value = Request.Path.ToLower().TrimEnd('?');
                ListViewModules.DataBind();
            }
        }
    }
}