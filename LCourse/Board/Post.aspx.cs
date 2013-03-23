using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Board
{
    public partial class Post : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            if (d.fav.Where(tf => tf.user.aspnetdb_uname == Page.User.Identity.Name && tf.post_id.ToString() == Request.QueryString["pid"]).Count() == 0)
            {
                ((HyperLink)FormView1.FindControl("AddFavLink")).NavigateUrl = string.Format("AddFav.aspx?pid={0}", Request.QueryString["pid"]);
            }
            else
            {
                ((HyperLink)FormView1.FindControl("AddFavLink")).Text = "已关注";
                ((HyperLink)FormView1.FindControl("AddFavLink")).NavigateUrl = string.Format("DelFav.aspx?pid={0}", Request.QueryString["pid"]);
            }

            this.Page.Title = "话题：" + d.post.First(tb => tb.id == Convert.ToInt32(Request.QueryString["pid"])).title + "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.reply.InsertOnSubmit(new reply
            {
                user = d.user.First(tu=>tu.aspnetdb_uname==Page.User.Identity.Name),
                post_id = Convert.ToInt32(Request.QueryString["pid"]),
                text = TextBox2.Text,
                time = DateTime.Now,
            });
            d.SubmitChanges();
            DataBind();
            var p = d.post.First(tp => tp.id == Convert.ToInt32(Request.QueryString["pid"]));
            foreach (var f in p.fav)
            {
                if (f.user.aspnetdb_uname == Page.User.Identity.Name)
                {
                    continue;
                }
                Transactions.SendEmail(d, "讨论区关注更新通知", d.user.First(tu => tu.aspnetdb_uname == Page.User.Identity.Name).showname + "回复了我关注的《" + p.title + "》", "他/她在其大作中提到<br/>" + Server.HtmlEncode(TextBox2.Text).Replace("\n", "<br/>") + "<br/>点击这里查看<a target='_blank' href='"+Transactions.Setting_SysRootURI+"Board/Post.aspx?pid="+Request.QueryString["pid"]+"'>"+p.title+"</a><br/>", f.user);
            }
            d.SubmitChanges();
            TextBox2.Text = "";
        }
    }
}