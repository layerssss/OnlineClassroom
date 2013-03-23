using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board.Manage.Struct
{
    public partial class AddBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.board.InsertOnSubmit(new board() { title = TextBox2.Text,text="" });
            d.SubmitChanges();
            TextBox2.Text = "";
            DataBind();
        }
    }
}