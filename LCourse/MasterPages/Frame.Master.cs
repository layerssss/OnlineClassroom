using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.MasterPages
{
    public partial class Frame : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Literal1.Text = "当前访问人数：" + LCourse.Global.onlineCount;
            if (this.Page.Title != "")
            {
                this.Page.Title += '-';
            }
            this.Page.Title +=  Transactions.Setting_Title;
            if (Page.User.Identity.IsAuthenticated)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var user=d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name);
                Label1.Text = "欢迎！" + user.showname;

                #region 统计代码
                var sts = d.statics_item.Where(ts => ts.path == Request.Path.ToLower());
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


        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.Path) + "&Positive=true");
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            System.Web.Security.FormsAuthentication.SignOut();
            Response.Redirect(Request.RawUrl);
        }
    }
}