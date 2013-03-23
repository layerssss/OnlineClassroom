using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Test
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["tid"] != null)
                {
                    FileUpload1.Visible = Button2.Visible = false;
                    DataClasses1DataContext d = new DataClasses1DataContext();
                    var t = d.test.First(tt => tt.id == Convert.ToInt32(Request.QueryString["tid"]));
                    foreach (test_sub s in t.test_sub)
                    {
                        textData.Text += Microsoft.JScript.GlobalObject.escape(s.sort);
                        textData.Text += ",";
                        textData.Text += Microsoft.JScript.GlobalObject.escape(s.content);
                        textData.Text += ",";
                        textData.Text += Microsoft.JScript.GlobalObject.escape(s.options);
                        textData.Text += ";";
                    }
                    WidgetPanel1.Text = t.title;
                    WidgetPanel1.Controls.Clear();
                    WidgetPanel1.Controls.Add(new Literal() { Mode = LiteralMode.PassThrough, Text = t.content });
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "initTest", "$(function(){initTest();});", true);
                }
            }
            if (Request.QueryString["tid"] == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "initTest", "$(function(){$('#WidgetPanel2').hide();});", true);
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                var sr = new System.IO.StreamReader(FileUpload1.PostedFile.InputStream);
                this.textData.Text += sr.ReadToEnd();

            }
            Label1.Text = "目前已添加题集的数据长度：" + this.textData.Text.Length + "字节（可以添加多个习题集，系统会去掉不同习题集中重复的题目）";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.ContentType = "application/octet-stream";
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + Server.UrlEncode( DateTime.Today.ToShortDateString()) + ".test\"");
            Response.Write(textData.Text);
            Response.End();
        }
    }
}