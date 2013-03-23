using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.CourseWorks
{
    public partial class CourseWorks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList2.DataBind();
            FormView1.DataBind();
            GridView1.DataBind();
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {

            FormView1.DataBind();
            GridView1.DataBind();
        }
        public string GetSubmissionStatus(object obj)
        {
            var subs = (IEnumerable<coursework_submission>)obj;
            return string.Format("已完成人数:{0}；未完成人数：{1}；", subs.Count(ts => ts.content != ""), subs.Count(ts => ts.content == ""));
        }
        public static string GetUploadStatus(object user, object coursework)
        {
            var u = (user)user;
            var c = (coursework)coursework;
            if (c.uploadext == "")
            {
                return "不需要";
            }
            System.IO.FileInfo fi = new System.IO.FileInfo(Transactions.GetAbsSubmissionsUploadRoot() + u.@class.name + "\\" + c.title + "\\" + u.stno + u.showname + c.uploadext);
            if (fi.Exists)
            {
                return fi.LastWriteTime.ToString();
            }
            else
            {
                return "未上传";
            }
        }
        public static string GetUploadNav(object user, object coursework)
        {
            var u = (user)user;
            var c = (coursework)coursework;
            System.IO.FileInfo fi = new System.IO.FileInfo(Transactions.GetAbsSubmissionsUploadRoot() + u.@class.name + "\\" + c.title + "\\" + u.stno+u.showname+c.uploadext);
            if (fi.Exists)
            {
                return "/Admin/CourseWorks/GetUploads.aspx?path=" + HttpContext.Current.Server.UrlEncode(fi.FullName);
            }
            else
            {
                return "javascript:void(0);";
            }
        }

        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            var sid=d.coursework_submission.First(ts=>ts.id==(int)e.Keys[0]);
            Transactions.SendEmail(d, "作业批改通知", "老师批阅了我的作业", "作业标题：" + Server.HtmlEncode(sid.coursework.title) + "<br/>老师批阅：<br/>" + Server.HtmlEncode((string)e.NewValues["review"]).Replace("\n","<br/>") + "<br/><a target=\"_blank\" href=\"" + Server.HtmlEncode(Transactions.Setting_SysRootURI + "Courseworks/Coursework.aspx?sid=" + sid.id) + "\">查看</a>", sid.user);
            d.SubmitChanges();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function(){$(document.createElement(\"div\")).appendTo(\"body\").html(\"<br />" + Server.HtmlEncode("成功批阅并且已通过邮件通知了学生。") + "\").dialog({modal:true,title:'提示',buttons:{'确定':function(){$(this).dialog('close');}}});});", true);
        }
    }
}