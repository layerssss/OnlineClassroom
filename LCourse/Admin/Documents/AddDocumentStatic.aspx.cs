using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Documents
{
    public partial class AddDocumentStatic : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DataClasses1DataContext d = new DataClasses1DataContext();
                string str;
                d.statics_item.InsertOnSubmit(new statics_item()
                {
                    path = "/private/document.aspx?type=" + Server.UrlEncode(Request.QueryString["type"]).ToLower() + "&path=" + Server.UrlEncode(Request.QueryString["type"] + "/" + Request.QueryString["path"]).ToLower(),
                    name = str=Request.QueryString["type"] + ":" + Request.QueryString["path"].Replace('/', '-')
                });
                d.SubmitChanges();
                throw (new Exception("统计项目“" + str + "”添加成功"));
            }
            catch(Exception ex) {
                Response.Write(ex.Message);
            }
        }
    }
}