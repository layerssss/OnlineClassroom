using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Statics
{
    public partial class Statics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.statics_item.InsertOnSubmit(new statics_item()
            {
                path = DropDownList1.SelectedItem.Value,
                name = DropDownList1.SelectedItem.Text
            });
            d.SubmitChanges();
            Page.DataBind();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.statics_visit.DeleteAllOnSubmit(d.statics_visit);
            d.SubmitChanges();
            Page.DataBind();
        }
    }
}