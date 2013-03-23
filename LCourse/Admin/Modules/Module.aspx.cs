using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Modules
{
    public partial class Module : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LinqDataSource3_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            DataClasses1DataContext d=new DataClasses1DataContext();
            e.Result = d.module_location.Where(tl => !tl.module_deploy.Any(td => td.article_id == Convert.ToInt32(Request.QueryString["aid"])));
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.module_deploy.InsertOnSubmit(new module_deploy()
            {
                article_id = Convert.ToInt32(Request.QueryString["aid"]),
                location_id = Convert.ToInt32(DropDownList1.SelectedValue)
            });
            d.SubmitChanges();
            Page.DataBind();
        }

        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            DropDownList1.DataBind();
        }

    }
}