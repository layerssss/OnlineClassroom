using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class AddFav : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.fav.InsertOnSubmit(new fav()
            {
                user_id = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name).id,
                post_id = Convert.ToInt32(Request.QueryString["pid"])
            });
            d.SubmitChanges();
            Response.Redirect(Request.UrlReferrer.ToString());
        }
    }
}