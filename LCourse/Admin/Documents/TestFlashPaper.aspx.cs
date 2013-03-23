using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Documents
{
    public partial class TestFlashPaper : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            System.IO.File.Delete(Server.MapPath("/Documents/test.docx.flashpaper.version"));
            Response.Redirect("/Private/LoadDocument.aspx?path=" + Server.UrlEncode("/test.docx"));
        }
    }
}