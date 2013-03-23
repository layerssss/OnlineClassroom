using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class DelFav : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.fav.DeleteAllOnSubmit(d.fav.Where(tf => tf.user.aspnetdb_uname == Page.User.Identity.Name && tf.post_id == Convert.ToInt32(Request.QueryString["pid"])));
            d.SubmitChanges();

            Response.Redirect(Request.UrlReferrer.ToString());
        }
    }
}