using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class Board : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d=new DataClasses1DataContext();
            this.Page.Title = "讨论：[" + d.board.First(tb => tb.id == Convert.ToInt32(Request.QueryString["bid"])).title + "]";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TextBox3.Text.Length < 5)
            {
                Transactions.MessageBox(this.Page,"标题长度必须大于5","","提示");
                return;
            }
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.post.InsertOnSubmit(new post()
            {
                user = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name),
                board_id = Convert.ToInt32(Request.QueryString["bid"]),
                text = TextBox2.Text,
                time = DateTime.Now,
                title=TextBox3.Text
            });
            d.SubmitChanges();
            DataBind();
            TextBox2.Text = "";
            TextBox3.Text = "";
        }
    }
}