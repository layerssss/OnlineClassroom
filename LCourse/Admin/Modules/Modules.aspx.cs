using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Modules
{
    public partial class Modules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public static String GetDeployString(object obj, int maxlen)
        {
            var str = "";
            var ds = (IEnumerable<module_deploy>)obj;
            foreach (module_deploy d in ds)
            {
                str += d.module_location.name + "；";
            }
            return Board.Fav.CutString(str,maxlen);
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.module_article.InsertOnSubmit(new module_article()
            {
                title = "新模块",
                content = "",
                show = false,
                sort = ""
            });
            d.SubmitChanges();
            GridView1.DataBind();
        }
    }
}