using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Diagnostics;

namespace LCourse.Private
{
    public partial class LoadDocument : System.Web.UI.Page
    {
        static public string[] redirectType = new string[] { "mht", "html", "htm" };
        static public string[] flashType = new string[] { "swf" };
        static public string[] mediaType = new string[] { "media" };
        static public string[] mediaContentType = new string[] { "avi", "mov", "mpg", "mkv", "mp4", "flv", "wmv", "ac3", "mp3", "wma", "rm", "rmvb" };
        static public string[] imageType = new string[] { "bmp", "png", "jpg", "jpeg", "gif", "tif" };
        static public string[] iframeType = new string[] { "pdf", "txt" };
        static public string[] docType = new string[] { "xls", "xlsx", "doc", "docx", "ppt", "pptx", "pdf" };
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = Request.QueryString["path"].TrimStart('.').TrimStart('/');
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
            string ext = path.Substring(path.LastIndexOf('.') + 1);
            ext = ext.ToLower();
            Literal3.Text = path.Substring(path.IndexOf("/")).Replace('/', '\\');
            HyperLink1.NavigateUrl = "/Documents/" + path;
            #region 统计代码
            if (Page.User.Identity.IsAuthenticated)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var user = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name);

                var sts = d.statics_item;
                string allstr=("/private/document.aspx?type=" + Server.UrlEncode(type).ToLower() + "&path=" + Server.UrlEncode(path).ToLower());
                    foreach (var s in sts)
                    {
                        if (!allstr.StartsWith(s.path))
                        {
                            continue;
                        }
                        d.statics_visit.InsertOnSubmit(new statics_visit()
                        {
                            statics_item = s,
                            user_id = user.id
                        });
                    }
                    d.SubmitChanges();
            }
            #endregion

            if (imageType.Contains(ext))
            {
                Image img = new Image()
                {
                    CssClass = "",
                    ImageUrl = "/Documents/" + path
                };
                HyperLink1.Text = "下载/查看";
                this.Panel1.Controls.Add(img);
                this.Panel1.CssClass = "iframeContent";
                this.Panel1.Attributes.Add("style", "overflow:scroll;");
                HyperLink1.Target = "_blank";
            }
            else
            {
                if (docType.Contains(ext))
                {
                    string version = File.GetLastWriteTime(Server.MapPath("/Documents/" + path)).ToString();
                    try
                    {
                        if (File.ReadAllText(Server.MapPath("/Documents/" + path + ".flashpaper.version")) != version)
                        {
                            throw (new Exception());
                        }
                        path += ".flashpaper.swf";
                    }
                    catch
                    {
                        DataClasses2DataContext d2 = new DataClasses2DataContext();
                        d2.request.InsertOnSubmit(new request()
                        {
                            path = Server.MapPath("/Documents/" + path)
                        });
                        d2.SubmitChanges();
                        path = "converting.ppt.flashpaper.swf";
                    }
                    ext = "swf";
                }
                if (flashType.Contains(ext))
                {
                    Literal4.Text = string.Format("<object class=\"iframeContent\" data=\"{0}\" type=\"application/x-shockwave-flash\" ><param name=\"movie\" value=\"{0}\" /><param name=\"wmode\" value=\"transparent\"/></object> ", "/Documents/" + path);
                    if (Literal3.Text.EndsWith(ext))
                    {
                        HyperLink1.Target = "_blank";
                    }
                }
                else
                {
                    if (mediaType.Contains(ext))
                    {
                        string[] strs = File.ReadAllLines(Server.MapPath("/Documents/" + path));
                        string str = strs[0].Substring(Transactions.Const_MediaPrefix.Length, strs[0].Length - Transactions.Const_MediaPrefix.Length - Transactions.Const_MediaPostfix.Length);
                        Literal4.Text = string.Format("<div class=\"iframeContent\"><a id=\"mediaholder\" class=\"mediaholder\" href=\"{0}\">无法播放当前文件，您可以点此下载该文件</a></div>",str);
                        HyperLink1.NavigateUrl = string.Format("DownloadMedia.aspx?media={0}", Server.UrlEncode(path));
                        string fname = path.Substring(path.LastIndexOf('/') + 1);
                        fname = fname.Remove(fname.LastIndexOf('.'));
                        path = path.Substring(path.IndexOf('/'));
                        string fext = str.Substring(str.LastIndexOf('.'));
                        path = path.Remove(path.LastIndexOf('/') + 1).Replace('/', '\\');
                        Literal3.Text = path + fname + fext;
                    }
                    else
                    {

                        if (iframeType.Contains(ext))
                        {
                            Literal4.Text = string.Format("<iframe class=\"iframeContent\" src=\"{0}\" />", "/Documents/" + path);
                            HyperLink1.Target = "_blank";
                        }
                        else
                        {

                            if (redirectType.Contains(ext))
                            {
                                Response.Redirect("/Documents/" + path);
                            }
                            Label l = new Label()
                            {
                                CssClass = "ui-state-error",
                                Text = "该文件不能在线查看，请下载后查看"
                            };
                            this.Panel1.Controls.Add(l);
                            HyperLink1.Target = "_blank";
                        }
                    }

                }
            }
        }
    }
}