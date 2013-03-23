using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
namespace LCourse.Private
{
    public partial class LoadDocumentMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Request.QueryString["path"].TrimStart('.');
            string type;
            try
            {
                type = path.Remove(path.IndexOf("/"));
            }
            catch
            {
                type = path;
            }
            if (!Page.User.Identity.IsAuthenticated && type != "课程概况")
            {
                Response.Redirect("/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
            }
            string[] dirs = Directory.GetDirectories(Server.MapPath("/Documents/" + path));
            bool notempty = false;
            List<string> ldirs=dirs.ToList();
            ldirs.Sort();
            dirs = ldirs.ToArray();
            foreach (string dir in dirs)
            {
                if (dir.Contains('.'))
                {
                    continue;
                }
                Panel p = new Panel();
                p.CssClass = "menu";
                Literal l = new Literal();
                string str=dir.Substring(dir.LastIndexOf('\\') + 1);
                l.Text = string.Format("<h2>{0}</h2>", str.Contains('-') ? str.Substring(str.IndexOf('-') + 1) : str);
                p.Controls.Add(l);
                Panel p1 = new Panel() { CssClass="menuContentTight"};
                p1.Controls.Add(new HyperLink()
                {
                    Text = "打开...",
                    NavigateUrl = "LoadDocumentMenu.aspx?path=" + Server.UrlEncode(path + "/" + str),
                    CssClass = "ajaxUrl"
                });
                p.Controls.Add(p1);
                Page.Controls.Add(p);
                notempty = true;
            }
            string[] files = Directory.GetFiles(Server.MapPath("/Documents/" + path));
            if (files.Length != 0)
            {
                notempty = true;
                Page.Controls.Add(new Literal() { Text = "<ul class=\"links\">" });
                foreach (string file in files)
                {
                    if (file.EndsWith(".flashpaper.version") || file.EndsWith(".flashpaper.swf"))
                    {
                        continue;
                    }
                    string fname = file.Substring(file.LastIndexOf('\\') + 1);
                    fname = fname.Remove(fname.LastIndexOf('.'));
                    Page.Controls.Add(new Literal() { Text = "<li>" });
                    string link= path + "/" + file.Substring(file.LastIndexOf('\\') + 1);
                    Page.Controls.Add(new HyperLink() { Text = fname.Contains('-') ? fname.Substring(fname.IndexOf('-') + 1) : fname, NavigateUrl = "/Documents/"+link,ToolTip=string.Format("Document.aspx?type={0}&path={1}",Server.UrlEncode(link.Remove(link.IndexOf('/'))),Server.UrlEncode(link)), CssClass = "ajaxLink" });
                    Page.Controls.Add(new Literal() { Text = "</li>" });
                }
                Page.Controls.Add(new Literal() { Text = "</ul>" });
            }
            if (!notempty)
            {
                Page.Controls.Add(new Literal() { Text = "(该分类是空的)" });
            }
        }
    }
}