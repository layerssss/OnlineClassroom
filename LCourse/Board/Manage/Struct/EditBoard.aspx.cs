using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board.Manage.Struct
{
    public partial class EditBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HiddenField1.Value = Request.UrlReferrer.ToString();
            }
        }

        protected void FormView1_ModeChanging(object sender, FormViewModeEventArgs e)
        {
            Response.Redirect(HiddenField1.Value);
        }
    }
}