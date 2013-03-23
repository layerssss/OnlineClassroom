using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Documents
{
    public partial class NewHtmlPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                System.IO.FileInfo file = new System.IO.FileInfo(Server.MapPath(Request.QueryString["url"]));
                if (file.Exists)
                {
                    throw (new Exception(Server.HtmlEncode("“" + Request.QueryString["url"] + "”") + "已经存在！"));
                }
                System.IO.File.WriteAllText(file.FullName, "<p></p>");
                throw (new Exception(Server.HtmlEncode("“"+Request.QueryString["url"]+"”") + "创建成功！"));
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            Response.End();
        }
    }
}