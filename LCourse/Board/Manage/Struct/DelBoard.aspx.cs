using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board.Manage.Struct
{
    public partial class DelBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.board.DeleteOnSubmit(d.board.First(tb => tb.id.ToString() == Request.QueryString["bid"]));
            d.SubmitChanges();
            Response.Redirect(Request.UrlReferrer.ToString());
        }
    }
}