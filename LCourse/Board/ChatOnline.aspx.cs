using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class ChatOnline : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            DataClasses1DataContext d = new DataClasses1DataContext();
            string str = "[";
            foreach (chat_logon lo in d.chat_logon)
            {
                var us = lo.user;
                str += "{\"showname\":\"";
                str += us.showname;
                str += "\",\"id\":";
                str += us.id.ToString();
                str += "},";
            }
            str = str.TrimEnd(',');
            str += "]";
            Response.Write(str);
            Response.AddHeader("Content-Type", "application/json");
        }
    }
}