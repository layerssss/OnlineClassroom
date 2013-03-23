using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Private
{
    public partial class DownloadMedia : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.User.Identity.IsAuthenticated)
            {
                Response.Redirect("/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
            }
            string path = System.IO.File.ReadAllLines(Server.MapPath("/Documents/"+Request.QueryString["media"].TrimStart('.')))[0];
            path = path.Substring(Transactions.Const_MediaPrefix.Length, path.Length - Transactions.Const_MediaPrefix.Length - Transactions.Const_MediaPostfix.Length);
            string fname = Request.QueryString["media"].Substring(Request.QueryString["media"].LastIndexOf('/') + 1);
            fname = fname.Remove(fname.LastIndexOf('.'));
            string fext = path.Substring(path.LastIndexOf('.'));
            Response.ContentType = "application/octet-stream";
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + Server.UrlEncode(fname + fext) + "\"");
            Response.TransmitFile(Server.MapPath(path));
            Response.End();
        }
    }
}