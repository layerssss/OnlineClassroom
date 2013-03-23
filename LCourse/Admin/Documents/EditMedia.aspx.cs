using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Documents
{
    public partial class EditMedia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string[] strs = System.IO.File.ReadAllLines(Server.MapPath(Request.QueryString["path"]));
                TextBox1.Text = strs[0].Substring(Transactions.Const_MediaPrefix.Length, strs[0].Length - Transactions.Const_MediaPrefix.Length - Transactions.Const_MediaPostfix.Length);
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            System.IO.File.WriteAllLines(Server.MapPath(Request.QueryString["path"]), new string[] { Transactions.Const_MediaPrefix + TextBox1.Text + Transactions.Const_MediaPostfix });
            Transactions.MessageBox(this.Page, "修改成功", "window.close();", "提示");
        }
    }
}