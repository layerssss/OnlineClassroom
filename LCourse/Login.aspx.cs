using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    UrlReferrer.Text = Request.UrlReferrer.PathAndQuery;
                }
                catch { }
                if (Request.QueryString["Positive"] == null&&Request.QueryString["ReturnUrl"]!=null)
                {
                    string path=Request.QueryString["ReturnUrl"].TrimEnd('?').ToLower();
                    if (path.EndsWith("/"))
                    {
                        path += "default.aspx";
                    }
                    if (Request.QueryString["ReturnUrl"] == null)
                    {
                        return;
                    }
                    DataClasses1DataContext d = new DataClasses1DataContext();
                    var ls = d.module_location.Where(tl => tl.path == path);
                    string lname = "未知页面";
                    if (ls.Any())
                    {
                        lname = ls.First().name;
                    }
                    if (Page.User.Identity.IsAuthenticated)
                    {
                        lname = "您当前的权限不能访问“" + lname + "”。";
                    }
                    else
                    {
                        lname = "您当前正尝试访问“" + lname + "”，该页面必须登录后才能访问。";
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function(){$(document.createElement(\"div\")).appendTo(\"body\").html(\"<p>" + Server.HtmlEncode(lname) + "</p>\").dialog({modal:true,title:'提示',buttons:{'确定':function(){$(this).dialog('close');}}});});", true);
                }
            }
        }

        protected void Login23_LoggingIn(object sender, LoginCancelEventArgs e)
        {
            var err = (Label)this.Login23.FindControl("FailureText");
            try
            {
                if (((string)Session["checkcode"]).ToLower() != ((TextBox)this.Login23.FindControl("CheckCode")).Text.ToLower())
                {
                    
                    err.Text = "验证码错误";
                    err.Visible = true;
                    e.Cancel = true;
                    return;
                }
            }
            catch
            {
                err.Text = "验证码超时";
                err.Visible = true;
                e.Cancel = true;
                return;
            }
        }
    }
}