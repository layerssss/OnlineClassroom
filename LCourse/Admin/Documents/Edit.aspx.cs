using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
namespace LCourse.Admin.Documents
{
    public partial class Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TextBox1.Text = File.ReadAllText(Server.MapPath(Request.QueryString["path"]));
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            System.IO.File.WriteAllText(Server.MapPath(Request.QueryString["path"]), TextBox1.Text);
            Transactions.MessageBox(this.Page, "修改成功", "window.close();", "提示");
        }
    }
}