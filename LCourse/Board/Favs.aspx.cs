using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class Fav : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HiddenField1.Value = Page.User.Identity.Name;
                Page.DataBind();
            }
        }
        public static string CutString(string str, int l)
        {
            if (str.Length > l)
            {
                return str.Substring(0, l) + "...";
            }
            return str;
        }
    }
}