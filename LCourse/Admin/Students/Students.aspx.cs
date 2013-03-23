using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Students
{
    public partial class Students : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e){
        }


        protected void Button1_Click(object sender, EventArgs e)
        {
            GridView1.DataBind();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.stdprof.InsertOnSubmit(new stdprof()
            {
                class_id = Convert.ToInt32(DropDownList2.SelectedValue),
                name = "新学生",
                stdno = "0000000000"
            });
            d.SubmitChanges();
            GridView2.DataBind();
        }

        protected void LinqDataSource2_Deleted(object sender, LinqDataSourceStatusEventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            while (true)
            {
                bool found = false;
                var users = System.Web.Security.Membership.GetAllUsers();
                foreach (System.Web.Security.MembershipUser user in users)
                {
                    if (!d.user.Any(tu => tu.aspnetdb_uname == user.UserName))
                    {
                        found = true;
                        System.Web.Security.Membership.DeleteUser(user.UserName);
                        break;
                    }
                }
                if (!found)
                {
                    break;
                }
            }
        }

    }
}