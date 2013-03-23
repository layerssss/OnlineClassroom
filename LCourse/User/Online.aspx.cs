using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.User
{
    public partial class Online : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            var onl = d.user.Where(tu => (DateTime.Now - tu.lastaccesstime).TotalSeconds < 20);
            string str = "[";
            foreach (user us in onl)
            {
                str+="{\"showname\":\"";
                str+=us.showname;
                str+="\",\"id\":";
                str+=us.id.ToString();
                str += "},";
            }
            str = str.TrimEnd(',');
            str += "]";
            Response.Write(str);
            Response.AddHeader("Content-Type", "application/json");
        }
    }
}