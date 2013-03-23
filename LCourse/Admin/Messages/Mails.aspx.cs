using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Messages
{
    public partial class Mails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView1.DataBind();
        }

        protected void LinqDataSource2_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            var res = (from c in d.msg_mails select new { c.type }).Distinct();
            e.Result = res;
        }


        protected void DropDownList1_DataBound(object sender, EventArgs e)
        {

            DropDownList1.Items.Insert(0,new ListItem() { Text = "(全部)", Value = "" });
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.msg_mails.DeleteAllOnSubmit(d.msg_mails);
            d.SubmitChanges();
            Page.DataBind();
        }
    }
}