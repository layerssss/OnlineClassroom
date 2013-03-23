using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Messages
{
    public partial class SmtpLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["act"] != null && Request.QueryString["act"] =="del")
            {
                lock (Global.MailsToSend)
                {
                    var l = Global.MailsToSend.ToList();
                    l.RemoveAll(tm => tm.To[0].ToString() == Request.QueryString["to"]);
                    Global.MailsToSend.Clear();
                    l.ForEach(tm =>
                    {
                        Global.MailsToSend.Enqueue(tm);
                    });
                }
            }
            foreach (var mail in Global.MailsToSend) {
                Panel p = new Panel();
                p.Controls.Add(new HyperLink() { Text = "删除该收件人的所有邮件", NavigateUrl = "SmtpLog.aspx?act=del&to=" + Server.UrlEncode(mail.To[0].ToString()) });
                p.Controls.Add(new Literal() { Text = "收件人:" + mail.To[0] + ";主题:" + mail.Subject + ";大小:" + mail.Body.Length });
                WidgetPanel2.Controls.Add(p);
            }
            Literal1.Text = Global.mailLog;
        }
    }
}