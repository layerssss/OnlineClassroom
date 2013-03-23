using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Students
{
    public partial class Classes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.@class.InsertOnSubmit(new @class() { name = "新班级" });
            d.SubmitChanges();
            Page.DataBind();
        }

        protected void LinqDataSource1_Deleted(object sender, LinqDataSourceStatusEventArgs e)
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