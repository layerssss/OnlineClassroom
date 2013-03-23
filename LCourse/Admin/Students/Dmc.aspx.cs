using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LCourse.Admin.Students
{
    public partial class Dmc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            this.DropDownList1.Items.Clear();
            this.DropDownList2.Items.Clear();
            this.DropDownList3.Items.Clear();
            var lines = TextBox3.Text.Split(new[] { "\n" }, StringSplitOptions.RemoveEmptyEntries);
            var allf = new Dictionary<int, List<string>>();
            for (var line = 0; line < lines.Length&&line<10;line++ )
            {
                var fields = lines[line].Split(new[]{"\t"},StringSplitOptions.RemoveEmptyEntries);
                if (fields.Length < 4)
                {
                    continue;
                }
                for (var field = 0; field < fields.Length; field++)
                {
                    if (!allf.ContainsKey(field))
                    {
                        allf[field] = new List<string>();
                    }
                    allf[field].Add(fields[field]);
                }
            }
            this.DropDownList1.Items.AddRange(allf.Select(kvp => new ListItem() { Text = kvp.Value.Aggregate((str1,str2)=>str1+";"+str2), Value = kvp.Key.ToString() }).ToArray());
            this.DropDownList2.Items.AddRange(allf.Select(kvp => new ListItem() { Text = kvp.Value.Aggregate((str1, str2) => str1 + ";" + str2), Value = kvp.Key.ToString() }).ToArray());
            var maxcount = 0;
            this.DropDownList3.Items.AddRange(allf.Select(kvp => new ListItem() { Text = kvp.Value.Aggregate((str1, str2) => str1 + ";" + str2), Value = kvp.Key.ToString() }).ToArray());
            foreach (var kvp in allf)
            {
                if (kvp.Value.Count(ts => ts.Length == 10) > 4)
                {
                    this.DropDownList2.SelectedValue = kvp.Key.ToString();
                }
                if (kvp.Value.Count(ts => ts.Length > 1 && ts.Length < 5) > 4)
                {
                    if (kvp.Value.Distinct().Count() > maxcount)
                    {
                        this.DropDownList1.SelectedValue = kvp.Key.ToString();
                        maxcount = kvp.Value.Distinct().Count();
                    }
                }
                if (kvp.Value.Count(ts => new[] { "电子", "计算", "信息", "软件" }.Any(tkey => ts.Contains(tkey))) > 4)
                {

                    this.DropDownList3.SelectedValue = kvp.Key.ToString();
                }
            }
            this.TextBox1.Text = DateTime.Now.Year.ToString().Substring(2);
            this.TextBox1.Text += DateTime.Now.Month < 7 ? "上" : "下";
            this.Button1.Enabled = true;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            this.TextBox2.Text = "";
            var istno = Convert.ToInt32(this.DropDownList2.SelectedValue);
            var istname = Convert.ToInt32(this.DropDownList1.SelectedValue);
            var iclass = Convert.ToInt32(this.DropDownList3.SelectedValue);
            var c = new List<string>();
            DataClasses1DataContext d = new DataClasses1DataContext();
            foreach(var line in  TextBox3.Text.Split(new[] { "\n" }, StringSplitOptions.RemoveEmptyEntries)){
                try
                {
                    var fields = line.Split(new[] { "\t" }, StringSplitOptions.RemoveEmptyEntries);
                    var stno = fields[istno];
                    var stname = fields[istname];
                    var clas = this.TextBox1.Text+ fields[iclass];
                    if (stno.Length != 10)
                    {
                        throw (new Exception());
                    }
                    if (!d.@class.Any(tc => tc.name == clas)&&!c.Contains(clas))
                    {
                        this.TextBox2.Text += "添加班级\t" + clas + "\r\n";
                        c.Add(clas);
                    }

                    this.TextBox2.Text += "添加学生\t学号\t" + stno + "\t姓名\t" + stname + "\t到班级\t" + clas + "\r\n";



                }
                catch { }
            }
            this.Button2.Enabled = true;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            var d = new DataClasses1DataContext();
            foreach (var cmd in TextBox2.Text.Split(new[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries)){
                var f = cmd.Split(new[] { "\t" }, StringSplitOptions.RemoveEmptyEntries);
                switch (f[0])
                {
                    case "添加学生":
                        if (d.stdprof.Any(ts => ts.name == f[4]) || d.user.Any(tu => tu.showname == f[4]))
                        {
                            continue;
                        }
                        d.stdprof.InsertOnSubmit(new stdprof(){@class=d.@class.First(tc=>tc.name==f[6]),
                            name=f[4],
                            stdno=f[2]});
                        break;
                    case "添加班级":
                        d.@class.InsertOnSubmit(new @class()
                        {
                            name = f[1]
                        });
                        d.SubmitChanges();
                        break;
                }
            }
            d.SubmitChanges();
            Transactions.MessageBox(this, "添加成功", "location.href='Students.aspx';", "添加成功");
        }
    }
}