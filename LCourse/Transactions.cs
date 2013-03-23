using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
namespace LCourse
{
    public class Transactions
    {
        public static void SendEmail(DataClasses1DataContext d, string type, string title, string subject, user u)
        {
            title = "【"+Transactions.Setting_Mail_TitlePrefix+"】" + title;
            subject += "<br/>注意：这是一封由系统自动发出去的通知邮件，请勿直接回复！<br/>";
            System.Web.Security.MembershipUser mu = System.Web.Security.Membership.GetUser(u.aspnetdb_uname);
            var msg = new msg_mails()
            {
                email = u.mail,
                subject = subject,
                time = DateTime.Now,
                title = title,
                type = type,
                user_id = u.id
            };
            d.msg_mails.InsertOnSubmit(msg);
            lock (Global.MailsToSend)
            {
                try
                {
                    Global.MailsToSend.Enqueue(new System.Net.Mail.MailMessage(Transactions.Setting_Mail_Sender, u.mail, title, subject) { IsBodyHtml = true });
                }
                catch
                {
                    Global.mailLog += "[" + DateTime.Now.ToString() + "]学生" + u.showname + "的邮件地址“" + HttpContext.Current.Server.HtmlEncode(u.mail) + "”不是合法的邮件地址，没有发送邮件！<br/>";
                    msg.title+= "（不能接受的邮件地址，未发送）";
                    msg.email += "（未发送）";
                }
            }
        }
        public static string GetAbsSubmissionsUploadRoot()
        {
            return HttpContext.Current.Server.MapPath("/Submissions/");
        }
        public static SettingCollection AppSettings = SettingCollection.Build();
        public static string Setting_Title = AppSettings["Setting_Title"];
        public static string Setting_SysRootURI = AppSettings["Setting_SysRootURI"];
        public static string Setting_Mail_TitlePrefix = AppSettings["Setting_Mail_TitlePrefix"];
        public static string Setting_Mail_Host = AppSettings["Setting_Mail_Host"];
        public static int Setting_Mail_Port = Convert.ToInt32(AppSettings["Setting_Mail_Port"]);
        public static string Setting_Mail_Username = AppSettings["Setting_Mail_Username"];
        public static string Setting_Mail_Password = AppSettings["Setting_Mail_Password"];
        public static string Setting_Mail_Sender = AppSettings["Setting_Mail_Sender"];
        
        public static bool Setting_Mail_EnableSSL = Convert.ToBoolean(AppSettings["Setting_Mail_EnableSSL"]);
        public static int Setting_FlashPaper_Timeout = Convert.ToInt32(AppSettings["Setting_FlashPaper_Timeout"]);
        public static string Setting_FlashPaper_Username = AppSettings["Setting_FlashPaper_Username"];
        public static string Setting_FlashPaper_Password = AppSettings["Setting_FlashPaper_Password"];
        
        public static string Const_MediaPrefix="<a href=\"";
        public static string Const_MediaPostfix= "\">下载</a>";
        public static void MessageBox(System.Web.UI.Control control,string html,string jscallback,string title)
        {
            System.Web.UI.ScriptManager.RegisterStartupScript(control, control.GetType(), "alert", "$(function(){msgBox('" + html + "',function(){ " + jscallback + "}, '" + title + "');});", true);
        }
    }
    public class SettingCollection
    {
        public static SettingCollection Build()
        {
            ICSharpCode.SharpZipLib.Zip.FastZip fz = new ICSharpCode.SharpZipLib.Zip.FastZip();
            fz.Password = "LCourse";
            fz.ExtractZip(HttpRuntime.AppDomainAppPath+"app_data\\LCourse.cfg", HttpRuntime.AppDomainAppPath+"app_data\\", "");
            return new SettingCollection();
        }
        public string this[string key]
        {
            get
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                try
                {
                    
                    return System.IO.File.ReadAllText(HttpRuntime.AppDomainAppPath+"app_data\\cfg\\" + key );
                }
                catch
                {
                    return "";
                }
            }
        }

    }
}