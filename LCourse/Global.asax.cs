using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Diagnostics;
using System.Threading;
namespace LCourse
{
    public class Global : System.Web.HttpApplication
    {
        public static int onlineCount;
        public static string mailLog = "";
        void Application_Start(object sender, EventArgs e)
        {
            onlineCount = 0;
            this.checkMailThread = new Thread(checkMailThreadFunc);
            this.checkMailThread.Start();
        }
        Thread checkMailThread;
        void checkMailThreadFunc()
        {
            while (true)
            {
                lock (MailsToSend)
                {
                    if (MailsToSend.Count != 0)
                    {
                        using (System.Net.Mail.SmtpClient c = new System.Net.Mail.SmtpClient(Transactions.Setting_Mail_Host, Transactions.Setting_Mail_Port))
                        {
                            var mail = MailsToSend.Dequeue();
                            try
                            {
                                c.EnableSsl = Transactions.Setting_Mail_EnableSSL;
                                c.Credentials = new System.Net.NetworkCredential(Transactions.Setting_Mail_Username, Transactions.Setting_Mail_Password);
                                c.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                                c.Send(mail);
                                mail.Dispose();
                            }
                            catch (Exception ex)
                            {
                                mailLog += "[" + DateTime.Now.ToString() + "]尝试给" + mail.To[0].ToString() + "发送邮件时发生错误：" + ex.Message + "，已将该邮件重新加入队列<br/>";
                                MailsToSend.Enqueue(mail);
                            }
                        }
                    }
                }
                System.Threading.Thread.Sleep(100000);
            }
        }
        public static Queue<System.Net.Mail.MailMessage> MailsToSend=new Queue<System.Net.Mail.MailMessage>();
        void Application_End(object sender, EventArgs e)
        {
            //  在应用程序关闭时运行的代码
            this.checkMailThread.Abort();
        }

        void Application_Error(object sender, EventArgs e)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["ShowError"] != "true")
            {
                Exception ex = Server.GetLastError();
                // 在出现未处理的错误时运行的代码
                string err = Server.HtmlEncode(ex.ToString()).Replace("\n", "<br />");
                DataClasses1DataContext d = new DataClasses1DataContext();
                string userIP = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (userIP == null || userIP == "")
                {

                    //没有代理服务器,如果有代理服务器获取的是代理服务器的IP

                    userIP = Request.ServerVariables["REMOTE_ADDR"];

                }
                d.msg_error.InsertOnSubmit(new msg_error()
                {
                    content = err,
                    ip = userIP,
                    rawurl = Request.RawUrl,
                    time = DateTime.Now
                });
                d.SubmitChanges();
                Response.Redirect("/Error.aspx");
            }
        }

        void Session_Start(object sender, EventArgs e)
        {
            // 在新会话启动时运行的代码
            onlineCount++;
        }
        void Application_BeginRequest(object sender, EventArgs e)
        {
            if (Request.Path.ToLower().EndsWith(".media"))
            {
                Response.Redirect("/Private/DownloadMedia.aspx?media=" + Server.UrlEncode(Request.Path.Substring("/documents/".Length)));
            }

        }
        void Session_End(object sender, EventArgs e)
        {
            // 在会话结束时运行的代码。 
            // 注意: 只有在 Web.config 文件中的 sessionstate 模式设置为
            // InProc 时，才会引发 Session_End 事件。如果会话模式设置为 StateServer 
            // 或 SQLServer，则不会引发该事件。
            onlineCount--;
        }
    }
}
