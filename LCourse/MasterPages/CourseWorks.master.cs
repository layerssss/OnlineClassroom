using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.MasterPages
{
    public partial class CourseWorks : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HiddenField1.Value = Page.User.Identity.Name;
            DataList1.DataBind();
        }
    }
}