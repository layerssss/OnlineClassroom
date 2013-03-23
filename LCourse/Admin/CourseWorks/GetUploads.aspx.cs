using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.CourseWorks
{
    public partial class GetUploads : System.Web.UI.Page
    {
        static Object ziplocker = new object();
        protected void Page_Load(object sender, EventArgs e)
        {
                var path = Request.QueryString["path"];
                if (path.EndsWith("\\"))
                {
                    if (!System.IO.Directory.Exists(path))
                    {
                        Response.Redirect("/Error.aspx?return=yes&message=" + Server.UrlEncode("目前没有人提交附件"));
                    }
                    lock (ziplocker)
                    {
                        ICSharpCode.SharpZipLib.Zip.FastZip f = new ICSharpCode.SharpZipLib.Zip.FastZip();
                        f.CreateZip(Server.MapPath("/Admin/package.zip"), path, true, "");
                        Response.ContentType = "application/octet-stream";
                        path = path.Remove(path.Length - 1);
                        Response.AddHeader("Content-Disposition", "attachment;filename=\"" + Server.UrlEncode(path.Substring(path.LastIndexOf('\\') + 1)) + ".zip\"");
                        Response.WriteFile(Server.MapPath("/Admin/package.zip"));
                    }
                }
                else
                {
                    Response.ContentType = "application/octet-stream";
                    Response.AddHeader("Content-Disposition", "attachment;filename=\"" + Server.UrlEncode(path.Substring(path.LastIndexOf('\\') + 1)) + "\"");
                    Response.TransmitFile(path);
                }
                
        }
    }
}