using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Private
{
    public partial class Document : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["type"] == null)
            {
                Response.Redirect("/");
            }
            string type = Request.QueryString["type"].TrimStart('.');
            if ((!Page.User.Identity.IsAuthenticated)&&type!="课程概况")
            {
                Response.Redirect("/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
            }
            this.Page.Title = type;
            this.Literal1.Text = type;
            HyperLink l = new HyperLink();
            l.CssClass = "ajaxUrl";
            l.NavigateUrl = "LoadDocumentMenu.aspx?path=" + Server.UrlEncode(Request.QueryString["type"]);
            l.Text = "打开...";
            this.Panel1.Controls.Add(l);
            if (Request.QueryString["path"] != null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "opendoc", "opendoc(\"" + Request.QueryString["path"] + "\");", true);
                return;
            }

            HiddenFieldModules.Value = Request.Path.ToLower() + "?type=" + Server.UrlEncode(type);
            ListViewModules.DataBind();

            if (Page.User.Identity.IsAuthenticated)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var user = d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name);


                #region 统计代码
                var sts = d.statics_item.Where(ts => ts.path == Request.Path.ToLower() + "?type=" + Server.UrlEncode(type).ToLower());
                if (sts.Any())
                {
                    foreach (var s in sts)
                    {
                        d.statics_visit.InsertOnSubmit(new statics_visit()
                        {
                            statics_item = s,
                            user_id = user.id
                        });
                    }
                    d.SubmitChanges();
                }

                #endregion
            }
        }
    }
}