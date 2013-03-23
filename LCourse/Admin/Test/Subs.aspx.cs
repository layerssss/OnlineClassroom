using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Test
{
    public partial class Subs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        string GetAvailableSort(int i,DataClasses1DataContext d,int tid,string format)
        {
            if (d.test_sub.Any(ts => ts.test_id == tid && ts.sort == i.ToString(format)))
            {
                return GetAvailableSort(i + 1, d, tid,format);
            }
            return i.ToString(format);
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            d.test_sub.InsertOnSubmit(new test_sub()
            {
                content = "新问题",
                sort = GetAvailableSort(1,d,Convert.ToInt32(Request.QueryString["tid"]),"d2"),
                test_id = Convert.ToInt32(Request.QueryString["tid"]),
                options = "A、\r\nB、\r\nC、\r\nD、\r\n"
            });
            d.SubmitChanges();
            ListView1.DataBind();
        }

        public string TransformOptionsString(string str,bool addHtmlTag)
        {
            string[] lines = str.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            string rstr = "";
            foreach (string line in lines)
            {
                if (addHtmlTag)
                {
                    if (line.StartsWith("o|"))
                    {
                        rstr += "<p style=\"color:green;font-weight:bold;\">"+Server.HtmlEncode(line.Substring(2)) + "</p>\r\n";
                    }
                    else
                    {
                        rstr += "<p>" + Server.HtmlEncode(line) + "</p>\r\n";
                    }
                }
                else
                {
                    if (line.StartsWith("o|"))
                    {
                        rstr += line.Substring(2) + "\r\n";
                    }
                    else
                    {
                        rstr += line + "\r\n";
                    }
                }
            }
            return rstr;
        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {
            string[] newlines = ((TextBox)ListView1.EditItem.FindControl("TextBoxOptions")).Text.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            string[] lines = ((HiddenField)ListView1.EditItem.FindControl("HiddenFieldOptions")).Value.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);
            DropDownList drop = (DropDownList)ListView1.EditItem.FindControl("DropDownListOptions");
            drop.Items.Clear();
            foreach (string newline in newlines)
            {
                drop.Items.Add(newline);
                foreach (string line in lines)
                {
                    if (line.StartsWith("o|"))
                    {
                        if (newline == line.Substring(2))
                        {
                            drop.SelectedIndex = drop.Items.Count - 1;
                        }
                    }
                }
            }
        }
        protected void TextBoxOptions_PreRender(object sender, EventArgs e)
        {
            TextBox2_TextChanged(null, null);
        }

        protected void ListView1_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
        }

        protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName != "Update") { return; }
            string str = "";
            foreach (ListItem item in ((DropDownList)ListView1.EditItem.FindControl("DropDownListOptions")).Items)
            {
                
                if (item.Selected)
                {
                    str += "o|";
                }
                str += item.Text + "\r\n";
            }
            ((HiddenField)ListView1.EditItem.FindControl("HiddenFieldOptions")).Value = str;
        }
    }
}