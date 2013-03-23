using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["message"] == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function () {msgBox(\"不要急，不要急，出现这个错误可能是因为你：<br/>点击了一个过时的链接<br/>输入了一些服务器接受不了数据<br/>……或者我们的程序本身存在问题<br/><br/>不管怎样，系统已经记录下本次错误的详细信息到错误消息日志里。<br/>如果一直出现此信息，请通知系统管理员。\", function () { history.go(-1); }, \"出错啦！出错啦！\", function (option) { option.width = 500; option.buttons[\"后退\"] = option.buttons[\"确定\"]; option.buttons[\"确定\"] = undefined; });});", true);
            }
            else
            {
                if (Request.QueryString["return"] == null)
                {
                    Transactions.MessageBox(this.Page, Server.HtmlEncode(Request.QueryString["message"]), "window.close();", "错误");
                }
                else
                {
                    Transactions.MessageBox(this.Page, Server.HtmlEncode(Request.QueryString["message"]), "history.go(-1);;", "错误");
                }
            }
        }
    }
}