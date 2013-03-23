using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ICSharpCode.SharpZipLib.Zip;
using System.IO;
namespace LCourseConfiger
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlDataSource1.Insert();
            TextBox1.Text = "";
            TextBox3.Text = "";
            TextBox1.Focus();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            DataClasses1DataContext d = new DataClasses1DataContext();
            var di = new DirectoryInfo(Server.MapPath("/temp/cfg"));
            try
            {
                di.Delete(true);
            }
            catch { }
            di.Create();
            foreach (var config in d.config)
            {
                File.WriteAllText(di.FullName + "\\" + config.key, config.value);
            }
            FastZip fz = new FastZip();
            fz.Password = TextBox2.Text;
            fz.CreateZip(Server.MapPath("/LCourse.cfg"), Server.MapPath("/temp"), true, "");
            Response.Redirect("/LCourse.cfg");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                FileUpload1.PostedFile.SaveAs(Server.MapPath("/LCourse.cfg"));

                FastZip fz = new FastZip();
                fz.Password = TextBox2.Text;
                var di = new DirectoryInfo(Server.MapPath("/temp/cfg"));
                try
                {
                    di.Delete(true);
                }
                catch { }
                fz.ExtractZip(Server.MapPath("/LCourse.cfg"), Server.MapPath("/temp"), "");
                DataClasses1DataContext d = new DataClasses1DataContext();
                d.config.DeleteAllOnSubmit(d.config);
                d.SubmitChanges();
                foreach (var fi in Directory.GetFiles(Server.MapPath("/temp/cfg/")))
                {
                    string fname = (new FileInfo(fi)).Name;
                    d.config.InsertOnSubmit(new config() { key = fname, value = File.ReadAllText(fi) });
                }
                d.SubmitChanges();
                GridView1.DataBind();
            }
        }
    }
}
