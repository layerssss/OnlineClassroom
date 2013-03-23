using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Courseworks
{
    public partial class Coursework : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                var u=d.user.First(tu=>tu.aspnetdb_uname == Page.User.Identity.Name);
                coursework_submission s = d.coursework_submission.First(ts => ts.id == Convert.ToInt32(Request.QueryString["sid"]) && ts.user_id==u.id);
                this.Page.Title = "作业：" + s.coursework.title;
                WidgetPanelContent.Text = s.coursework.title;
                LiteralContent.Text = "<p>布置时间：" + s.coursework.time.ToString() + "</p>" + s.coursework.content;
                if (s.coursework.uploadext == "")
                {
                    WidgetPanelUpload.Visible = false;
                }
                else
                {
                    WidgetPanelUpload.Text = "我需要上传一个"+s.coursework.uploadext+"格式的附件(不能大于等于20M)";
                    HiddenFieldUpload.Value = s.coursework.uploadext;
                    HiddenFieldUploadPath.Value = u.@class.name + "\\" + s.coursework.title + "\\" + u.stno + u.showname + s.coursework.uploadext;
                }
                if (s.content == "")
                {
                    if (s.review == "")
                    {
                        WidgetPanelStatus.Text += "：未完成";
                        LiteralStatus.Text = "这个作业我还没有完成，应在老师批改之前完成该作业，别忘记写完后点击“提交”按钮。";
                        WidgetPanelReview.Visible = false;
                        string lup=LCourse.Admin.CourseWorks.CourseWorks.GetUploadStatus(u, s.coursework);
                        if (lup == "未上传")
                        {
                            LabelUpload.Text = "我还没有上传该附件。";
                        }
                        else
                        {
                            LabelUpload.Text = "我于" + lup + "已经上传了该附件，但是我现在还可以重新上传覆盖原来的文件。";
                        }
                    }
                    else
                    {
                        WidgetPanelStatus.Text += "：已超时";
                        LiteralStatus.Text = "这个作业我没有完成，但是老师已经批阅了。";
                        WidgetPanelSubmission.Visible = false;
                        LiteralReview.Text = Server.HtmlEncode(s.review).Replace("\n", "<br/>");

                        FileUpload1.Visible =ButtonUpload.Visible= false;
                        string lup = LCourse.Admin.CourseWorks.CourseWorks.GetUploadStatus(u, s.coursework);
                        if (lup == "未上传")
                        {
                            LabelUpload.Text = "我还没有上传该附件，现在已经不可以上传。";
                        }
                        else
                        {
                            LabelUpload.Text = "我于" + lup + "上传了该附件。";
                        }
                    }
                }
                else
                {
                    if (s.review == "")
                    {
                        WidgetPanelStatus.Text += "：等待批阅";
                        LiteralStatus.Text = "这个作业我已经完成或者完成一部分了，但是老师还没有批阅，在老师批阅之前，我可以更改我的回答，别忘记更改完之后点击“提交”按钮";
                        WidgetPanelReview.Visible = false;
                        TextBoxSubmission.Text = s.content;
                        string lup = LCourse.Admin.CourseWorks.CourseWorks.GetUploadStatus(u, s.coursework);
                        if (lup == "未上传")
                        {
                            LabelUpload.Text = "我还没有上传该附件。";
                        }
                        else
                        {
                            LabelUpload.Text = "我于" + lup + "已经上传了该附件，但是我现在还可以重新上传覆盖原来的文件。";
                        }
                    }
                    else
                    {
                        WidgetPanelStatus.Text += "：已批阅";
                        LiteralStatus.Text = "这个作业我已经完成，并且老师已经批阅。";
                        TextBoxSubmission.Visible = LinkButtonSubmission.Visible = false;
                        LiteralSubmission.Text = Server.HtmlEncode(s.content).Replace("\n", "<br/>");
                        LiteralReview.Text = Server.HtmlEncode(s.review).Replace("\n", "<br/>");
                        FileUpload1.Visible = ButtonUpload.Visible = false;
                        string lup = LCourse.Admin.CourseWorks.CourseWorks.GetUploadStatus(u, s.coursework);
                        if (lup == "未上传")
                        {
                            LabelUpload.Text = "我还没有上传该附件，现在已经不可以上传。";
                        }
                        else
                        {
                            LabelUpload.Text = "我于" + lup + "已经上传了该附件，但是我现在还可以重新上传覆盖原来的文件。";
                        }
                    }
                }
            }
        }

        protected void LinkButtonSubmission_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            coursework_submission s = d.coursework_submission.First(ts => ts.id == Convert.ToInt32(Request.QueryString["sid"]) && ts.user.aspnetdb_uname == Page.User.Identity.Name && ts.review == "");
            s.content = TextBoxSubmission.Text;
            d.SubmitChanges();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "$(function(){$(document.createElement(\"div\")).appendTo(\"body\").html(\"<p>" + Server.HtmlEncode("已成功提交作业。") + "</p>\").dialog({modal:true,title:'提示',buttons:{'确定':function(){location.href=location.href;}}});});", true);
        }

        protected void ButtonUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                if (FileUpload1.PostedFile.FileName.ToLower().EndsWith(HiddenFieldUpload.Value.ToLower()))
                {
                    if (FileUpload1.PostedFile.ContentLength < 20 * 1024 * 1024)
                    {
                        var fi = new System.IO.FileInfo(Transactions.GetAbsSubmissionsUploadRoot() + HiddenFieldUploadPath.Value);
                        if (!fi.Directory.Exists)
                        {
                            if (!fi.Directory.Parent.Exists)
                            {
                                fi.Directory.Parent.Create();
                            }
                            fi.Directory.Create();
                        }
                        FileUpload1.PostedFile.SaveAs(fi.FullName);
                        Transactions.MessageBox(this.Page, "附件上传成功", "location.href=location.href;", "提示");
                    }
                    else
                    {
                        Transactions.MessageBox(this.Page, "你选择的文件超过了20M", "", "附件上传失败");
                    }
                }
                else
                {
                    Transactions.MessageBox(this.Page, "你只能上传一个"+HiddenFieldUpload.Value+"格式的文件", "", "附件上传失败");
                }
            }
            else
            {
                Transactions.MessageBox(this.Page, "你没有选择任何文件", "", "附件上传失败");
            }
            
        }
    }
}